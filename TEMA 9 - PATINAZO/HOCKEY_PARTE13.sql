use PATINAZO

--1. Crear la función fn_Gasto.
--Esta función obtiene el gasto en jugadoras que tiene cada equipo, a lo largo de los 10
--meses de las competiciones.
--Probar su ejecución mediante el uso de la llamada a la función desde una orden select.

--create function fn_gasto (@idEquipo char(50))
--returns int
--as
--begin

--	IF (@idEquipo not in (select numreg from EQUIPOS))
--	begin

--	return 0

--	end

--    declare @gasto int

--    set @gasto = (select isnull(presupuesto * 10, 0) from equipos 
--	where numreg = @idequipo)

--    return @gasto

--end

----o tambien

--create function fn_gasto() -- se tienen que hacer con la ficha anual salario y publi de cada jugadora no con el presupuesto, REHACER 
--returns table
--as
--begin
--return
--    select numreg, isnull(presupuesto * 10, 0) as gasto
--    from equipos
--end

--select * from dbo.fn_Gasto()

--2. Crear la vista vw_GastoExceso.
--Esta vista obtiene los equipos, siempre y cuando posean presupuesto, cuyos gastos de sus
--jugadoras, a lo largo de los 10 meses de competición, superen en un 150% el presupuesto
--del equipo.
--La información que soportará la vista, por equipo, será:
--Código, Nombre, Presupuesto, Presupuesto ponderado, Gasto de Jugadoras

--go --bien, faltan los isnull()
--create view vw_GastoExceso as 
--select numreg, nombre, presupuesto, (presupuesto * 1.5) [Presupuesto Ponderado], 
--	dbo.fn_gasto(numreg) as [Gasto de Jugadoras] from EQUIPOS
--	where presupuesto * 1.5 < dbo.fn_Gasto(numreg)
--	and presupuesto > 0

--3. Crear la función fn_NumJug.
--Esta función obtiene el número de jugadoras que posee un equipo determinado.
--Probar su ejecución mediante el uso de diferentes tipos de llamadas a la función:
--• Llamada desde una orden select.
--• Llamada desde una orden print.

--create function fn_NumJug(@idEquipo char(10)) -- ✓
--returns int
--as
--begin

--	IF (@idEquipo not in (select numreg from EQUIPOS))
--	begin

--	return 0

--	end

--    declare @count int

--    set @count = (select COUNT(j.nombre) from equipos e
--	inner join JUGADORAS j on j.numReg = e.numReg
--	where e.numreg = @idEquipo)

--    return @count

--end


--print 'El número de jugadoras es de ' dbo.fn_Gasto(2)
--select * from dbo.fn_NumJug(2)

--4. Crear la función fn_EquJug.
--Esta función se utilizará para comprobar si una jugadora pertenece a un equipo
--determinado.
--A la función le llegarán los parámetros nombre de equipo y número de jugadora.
--La función devolverá un valor que permitirá mostrar los mensajes:
--'La jugadora pertenece al equipo' o 'Existe un problema'


--create function fn_EqeJug(@idJugadora int, @equipo char(10)) -- ✓
--returns bit 
--as
--BEGIN
--declare @resultado int
--	IF (@idJugadora in (select numfed from JUGADORAS where numreg = @equipo)) begin 
--		set @resultado = 1 end
--	ELSE begin
--		set @resultado = 0 end

--	return @resultado
--END

--5. Realizar las siguientes tareas:
--✓ Crear la función fn_NumEspecta. Esta función obtiene el mayor número de
--espectadores (dato devuelto por la función) que hubo en una competición determinada
--(dato que se recibe como parámetro).
--En el caso de no existir la competición, se devolverá el valor centinela: -1.
--✓ Crear el procedimiento almacenado pa_Espectador. Este procedimiento debe llamar a
--la función pasándole el código de la competición, para visualizar finalmente el resultado.
--✓ Realizar una llamada al procedimiento anterior para comprobar las ejecuciones del
--procedimiento y la función.
 
--create function fn_NumEspecta(@idCompeticion int) -- ✓
--returns int
--as
--BEGIN

--	declare @maxSpecs int = 0

--	IF exists (select idComp from COMPETICION where idComp = @idCompeticion)
--		set @maxSpecs = -1
--	ELSE begin
--		set @maxSpecs = (select isnull(max(par.numEsp),-1) from COMPETICION com 
--		inner join partidos par on par.idComp = com.idComp
--		where com.idComp = @idCompeticion)
--	end
--	return @maxSpecs

--END

--create procedure as pa_Espectador
--@idComp int = 0
--as 
--begin

	--print 'El máximo de espectadores de la competición con ID' + cast(@idComp as nvarchar(2)) + ' fue de ' + cast(dbo.fn_NumEspecta(@idComp) as nvarchar(4))

--END

--6. Crear el procedimiento pa_EquJug.
--Este procedimiento pretende sustituir la forma de visualizar los resultados obtenidos en la
--llamada del ejercicio anterior.
--Algorítmica:
--1. Se llama al procedimiento con los valores a comprobar (jugadora y equipo).
--2. Desde el procedimiento se llama a la función para verificar si la jugadora pertenece al
--equipo (función fn_EquJug).
--3. En función de los valores devueltos se visualizará en el procedimiento (uso varios if):
--4. Si la jugadora pertenece al equipo, se visualizará: 'La jugadora pertenece al equipo'
--5. En otro caso, existirá un problema, y además de visualizar el mensaje 'Existe un
--problema', se deberá indicar cuál es el problema:
--• Visualizar: ‘Existe Jugadora y Equipo, pero no pertenece a ese Equipo’
--• Visualizar: ‘Existe Equipo, pero no existe esa Jugadora’
--• Visualizar: ‘Existe Jugadora, pero no existe ese Equipo’
--• Visualizar: ‘No existen ni Jugadora, ni Equipo’

