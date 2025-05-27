use [CASAS RURALES]

--CREAR UNA FUNCION QUE TE DEVUELVE LOS ALOJAMIENTOS DONDE SE ORGANIZA UNA ACTIVIDAD
--PASADA POR PARÁMETRO
--CREAR UN PROCEDIMIENTO ALMACENADO QUE AUMENTA EL PRECIO DE UNA HABITACIÓN
--(PASADA POR PARÁMETRO JUNTO EL ALOJAMIENTO)
--EL PRECIO PASADO POR PARÁMETRO
--Crear un trigger en el que el sistema tome el control a la hora de actualizar
--las Habitaciones y tenga en cuenta que el precio de las habitaciones sin baño
--no pueden superar el precio de las que tienen baño del mismo alojamiento
--Crear un procedimiento temporal que suba el precio 5 pavines de todas las habitaciones sin baño
--que organicen una actividad de dificultad 4

go
create function fn_findAlojamientos(@actividad int)
returns table
as
BEGIN

if not exists (select idactividad from actividades where idActividad = @actividad) return 0

return (select isnull(al.idAlojamiento, 0) [idAlojamientos] from Alojamientos al
  inner join Organizar on or.idAlojamiento = al.idAlojamiento
  where or.idActividad = @actividad)
END



  
create procedure pa_aumentarPrecio
as
@idHabitacion int, @precio decimal(5,2)
BEGIN

BEGIN T1

begin try 
  
if not exists (select idhabitacion from habitaciones where idHabitacion = @idHabitacion) 
  BEGIN
    RAISERROR('La habitación no existe.', 16, 1);
  END

if (@precio <= 0) 
  BEGIN
    RAISERROR('Precio surrealista.', 16, 1);
  END

update habitaciones
set precio = precio + @precio
where idHabitacion = @idHabitacion
    
COMMIT T1

print 'Datos actualizados correctamente'
    
end try begin catch

  print 'Hubo un error: ' + ERROR_MESSAGE();
  ROLLBACK T1
  
end catch
END

create function fn_comparePrecio(@alojamiento int, @precio decimal(5,2))
returns bit
as
BEGIN
if exists (select idhabitacion from habitaciones 
    where idalojamiento = @idalojamiento
    and precio < @precio) return 1
    ELSE return 0
END
    
create trigger tr_checkPrecio
on habitaciones
after update
as
BEGIN

  declare @precio decimal(5,2), @alojamiento int

select
    @precio = precio,

    @habitacion = (select idhabitacion from habitaciones
    where idhabitacion = (select idhabitacion from inserted)),
    
    @alojamiento = (select idalojamiento from habitaciones ha
    inner join inserted i on i.idalojamiento = ha.idalojamiento)
    from inserted

IF ((select baño from habitaciones where idhabitacion = @idhabitacion) = 'n') 
    begin
    
if (dbo.fn_comparePrecio(@alojamiento, @precio) = 0 and)
    BEGIN
      print 'Datos correctos.'
    END
else
    BEGIN
      print 'No puede existir una habitación sin baño con precio superior a una con baño.'
      ROLLBACK
    END
    
    end
END

create procedure pa_checkNivelActividad
as
BEGIN

update habitaciones
set precio = precio + 5
where baño = 'n' and
(select ac.dificultad from actividades ac
inner join alojamiento al on al.idalojamiento = ac.idalojamiento) > 4

  drop procedure pa_checkNivelActividad
END






