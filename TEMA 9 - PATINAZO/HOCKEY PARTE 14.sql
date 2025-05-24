﻿use PATINAZO


--1. Crear el disparador tr_InsertaGol, y la ejecución que lo invoca.
--El disparador debe estar asociado al proceso de inserción de datos de la tabla GOLEAR, de tal
--manera que, después de insertar el gol en la tabla GOLEAR, se comprueban que los datos
--introducidos son válidos.
--Es decir, debe controlarse que:
--• el jugador que mete un gol, es un jugador de uno de los equipos que juega el partido.
--• al registrar el gol, hay que actualizar, de forma automática, la tabla PARTIDOS, sumándolo
--al equipo en el que juega el jugador que metió el gol.

--go
--CREATE TRIGGER tr_InsertaGol --BIEN
--ON golear
--AFTER INSERT
--AS
--BEGIN

--SET NOCOUNT ON;

--declare @idjug int, @idpartido int, @minuto nvarchar(5), @idequipo char(10)

--select TOP 1 
--	@idjug = numfed,
--	@idpartido = codpar,
--	@minuto = minuto
--from inserted

--set @idequipo = (

--select TOP 1 e.numreg 
--from EQUIPOS e 
--inner join JUGADORAS j on j.numReg = e.numReg
--where j.numFed = @idjug

--)

--if (@idjug not in (select numfed from JUGADORAS 
--					where numreg in (
--						select eqVis from PARTIDOS where codPar = @idPartido
--						union
--						select eqLoc from PARTIDOS where codPar = @idPartido
--					))) begin

--	print 'El jugador no se encuentra en ninguno de los equipos que estan jugando el partido.' ROLLBACK end
--	ELSE begin

--	if (@idequipo in (select eqLoc from partidos where codpar = @idpartido)) begin
--		update PARTIDOS
--		set golLoc = golLoc + 1
--		where codPar = @idpartido end
--	ELSE BEGIN if (@idequipo in (select eqVis from partidos where codpar = @idpartido)) begin
--		update PARTIDOS
--		set golVis = golVis + 1
--		where codPar = @idpartido end END

--		print 'Datos actualizados correctamente.'

--	end

--END



--insert into GOLEAR (codPar, numFed, minuto) values (1, 2, '30:02') -- no devuelve error asi q esta bien

--insert into GOLEAR (codPar, numFed, minuto) values (4, 2, '30:02') -- Devuelve el error del trigger, funciona bien

--go disable trigger tr_insertagol on golear



--2. Crear el disparador tr_BorrarGol, y la ejecución que lo invoca.
--El disparador debe estar asociado al proceso de borrado de datos de la tabla GOLEAR, de tal
--manera que, al borrar un gol, también se descuente en la tabla PARTIDOS, en el campo que
--corresponda.

--go --BIEN
--CREATE TRIGGER tr_BorrarGol
--on GOLEAR
--AFTER DELETE
--as
--BEGIN

--SET NOCOUNT ON;

--begin try

--declare @equipoLocal int, @equipoVisitante int, @idPartido int, @equipoGoleador int, @idJugadora int

--select
--	@idPartido = codPar,
--	@idJugadora = numFed
--	from deleted

--select
--	@equipoLocal = eqLoc,
--	@equipoVisitante = eqVis
--	from PARTIDOS
--	where codPar = @idPartido

--select 
--	@equipoGoleador = j.numReg
--	from JUGADORAS j
--	where j.numFed = @idJugadora

--if (@equipoLocal = @equipoVisitante) throw 50000, 'El equipo local y el visitante son iguales', 0;

--IF (@equipoGoleador = @equipoLocal) BEGIN
--	update PARTIDOS
--	set golLoc = golLoc - 1
--	where eqLoc = @equipoLocal END

--		ELSE BEGIN
--			if (@equipoGoleador = @equipoVisitante) begin 
--				update PARTIDOS
--				set golVis = golVis - 1
--				where eqVis = @equipoVisitante 

