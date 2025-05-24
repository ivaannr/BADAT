use PATINAZO

--1. Crear el procedimiento pa_SolucionDNI, que se ejecutará una única vez, y una vez
--ejecutado será borrado.
--El procedimiento consiste en ejecutar, de manera controlada por transacciones, un
--proceso que corrija los problemas detectados en los DNI’s de las jugadoras.
--Problema: Se detectó que los DNI’s poseen 9 dígitos numéricos, en lugar de 8 dígitos y la
--letra de control.
--Para dar solución al problema, se realizarán las siguientes tareas en el mismo orden al
--indicado:
--Fuera del procedimiento:
--• Cargar los datos del fichero LetraDNI.csv a la tabla LetraDNI.
--• Crear el atributo dni_ok de tipo nvarchar(9) en jugadoras.
--• Crear la vista vw_dni que permita obtener:
--✓ Dni actual de jugadora,
--✓ Dni nuevo de la jugadora (dni_ok),
--✓ Los 8 primeros dígitos del dni actual (solo los 8 primeros dígitos),
--✓ La letra asociada a la obtención del resto entero entre el dato anterior y 23
--(dni%23)
--Dentro del procedimiento:
--• Cargar el nuevo DNI en la tabla jugadoras utilizando la vista vw_dni.
--Nota.-
--Recuerda que la letra del DNI se obtiene del resto entero entre el DNI y 23 (dni%23). Ese
--número resultante se asocia una letra (tabla LetraDNI).

----tabla creada --CORREGIDO, IBA BIEN ENCAMINADO, FALTÓ ALGÚN DETALLE.
--select * from letradni

--alter table jugadoras
--add dni_ok nvarchar(9) not null default ' '

--update JUGADORAS 
--set dni_ok = ' '
--where dni_ok is not null

----la tenia bien pero soy idiota?
--go
--create view vw_dni as
--select j.dni, j.dni_ok, SUBSTRING(cast(dni as nvarchar(9)), 1,8) [dniOK],
--	(select ldn.letra from letradni ldn
--	where ldn.resto = CAST(substring(cast(dni as nvarchar(9)),1,8) as int) % 23) as letraCorrecta
--	from jugadoras j

--CREATE PROCEDURE pa_AsignarDNICorrecto
--AS
--BEGIN
--begin tran t1
--begin try

--update vw_dni
--set dni_ok = dniok + letraCorrecta

--commit tran
--print 'Actualizados los registros correctamente'
--end try
--begin catch
--print 'Hubo un error'
--rollback tran t1
--end catch
--END

--exec pa_AsignarDNICorrecto
--drop procedure pa_AsignarDNICorrecto

--2. Crear el procedimiento pa_Fechas.
--El procedimiento se crea para detectar, y en algunos casos solucionar, los problemas en
--la carga de datos de las fechas de nacimiento y alta de las jugadoras.
--Para dar solución al problema, se realizarán las siguientes tareas, en el orden indicado:
--• Indicar cuántas jugadoras poseen la misma fecha de fecNto y fecAlta.
--• Indicar quiénes son las jugadoras que poseen la misma fecha en fecNto y fecAlta.
--• Indicar las jugadoras que tenían menos de 14 años cuando fueron dadas de alta en
--el club.
--• Para aquellas jugadoras que posean la misma fecha de fecNto y de fecAlta:
--✓ Añadir 14 años a la fecha de Alta en el club. Usar la función Dateadd
--Sintaxis orden: Dateadd (parte _de_fecha, valor, fecha)

go
--create procedure pa_Fechas -- ✓
--as 
--begin

--begin tran mitran
--begin try

--	select COUNT(*) [Jugadoras] from JUGADORAS where fecNto = fecAlta 

--	select numfed, nombre from JUGADORAS where fecNto = fecAlta

--	select nombre from JUGADORAS 
--		where fecAlta is not null and fecNto is not null
--		and 14 =  DATEDIFF(YYYY, fecNto, fecAlta)
	
--	update JUGADORAS
--	set fecAlta = DATEADD(YYYY, 14, fecAlta)
--	where fecNto = fecAlta

--	select nombre from JUGADORAS 
--		where fecAlta is not null and fecNto is not null
--		and 14 =  DATEDIFF(YYYY, fecNto, fecAlta)

--	print 'Actualizados los registros correctamente'
--	commit mitran

--end try
--begin catch

--	print 'Hubo un error'
--	rollback mitran

--end catch
--end

--exec pa_Fechas

