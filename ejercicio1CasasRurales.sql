use [CASAS RURALES]

--Crear el procedimiento pa_registrarTrabajadorActividad
--A este procedimiento se le pasaran por par�metro:
--1- Un ID de un trabajador
--2- El ID de una actividad
--Se deber� comprobar que tanto el trabajador como la actividad existen
--y tras eso se proceder� a insertar los valores en la tabla organizar
--Para ello se crear�n las funciones fn_Personal() y fn_Actividad()
--que pas�ndoles el ID de el trabajador o actividad comprobaran si �ste
--existe en la BDD o no.
--Despu�s de comprobar si los datos que se le pasa por par�metro al
--procedimiento son v�lidos se proceder� a obtener el d�a de la actividad,
--que se obtendr� con la funci�n GETDATE()
--Para terminar se deber� crear el trigger tr_checkInsert, que despu�s de insertar
--datos comprobar� que el alojamiento y la actividad son v�lidos, para a continuaci�n
--borrar el registro y volver a insertarlo.
--Se debe usar un bloque try-catch para manejar errores dentro del trigger para que
--en caso de que haya un error mostrar el mensaje de �ste.
--Tambi�n puedes crear tus propios errores.


/*
Creamos la funci�n que comprueba si un trabajador (qu� no est� dado de baja)
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
Creamos la funci�n que comprueba que una actividad existe
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
Esta funci�n, al pasarle un n�mero del mes te devuelve
su equivalente en d�a de la semana
*/
go
create function fn_getDia (@numDia int)
returns nvarchar(9)
as
BEGIN

declare @nombreDia nvarchar(9)


--si el d�a no est� comprendido entre 1 y 7 
--devuelve que el d�a no es v�lido
if (@numDia not between 1 and 7)
	return 'No v�lido'

set @nombreDia = 
        CASE @numDia
            WHEN 1 THEN 'Lunes'
            WHEN 2 THEN 'Martes'
            WHEN 3 THEN 'Mi�rcoles'
            WHEN 4 THEN 'Jueves'
            WHEN 5 THEN 'Viernes'
            WHEN 6 THEN 'S�bado'
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

set @dia = dbo.fn_getDia(DATEPART(weekday, GETDATE())); --Sacamos el d�a de la semana

if (@dia like '%No v�lido%') --Comprobamos que el d�a es v�lido
	RAISERROR('Se ha introducido un d�a no v�lido.', 16, 1)

insert into Organizar (idActividad, idAlojamiento, dia) --Insertamos los datos
	values (
	@alojTrabajador,
	@idactividad, 
	@dia)

	print 'Datos introducidos correctamente!'

end try begin catch

	print 'Hubo un error: ' + ERROR_MESSAGE() --Si ocurre un error se mostrar� este mensaje

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

	print 'Hubo un error: ' + ERROR_MESSAGE(); --Si ocurre un error se mostrar� este mensaje

end catch

END