--			end END

--print 'Datos actualizados correctamente.'

--end try
--begin catch

--	print 'Hubo un error ' + ERROR_MESSAGE() + '.'

--end catch

--END

--select * from golear

--insert into golear values (2, 43,'10:35')

--select * from PARTIDOS where codPar = 2

--delete from GOLEAR where minuto like '%10:35%'

--select * from PARTIDOS where codPar = 2

--disable trigger tr_borrargol on golear


--3. Crear el disparador tr_ModificarGol, y la ejecución que lo invoca.
--El disparador debe impedir las modificaciones en la tabla GOLEAR.
--Se considera, que este proceso más operativo. Es decir, si existió un error en la introducción del
--GOL, debe darse de baja el gol, para luego darlo de alta de forma correcta.

--go --BIEN
--CREATE TRIGGER tr_ModificarGol
--on GOLEAR
--AFTER UPDATE
--as
--BEGIN
--    RAISERROR('No está permitido modificar los goles. Elimina el gol y vuelve a insertarlo correctamente.', 16, 1)
--    ROLLBACK
--END


--4. Crear el disparador tr_ModificaBorro, y la ejecución que lo invoca.
--El disparador debe tomar el control cuando se pretende realizar actualizaciones en la tabla
--GOLEAR.
--Al tomar el control realizará las siguientes operaciones:
--• Eliminará el registro de la tabla Golear que se pretende actualizar.
--• Insertará un nuevo registro con los datos del registro que se pretende actualizar.

--go
--CREATE TRIGGER tr_ModificaBorro -- BIEN
--on GOLEAR
--INSTEAD OF UPDATE 
--as
--BEGIN

--set nocount on;

--declare @codpar int, @idjug int, @min nvarchar(5)

--select 
--	@codpar = codPar,
--	@idjug = numFed,
--	@min = minuto
--	from inserted

--begin try

--if not exists (select codpar from PARTIDOS where codPar = @codpar) 
--	throw 99997, 'El partido no existe.', 0; 

--if not exists (select numfed from JUGADORAS where numfed = @idjug)
--	throw 99998, 'La jugadora no existe', 0;

--if (@idjug not in (select numfed from JUGADORAS 
--					where numreg in (
--						select eqVis from PARTIDOS where codPar = @codpar
--						union
--						select eqLoc from PARTIDOS where codPar = @codpar 
--					))) throw 99999, 'La jugadora no pertenece a ninguno de los equipos.', 0; 
					
				
--delete from GOLEAR 
--	where codPar = @codpar 
--	and numFed = @idjug 
--	and minuto = @min

--	insert into GOLEAR 
--	select codPar, numFed, minuto FROM inserted

--	print 'Datos actualizados correctamente.'

--end try

--begin catch

--	print 'Hubo un error: ' + ERROR_MESSAGE()

--end catch

--END


--disable trigger tr_modificaborro on golear

--5. Crear DOS procedimientos almacenados, y sus correspondientes llamadas, con el objeto de
--comprobar los disparadores asociados a los procesos de inserción y borrado en la tabla golear.
--Los procedimientos a crear son:

--1 • El primer procedimiento, llamado pa_MeterGol.
--Recibirá los parámetros:
--✓ Código del partido. Se comprobará la existencia del partido mediante la función
--fn_Partido. Si no existe partido no se podrá insertar el gol.
--✓ Número identificativo de la jugadora que marca. Se comprobará la existencia de la
--jugadora mediante la función fn_Jugadora. Si no existe jugadora no se podrá insertar el
--gol.
--✓ El minuto del gol (por ejemplo 12:45)
--Una vez verificado todos los elementos a insertar, se procederá a realizar la inserción.