--3. Crear el procedimiento pa_MediaCompetición.
--Este procedimiento debe calcular la media de espectadores que acuden a cada
--competición.
--En el caso de no haberse celebrado partidos en una competición, el procedimiento deberá
--pintar sus datos y el literal: ‘No se han disputado partidos’
--La visualización final deberá tener el formato:
--Código Competición, Fecha de Inicio, Media de Espectadores

go
--create procedure pa_MediaCompetición -- ✓
--as 
--begin

--select com.idcomp, com.fecIni [Fecha Inicio],
--	isnull(avg(par.numEsp), 'No se han disputado partidos') [Media Espectadores] 
--	from Competicion com
--	left join PARTIDOS par on par.idComp = com.idComp
--	group by com.idcomp, com.fecIni, com.fecIni

--end

--4. Desarrollar el procedimiento pa_NuevoEquipo.
--Este procedimiento debe permitir introducir un nuevo equipo de hockey.
--El procedimiento debe contener:
--✓ Conjunto de variables de entrada que permitan introducir los datos.
--✓ Una variable de salida para permitir visualizar los mensajes.
--✓ Una transacción denominada añadir.
--✓ Mensajes: ‘Equipo insertado satisfactoriamente’, o bien ‘Se produjo error…en la línea..’.
--(Ver uso de funciones ERROR_MENSAJE() y ERROR_LINE())
--Realizamos 2 inserciones de registros para validar las 2 salidas:

--➢ Primer registro
--NumReg: 90, Nombre: ’Patintin’, Localidad: ’Teruel’,
--fecCrea: ’2024-12-31’, tfnConta: ’957111111’, presupuesto: 10000,
--desaparecido: ’n’, numFed: 999, ccaa: ’ARA’

--➢ Segundo registro
--NumReg: 90, Nombre: ’Patintin’, Localidad: ’Teruel’,
--fecCrea: ’2024-12-31’, tfnConta: ’957111111’, presupuesto: 10000,
--desaparecido: ’n’, numFed: 999, ccaa: ’C

go
--CREATE PROCEDURE pa_NuevoEquipo -- ✓
--  @numreg char(10), @nombre varchar(100), @localidad varchar(100), @fecCrea date, 
--	@telefono varchar(15), @presupuesto decimal (12,2), @desaparecido char(1),
--	@ccaa nvarchar(3), @numfed int,
--  @mensaje nvarchar(200) OUTPUT
--AS
--BEGIN	
    
--	begin tran añadir
--	begin try

--		insert into EQUIPOS (numReg, nombre, localidad, fecCrea, telefono, presupuesto, desaparecido, ccaa, numFed)
--		values (@numreg, @nombre, @localidad, @fecCrea, @telefono, @presupuesto, @desaparecido, @ccaa, @numfed )

--		commit añadir

--		print 'Inserción de datos realizado con éxito!'

--		set @mensaje = 'Equipo insertado satisfactoriamente'

--	end try
	
--	begin catch

--		rollback añadir

--		print 'Ocurrió un error:'
--		print 'Mensaje de error: ' + ERROR_MESSAGE()
--		print 'Se produjo error en la línea ' + CAST(ERROR_LINE() as nvarchar)
	
--		set @mensaje = 'Ocurrió el error ' + ERROR_MESSAGE() + ' y se produjo en la línea ' + ERROR_MESSAGE()

--	end catch
--END

--declare @mensajes nvarchar(200)
--exec pa_NuevoEquipo 90, 'Patintin', 'Teruel', '2024-12-31', '957111111', 50000, 'n', 'ARA', 999, @mensajes OUTPUT

--5. Realizar el procedimiento almacenado pa_Bonificar.
--Este procedimiento debe realizar una actualización del atributo ficha anual, en la jugadora
--más veterana de la federación, si la bonificación a realizar no es superior a la ficha anual
--actual.
--Nota.-
--• Recuerda que existe una jugadora ficticia, y no debe ser tenida en cuenta.
--• Para este ejercicio planteamos el caso que solo existe una persona con esa fecha de
--nacimiento.

go
--create procedure pa_Bonificar -- ✓
--@bonificacion int
--as 
--BEGIN
--begin tran t1
--begin try

--	update JUGADORAS
--	set fichAnual = isnull(fichAnual,0) + @bonificacion --añado isnull por si acaso
--	where numfed = (select top 1 numfed from JUGADORAS where fecAlta = (select min(fecalta) from JUGADORAS)) and @bonificacion < fichAnual and numFed <> 999

--	commit t1

--	print 'Actualizados los registros correctamente'

--end try
--begin catch

--	rollback t1
--	print 'Hubo un error'

--end catch

--END

