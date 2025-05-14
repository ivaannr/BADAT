use PATINAZO


--1. Crear el disparador tr_InsertaGol, y la ejecución que lo invoca.
--El disparador debe estar asociado al proceso de inserción de datos de la tabla GOLEAR, de tal
--manera que, después de insertar el gol en la tabla GOLEAR, se comprueban que los datos
--introducidos son válidos.
--Es decir, debe controlarse que:
--• el jugador que mete un gol, es un jugador de uno de los equipos que juega el partido.
--• al registrar el gol, hay que actualizar, de forma automática, la tabla PARTIDOS, sumándolo
--al equipo en el que juega el jugador que metió el gol.

go
CREATE TRIGGER tr_InsertaGol
ON golear
AFTER INSERT
AS
BEGIN

SET NOCOUNT ON;

declare @idjug int, @idpartido int, @minuto nvarchar(5), @idequipo char(10)

select @minuto = getdate()

set @idjug = (select numfed from inserted)
set @idpartido = (select codpar from inserted)
set @minuto = (select minuto from inserted)
set @idequipo = (

select e.numreg from EQUIPOS e inner join JUGADORAS j
on j.numReg = e.numReg where e.numFed = @idjug

)

IF (@idjug not in ((select numfed from JUGADORAS j 
					inner join PARTIDOS p on p.eqLoc = j.numReg where codPar = @idpartido),
					(select numfed from JUGADORAS j 
					inner join PARTIDOS p on p.eqVis = j.numReg where codPar = @idpartido)
					)) 
begin
	print 'El jugador no se encuentra en ninguno de los equipos que estan jugando el partido.' ROLLBACK end
	ELSE begin

	insert into GOLEAR values (@idpartido, @idjug, (select cast(DATEPART(MINUTE, @minuto) as nvarchar(5)) as minuto) )

	if (@idequipo in (select eqLoc from partidos)) begin
		update PARTIDOS
		set golLoc = golLoc + 1
		where @idpartido = (select codPar from partidos) end
	else BEGIN if (@idequipo in (select eqVis from partidos)) begin
		update PARTIDOS
		set golVis = golVis + 1
		where @idpartido = (select codPar from partidos) end END

		print 'Datos actualizados correctamente.'

	end

END


--2. Crear el disparador tr_BorrarGol, y la ejecución que lo invoca.
--El disparador debe estar asociado al proceso de borrado de datos de la tabla GOLEAR, de tal
--manera que, al borrar un gol, también se descuente en la tabla PARTIDOS, en el campo que
--corresponda.

go
CREATE TRIGGER tr_BorrarGol
on GOLEAR
AFTER DELETE
as
BEGIN

SET NOCOUNT ON;

begin try

declare @equipoLocal int, @equipoVisitante int, @idPartido int, @equipoGoleador int

set @equipoLocal = (select eqLoc from PARTIDOS where PARTIDOS.codPar = (select codPar from deleted))
set @equipoVisitante = (select eqVis from PARTIDOS where PARTIDOS.eqVis = (select codPar from deleted))
set @equipoGoleador = (select numfed from deleted)
set @idPartido = (select codPar from deleted)

if (@equipoLocal = @equipoVisitante) throw 50000, 'El equipo local y el visitante son iguales', 0;

IF (@equipoLocal = @equipoGoleador) BEGIN
update PARTIDOS
set golLoc = golLoc - 1
where eqLoc = @equipoLocal END
ELSE BEGIN
	IF (@equipoVisitante = @equipoGoleador) begin 
	update PARTIDOS
	set golVis = golVis - 1
	where eqVis = @equipoVisitante end END

end try
begin catch

	print 'Hubo un error ' + ERROR_MESSAGE(50000) + '.'

end catch

END



--3. Crear el disparador tr_ModificarGol, y la ejecución que lo invoca.
--El disparador debe impedir las modificaciones en la tabla GOLEAR.
--Se considera, que este proceso más operativo. Es decir, si existió un error en la introducción del
--GOL, debe darse de baja el gol, para luego darlo de alta de forma correcta.

go
CREATE TRIGGER tr_ModificarGol
on GOLEAR
AFTER UPDATE, DELETE, INSERT
as
BEGIN

ROLLBACK

declare @codpar int, @codeq int, @minuto nvarchar(5), @mierror int

set @codpar = (select codpar from inserted)
set @codeq = (select numFed from inserted)
set @minuto = (select minuto from inserted)
    
INSERT INTO GOLEAR VALUES (@codpar, @codeq, @minuto)

END

--4. Crear el disparador tr_ModificaBorro, y la ejecución que lo invoca.
--El disparador debe tomar el control cuando se pretende realizar actualizaciones en la tabla
--GOLEAR.
--Al tomar el control realizará las siguientes operaciones:
--• Eliminará el registro de la tabla Golear que se pretende actualizar.
--• Insertará un nuevo registro con los datos del registro que se pretende actualizar.




--5. Crear DOS procedimientos almacenados, y sus correspondientes llamadas, con el objeto de
--comprobar los disparadores asociados a los procesos de inserción y borrado en la tabla golear.
--Los procedimientos a crear son:
--• El primer procedimiento, llamado pa_MeterGol.
--Recibirá los parámetros:
--✓ Código del partido. Se comprobará la existencia del partido mediante la función
--fn_Partido. Si no existe partido no se podrá insertar el gol.
--✓ Número identificativo de la jugadora que marca. Se comprobará la existencia de la
--jugadora mediante la función fn_Jugadora. Si no existe jugadora no se podrá insertar el
--gol.
--✓ El minuto del gol (por ejemplo 12:45)
--Una vez verificado todos los elementos a insertar, se procederá a realizar la inserción.
--• El segundo procedimiento, llamado pa_BorraGol.
--Recibirá los parámetros:
--✓ Código del partido. Se comprobará la existencia del partido mediante la función
--fn_Partido. Si no existe partido no se podrá borrar el gol.
--✓ Número identificativo de la jugadora que marca. Se comprobará la existencia de la
--jugadora mediante la función fn_Jugadora. Si no existe jugadora no se podrá borrar el
--gol.
--✓ El minuto del gol (por ejemplo 12:45)
--Una vez verificado todos los elementos a borrar, se procederá a realizar el borrado.