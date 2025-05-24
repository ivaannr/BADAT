use [CASAS RURALES]

--Crear el procedimiento pa_registrarTrabajadorActividad
--A este procedimiento se le pasaran por parámetro:
--1- Un ID de un trabajador
--2- El ID de una actividad
--Se deberá comprobar que tanto el trabajador como la actividad existen
--y tras eso se procederá a insertar los valores en la tabla organizar
--Para ello se crearán las funciones fn_Personal() y fn_Actividad()
--que pasándoles el ID de el trabajador o actividad comprobaran si éste
--existe en la BDD o no.
--Después de comprobar si los datos que se le pasa por parámetro al
--procedimiento son válidos se procederá a obtener el día de la actividad,
--que se obtendrá con la función GETDATE()
--Para terminar se deberá crear el trigger tr_checkInsert, que después de insertar
--datos comprobará que el alojamiento y la actividad son válidos, para a continuación
--borrar el registro y volver a insertarlo.
--Se debe usar un bloque try-catch para manejar errores dentro del trigger para que
--en caso de que haya un error mostrar el mensaje de éste.
--También puedes crear tus propios errores.


/*
Creamos la función que comprueba si un trabajador (qué no esté dado de baja)
existe
*/
go
create function fn_Personal (@idtrabajador int)
returns int
as
begin

declare @resultado int


--Cuenta los registros que coindicen con los datos proporcionados del trabajador
--Si no existe ninguno, devuelve 0

set @resultado = (select isnull(count(*), 0) from personal p inner join Trabajar t
					on t.idTrabajador = p.idTrabajador
					where p.idTrabajador = @idtrabajador	
					and t.fecBaja is null)

return @resultado

end

/*
Creamos la función que comprueba que una actividad existe
*/
go
create function fn_Actividad (@idactividad int)
returns int
as
begin

declare @resultado int

--Cuenta los registros que coindicen con los datos proporcionados de la actividad
--Si no existe ninguno, devuelve 0
set @resultado = (select isnull(count(*), 0) from Actividades where idActividad = @idactividad)

return @resultado

end


/*
Esta función, al pasarle un número del mes te devuelve
su equivalente en día de la semana
*/
go
create function fn_getDia (@numDia int)
returns nvarchar(9)
as
BEGIN

declare @nombreDia nvarchar(9)


--si el día no está comprendido entre 1 y 7 
--devuelve que el día no es válido
if (@numDia not between 1 and 7)
	return 'No válido'

set @nombreDia = 
        CASE @numDia
            WHEN 1 THEN 'Lunes'
            WHEN 2 THEN 'Martes'
            WHEN 3 THEN 'Miércoles'
            WHEN 4 THEN 'Jueves'
            WHEN 5 THEN 'Viernes'
            WHEN 6 THEN 'Sábado'
            WHEN 7 THEN 'Domingo'
end
	
return @nombreDia
	
END

--Ahora creamos el procedimiento																																																																																																																																																																						
go
create procedure pa_registrarTrabajadorActividad
@idtrabajador int, @idactividad int
as
begin


begin try --Empezamos el try

if (dbo.fn_Personal(@idtrabajador) = 0) 
		RAISERROR('El trabajador no existe.', 16, 1); -- Si el trabajador no existe da error y sale por el catch

if (dbo.fn_Actividad(@idactividad) = 0)
		RAISERROR('La actividad no existe.', 16, 1); -- Si la actividad no existe da error y sale por el catch


declare @alojTrabajador int, @dia nvarchar(9)

select TOP 1 @alojTrabajador = idalojamiento from Trabajar where idTrabajador = @idtrabajador --Sacamos el alojamiento del trabajador

set @dia = dbo.fn_getDia(DATEPART(weekday, GETDATE())); --Sacamos el día de la semana

if (@dia like '%No válido%') --Comprobamos que el día es válido
	RAISERROR('Se ha introducido un día no válido.', 16, 1)

insert into Organizar (idActividad, idAlojamiento, dia) --Insertamos los datos
	values (
	@alojTrabajador,
	@idactividad, 
	@dia)

	print 'Datos introducidos correctamente!'

end try begin catch

	print 'Hubo un error: ' + ERROR_MESSAGE() --Si ocurre un error se mostrará este mensaje

end catch

END



--Creamos el trigger
go
create trigger tr_checkInsert
on organizar
after insert
as
BEGIN

declare @idalojamiento int, @idactividad int, @dia nvarchar(9)

select --Sacamos los datos necesarios
	@idalojamiento = idAlojamiento,
	@idactividad = idActividad,
	@dia = dia
	from inserted

begin try

IF (@idalojamiento not in (select idalojamiento from Alojamientos)) --Comprobamos si existe el alojamiento y si no existe sale por el catch
	BEGIN
		RAISERROR('Ese alojamiento no existe.', 16, 1);
	END

IF (dbo.fn_Actividad(@idactividad) = 0) --Comprobamos si existe la actividad y si no existe sale por el catch
	BEGIN
		RAISERROR('Esa actividad no existe.', 16, 1);
	END

delete from organizar -- Borramos el registro
	where idActividad = @idactividad 
	and idAlojamiento = @idalojamiento
	and dia = @dia

insert into organizar values (@idactividad, @idalojamiento, @dia) -- Y lo volvemos a meter 

print 'Datos introducidos correctamente!'

end try begin catch

	print 'Hubo un error: ' + ERROR_MESSAGE(); --Si ocurre un error se mostrará este mensaje

end catch

END