--6. Crear el procedimiento pa_MediaManual.
--Este procedimiento debe calcular la media de espectadores que acuden a una determinada
--competición.
--Algorítmica:
--• La competición deberá ser introducida durante el proceso de llamada al
--procedimiento.
--• El procedimiento controlará, mediante el uso de condicionales, la existencia del
--código de la competición.
--• Fuera del procedimiento, se obtiene el ingreso medio de la competición, sabiendo que
--cada espectador paga 15€ en concepto de entrada.
--• Las visualizaciones finales deberán tener el formato:
--Para códigos de competiciones correctas, aunque no hayan disputado partidos:
--El número medio de espectadores es: 100
--Los ingresos medios son aproximadamente: 1500
--Para códigos de competiciones no existentes:
--No existe esta competición
--Los ingresos medios son aproximadamente: 0 

--go -- ✓
--create procedure pa_MediaManual
--@nombreCompeticion nvarchar(50)
--as
--BEGIN

--begin tran t1
--begin try

--declare @ingresosMedios int, @mediaEspectadores int

--IF (@nombreCompeticion not in (select nombre from COMPETICION))
--begin
--	print 'Esa competición no se encuentra en la lista.'
--	print 'El número de espectadores fue de 0 aproximadamente.'
--	return
--end
--ELSE
--begin

--	 set @ingresosMedios = (
--	 select (15 * sum(pa.numEsp)) from COMPETICION co join PARTIDOS pa on co.idComp = pa.idComp
--		where co.nombre = @nombreCompeticion group by co.idcomp
--	 )
--	 set @mediaEspectadores = (
--	 select avg(pa.numEsp) from COMPETICION co join PARTIDOS pa on co.idComp = pa.idComp
--		where co.nombre = @nombreCompeticion group by co.idcomp
--	 )

--	 print 'La media de espectadores de la competición' + @nombreCompeticion + ' fue de ' + @mediaEspectadores + ' y hubo unos ingresos de ' + @ingresosMedios + ' euros' 

--end
--commit t1
--end try
--begin catch 
--rollback t1 
--print 'Hubo un error'
--end catch

--END

--7. Crear los procedimientos almacenados:
--✓ pa_MaximoPresupuesto. Obtiene el equipo de hockey que maneja el presupuesto
--más alto.
--✓ pa_ObtenerJugador. Obtiene las jugadoras que pertenecen al equipo que se pasa
--como parámetro de entrada.
--Pasos a seguir:
--• Primero se ejecuta el procedimiento del cálculo del equipo que posee el mayor
--presupuesto
--• A continuación, y con el valor obtenido, y desde el propio procedimiento, ejecutar
--el procedimiento que obtiene a las jugadoras del equipo.
--• Las visualizaciones deben tener el formato:
--Zona de mensajes:
--El máximo presupuesto es del equipo: 3
--El equipo lo forman: 5 jugadoras
--Zona de resultados:
--Select del equipo obtenido
--Select de las jugadoras del equipo

--go -- ✓ Tal cual la solución de Priego
--create procedure pa_MaximoPresupuesto
--as
--BEGIN
--declare @equipo char(10)
--set @equipo = (select numreg from equipos where presupuesto = (select max(presupuesto) from EQUIPOS))

--exec pa_ObtenerJugador @equipo

--END


--go
--create procedure pa_ObtenerJugador
--@equipo char(10)
--as
--BEGIN
--declare @nJugadoras int

--IF (@equipo not in (select numreg from EQUIPOS))
--begin

--	print 'Equipo no encontrado'
--	return

--end
--ELSE
--begin

--	set @nJugadoras = (select COUNT(*) from JUGADORAS where numReg = @equipo)

--	print 'El equipo con mayor presupuesto es el equipo ' + @equipo
--	print 'Que tiene ' + cast(@nJugadoras as varchar(2)) + ' jugadoras'

--	select * from EQUIPOS where numreg = @equipo
--	select * from JUGADORAS where numReg = @equipo

--end

--END


--8. Dados los 2 procedimientos anteriores.
--Ejecutar los procedimientos, no produciendo, un anidamiento entre ellos, es decir:
--• En primer lugar, se llama al procedimiento del cálculo del equipo. Con el valor
--obtenido, se retorna al programa principal.
--• En segundo lugar, se llama al procedimiento de visualización todas las jugadoras del
--equipo con el valor retornado al programa principal.
--Las visualizaciones serán las mismas.

--go
--create procedure pa_MaximoPresupuestoV2
--@equipo char(10) output
--as
--BEGIN

--set @equipo = (select numreg from equipos where presupuesto = (select max(presupuesto) from EQUIPOS))


--END



--declare @miEquipo char(10)
--exec pa_MaximoPresupuestoV2 @miEquipo output

--exec pa_MaximoPresupuestoV2 @miEquipo