--2 • El segundo procedimiento, llamado pa_BorraGol.
--Recibirá los parámetros:
--✓ Código del partido. Se comprobará la existencia del partido mediante la función
--fn_Partido. Si no existe partido no se podrá borrar el gol.
--✓ Número identificativo de la jugadora que marca. Se comprobará la existencia de la
--jugadora mediante la función fn_Jugadora. Si no existe jugadora no se podrá borrar el
--gol.
--✓ El minuto del gol (por ejemplo 12:45)
--Una vez verificado todos los elementos a borrar, se procederá a realizar el borrado.

-- BIEN

-- FUNCIONES:

--go
--create function fn_Partido (@codpar int)
--returns int
--as
--BEGIN

--declare @resultado int

--set @resultado = (select ISNULL(COUNT(*), 0) from PARTIDOS where codPar = @codpar)

--IF @resultado is null
--        set @resultado = 0

--return @resultado

--END

-------------------------------------------------------
--|||||||||||||||||||||||||||||||||||||||||||||||||||--
-------------------------------------------------------

--go
--create function fn_Jugadora (@idjug int)
--returns int
--as
--BEGIN

--declare @resultado int

--set @resultado = (select ISNULL(count(*), 0) from JUGADORAS where numFed = @idjug)

--IF @resultado is null
--        set @resultado = 0

--return @resultado

--END

--PROCEDIMIENTOS:

--go
--CREATE PROCEDURE pa_MeterGol
--@codpar int, @idjug int, @minuto nvarchar(5)
--as
--BEGIN

--begin try

--IF ((select COUNT(*) from GOLEAR
--	where codPar = @codpar and numFed = @idjug and minuto = @minuto) > 0)
--	BEGIN
--		RAISERROR('El gol ya existe', 16, 1);
--	END

--IF (dbo.fn_Partido(@codpar) = 0) 
--	BEGIN
--		RAISERROR('No existe el partido.', 16, 1);
--	END
		 
--IF (dbo.fn_Jugadora(@idjug) = 0) 
--	BEGIN
--		RAISERROR('No existe la jugadora.', 16, 1);
--	END
					
--insert into GOLEAR values (@codpar, @idjug, @minuto)

--print 'Gol insertado correctamente.'
						
--end try begin catch

--print 'Hubo un error: ' + ERROR_MESSAGE();

--end catch

--END

-------------------------------------------------------
--|||||||||||||||||||||||||||||||||||||||||||||||||||--
-------------------------------------------------------

--go
--CREATE PROCEDURE pa_BorrarGol
--@codpar int, @idjug int, @minuto nvarchar(5)
--as
--BEGIN

--begin try

--IF ((select COUNT(*) from GOLEAR
--	where codPar = @codpar and numFed = @idjug and minuto = @minuto) = 0)
--	BEGIN
--		RAISERROR('El gol no existe', 16, 1);
--	END

--IF (dbo.fn_Partido(@codpar) = 0) 
--	BEGIN
--		RAISERROR('No existe el partido.', 16, 1);
--	END
		 
--IF (dbo.fn_Jugadora(@idjug) = 0) 
--	BEGIN
--		RAISERROR('No existe la jugadora.', 16, 1);
--	END
					
--delete from GOLEAR where
--	codPar = @codpar
--	and numFed = @idjug
--	and minuto = @minuto

--print 'Gol borrado correctamente.'
						
--end try begin catch

--	print 'Hubo un error: ' + ERROR_MESSAGE();

--end catch

--END

-- COMPROBACIONES:

-- si los datos están bien:  

--select * from golear

--EXEC pa_MeterGol 1, 24, '30:30'

--select * from GOLEAR where minuto = '30:30' -- bien

--EXEC pa_BorrarGol 1, 24, '30:30'

--select * from GOLEAR where minuto = '30:30' -- bien también

---- datos erróneos:

--select * from golear where codPar = 1

--EXEC pa_MeterGol 2, 999, '30:30'

--select * from GOLEAR where minuto = '30:30' -- bien

--EXEC pa_BorrarGol 2, 999, '30:30'

--select * from GOLEAR where minuto = '30:30' -- bien también
