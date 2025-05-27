use [CASAS RURALES]

--CREAR UNA FUNCION QUE TE DEVUELVE LOS ALOJAMIENTOS DONDE SE ORGANIZA UNA ACTIVIDAD
--PASADA POR PAR�METRO
--CREAR UN PROCEDIMIENTO ALMACENADO QUE AUMENTA EL PRECIO DE UNA HABITACI�N
--(PASADA POR PAR�METRO JUNTO EL ALOJAMIENTO)
--EL PRECIO PASADO POR PAR�METRO
--Crear un trigger en el que el sistema tome el control a la hora de actualizar
--las Habitaciones y tenga en cuenta que el precio de las habitaciones sin ba�o
--no pueden superar el precio de las que tienen ba�o del mismo alojamiento
--Crear un procedimiento temporal que suba el precio 5 pavines de todas las habitaciones sin ba�o
--que organicen una actividad de dificultad 4

go
create function fn_findAlojamientos(@actividad int)
returns table
as
return 
	(select isnull(al.idAlojamiento, 0) [idAlojamientos] from Alojamientos al
	  inner join Organizar o on o.idAlojamiento = al.idAlojamiento
	  where o.idActividad = @actividad)

------------------------------------------------------------------------------

create procedure pa_aumentarPrecio
@idAlojamiento int, @idHabitacion int, @precio decimal(5,2)
as
BEGIN

	SET NOCOUNT ON;

	begin try

		BEGIN TRAN 


  
IF NOT EXISTS (SELECT 1 FROM habitaciones WHERE idHabitacion = @idHabitacion)
  BEGIN
	ROLLBACK TRAN;
  	THROW 50001, 'La habitaci�n no existe.', 1;
  END

if (@precio <= 0) 
  BEGIN
	ROLLBACK TRAN;
    THROW 50002, 'Precio surrealista.', 1;
  END

IF NOT EXISTS (SELECT 1 FROM alojamientos WHERE idAlojamiento = @idAlojamiento)
  BEGIN
	ROLLBACK TRAN;
  	THROW 50003, 'El alojamiento no existe.', 1;
  END

update habitaciones
set precio = precio + @precio
where idHabitacion = @idHabitacion and idAlojamiento = @idAlojamiento
    
COMMIT TRAN 

print 'Datos actualizados correctamente'
    
end try 
begin catch

  print 'Hubo un error: ' + ERROR_MESSAGE() + ' en la l�nea ' + CAST(ERROR_LINE() AS VARCHAR);
  ROLLBACK TRAN
  
	end catch
END

------------------------------------------------------------------------------

create function fn_comparePrecio(@alojamiento int, @precio decimal(5,2))
returns bit
as
BEGIN

declare @resultado bit

if exists (select idhabitacion from habitaciones 
    where idalojamiento = @alojamiento
    and precio < @precio) set @resultado = 1
    ELSE set @resultado = 0

	return @resultado;
END

------------------------------------------------------------------------------
    
create trigger tr_checkPrecio
on habitaciones
after update
as
BEGIN

  declare @precio decimal(5,2), @alojamiento int, @habitacion int



select
    @precio = precio,
    @habitacion=  idhabitacion,
    @alojamiento = idAlojamiento 
    from inserted

IF ((select TOP 1 ba�o from habitaciones where idhabitacion = @habitacion) = 'n') 
    begin
    
if (dbo.fn_comparePrecio(@alojamiento, @precio) = 0)
    BEGIN
      print 'Datos correctos.'
    END
else
    BEGIN
      print 'No puede existir una habitaci�n sin ba�o con precio superior a una con ba�o.'
      ROLLBACK
    END
    
    end
END

------------------------------------------------------------------------------

create procedure pa_checkNivelActividad
as
BEGIN

update habitaciones
set precio = precio + 5
where ba�o = 'n' and 
(idAlojamiento in (select al.idAlojamiento from actividades ac
inner join Organizar o on o.idActividad = ac.idActividad
inner join alojamientos al on al.idalojamiento = o.idalojamiento where ac.dificultad >= 4)
)

drop procedure pa_checkNivelActividad

END

--select * From dbo.fn_findAlojamientos(1)