--create procedure pa_EquJug -- ✓
--@jugadora int, @equipo char(10)
--as
--BEGIN
--declare @pertenece int
--set @pertenece = fn_EueJug(@jugadora, @equipo)

--	IF (@pertenece = 0)
--		print 'La jugadora está en el equipo.'
--	ELSE begin

--		print 'Existe un problema:'
--		print 'Problema: ' + ERROR_MESSAGE()

--		--FALTAN LOS CONDICIONALES

--		end

--END


--7. Crear el procedimiento pa_EquJug2.
--Este procedimiento realiza las mismas funciones que el procedimiento pa_EquJug, pero
--modificamos el código incorporando las siguientes actualizaciones:
--• Todos los literales se visualizarán fuera del procedimiento, por lo que es necesario
--manejar parámetros de entrada (para enviar los datos al procedimiento) y parámetros de
--salida (para recibir datos de literales y variable del procedimiento).
--• Los literales 'La jugadora pertenece al equipo' y 'Existe un problema:' se
--asignarán dentro del procedimiento utilizando una estructura case.
--• El resto de literales: 'Existe Equipo y Jugadora, pero NO pertenece a ese equipo',
--'Existe Jugadora, pero NO existe el equipo', 'Existe Equipo, pero NO existe
--Jugadora', 'NO Existen en BDD la jugadora, ni el equipo'
--se asignarán fuera del procedimiento, dentro de una estructura case.
--Para ello, en el procedimiento asignaremos valores a una variable de salida que,
--posteriormente, en el case externo comprobará su valor y asignara literal.

--create procedure pa_EquJug2 --REHACER
--@jugadora int, @equipo char(10)
--as
--BEGIN

--begin try

--begin tran t1

--declare @pertenece int
--set @pertenece = fn_EueJug(@jugadora, @equipo)

--	IF @pertenece = 0 begin
--		print 'La jugadora está en el equipo' end
--	ELSE begin
--		print 'Existe un problema'
--		print 'Problema: ' + ERROR_MESSAGE()	
--		end

--		commit t1
--end try

--begin catch

--	print 'Hubo un error'
--	rollback t1

--end catch


--END

--8. Este ejercicio se diseña para insertar nuevos partidos, atendiendo a las siguientes
--características:
--• Se creará el procedimiento almacenado pa_NuevoPartido:
--✓ El procedimiento recibirá los valores necesarios para poder realizar la inserción
--desde el procedimiento, siempre que se valide correctamente la existencia de
--competición y equipos.
--✓ El procedimiento enviará un parámetro de salida para indicar si se realizó
--correctamente la inserción o no.
--• Se crearán las funciones:
--✓ fn_competicion. Esta función comprobará la existencia de la competición.
--✓ fn_equipos. Esta función comprobará la existencia del equipo.
--✓ fn_NumPar. Esta función devolverá el número de partido a insertar.
--• Se creará la llamada a la función para comprobar su funcionamiento. Se deben realizar
--diferentes inserciones que garanticen toda la casuística.

--create function fn_competicion(@competicion int)
--returns bit
--as
--begin

--declare @existe bit

--IF (@competicion not in (select idComp from COMPETICION))
--	set @existe = 0
--ELSE
--	set @existe = 1

--	return @existe
--end

--create function fn_equipos(@equipo int)
--returns bit
--as 
--begin

--declare @existe bit

--IF (@equipo not in (select numreg from equipos))
--	set @existe = 0
--ELSE
--	set @existe = 1

--	return @existe

--end

--create function fn_numPar()
--returns int
--as 
--begin

--return (select MAX(codpar) + 1 from partidos)

--end

create procedure pa_NuevoPartido
@codPar int, @fecCel date, @hora nvarchar(5), @golLoc int, @golVis int, @numEsp int,
@eqLoc char(10), @eqVis char(10), @idComp int, @insercion bit output
as
BEGIN

IF (fn_equipos(@eqLoc) = 0 or fn_equipos(@eqVis) = 0 or fn_competicion(@idComp) = 0 or (@eqLoc != @eqVis))
begin
	print 'Hubo un error ' + ERROR_MESSAGE()
	set @insercion = 0
	return
end
ELSE
begin

	insert into PARTIDOS(codPar, fecCel, hora, golLoc,golVis, numEsp,eqLoc,eqVis, idComp)
	values(@codPar, @fecCel, @hora, @golLoc, @golVis, @numEsp, @eqLoc, @eqVis, @idComp)
	set @insercion = 1

	print 'Partido introducido correctamente!'

end

END

-- SOLUCION PRIEGO
create procedure pa_NuevoPartido
@codPar int, @fecCel date, @hora nvarchar(5), @golLoc int, @golVis int, @numEsp int,
@eqLoc char(10), @eqVis char(10), @idComp int, @mensaje nvarchar(40) output
as
BEGIN

SET NOCOUNT ON;

IF (dbo.fn_competicion(@idcomp))
	begin
		if (dbo.fn_equipos(@idcomp) = 1)
			begin
				IF (fn_equipos(@eqLoc) = 1 
				and fn_equipos(@eqVis) = 1 
				and (@eqLoc != @eqVis))
					begin
							insert into PARTIDOS(codPar, fecCel, hora, golLoc,golVis, numEsp,eqLoc,eqVis, idComp)
							values(@codPar, @fecCel, @hora, @golLoc, @golVis, @numEsp, @eqLoc, @eqVis, @idComp)
							set @mensaje = 'Exitosa'
					end
				ELSE
					set @mensaje = 'Fracaso. Los equipos no son correctos'
			end
		ELSE 
			begin

			set @mensaje = 'No existe competición' 

			end
END