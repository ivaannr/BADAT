use PATINAZO

--1. A�adir la competici�n Auton�mica Asturiana que comienza el 12/03/2025 y finaliza
--el 25/05/2025. En la ejecuci�n no debe incluirse el campo clave.

--insert into competicion(nombre, fecIni, fecFin)
--values ('Competici�n Auton�mica Asturiana','2025-03-12', '2025-05-25')

--2. A�adir la competici�n Lega2 Catalunya que comienza el 12/03/2025 y finaliza el
--25/05/2025. En la ejecuci�n no debe incluirse el campo clave.

--insert into competicion(nombre, fecIni, fecFin)
--values ('Competici�n Lega2 Catalunya','2025-03-12', '2025-05-25')

--3. A�adir el equipo Hockey Club Coru�a que se asienta en la localidad de A Coru�a.
--El equipo fue creado el 15/04/2023, se encuentra en estado de desaparecido, por lo
--que los valores de comunidad aut�noma y representante deben ser los que se identifican
--como valores por defecto o ficticios.
--�Es posible insertar este registro? �Podr�as justificar el motivo?
--Datos a insertar:
--30,'Hockey Club Coru�a','A Coru�a','2023-04-15',null,null,'s','GAL',99

--No se podr� insertar el valor de ccaa como nulo ya que es la clave principal de la
--tabla de comunidades lo que impide que se puedan insertar valores nulos.

--INSERT INTO equipos (numreg, nombre, localidad, feccrea, telefono, presupuesto, desaparecido, ccaa, numfed)
--VALUES (30, 'Hockey Club Coru�a', 'A Coru�a', '2023-04-15', NULL, NULL, 's', 'GAL', 99)

--4. Crear la vista VW_equipos, con la informaci�n que se pide abajo, para los equipos que
--no han desaparecido:
--Formato de vista: C�digo del equipo, nombre del equipo, descripci�n corta de la ccaa
  
--go
--create view vw_equipos as
--select e.numReg [idEquipo], e.nombre [Nombre], ca.desCorta [DescCorta] from equipos e
--  inner join comunidades as ca on ca.ccaa = e.ccaa
--  where e.desaparecido = 'n'

--5. Obtener la vista VW_Numequipos. La vista devuelve el n�mero de equipos que no han
--desaparecido por cada comunidad aut�noma, publicando: clave y nombre de la
--comunidad aut�noma, y el n�mero de equipos por CCAA.
--Realizar el ejercicio de 2 formas:
--� Sin el uso de la vista VW_Equipos.
--� Con el uso de la vista VW_Equipos.

--go
--create view vw_Numequipos as
--select ca.nombre, ca.ccaa, count(ve.idEquipo) [n� Equipos] from vw_equipos ve
--  inner join comunidades ca on ca.desCorta = ve.descCorta
--  group by ca.nombre, ca.ccaa

--o

--create view vw_Numequipos as
--select ca.nombre, ca.ccaa, count(e.numReg) [n� Equipos] from Equipos e
--  inner join comunidades ca on ca.ccaa = e.ccaa
--  group by ca.nombre, ca.ccaa

--6. Realizar la vista denominada VW_mejor pagada que contenga:
--� nombre completo de las/os jugadoras/es
--� c�digo del equipo
--� sexo
--� ingresos para aquellos jugadores que superen los 80000�, en el acumulado de
--todos sus ingresos, en los 10 meses del a�o.

--go
--create view vw_mejorpagada as
--select j.nombre, j.ape1, j.ape2, e.numReg, j.sexo, j.salMes, j.publicidad, j.fichAnual from jugadoras j
--  join equipos e on j.numReg = e.numReg
--  join equipos on e.numReg = j.numReg
--  where j.salMes * 10 > 80000

--7. Modificar la vista anterior de forma que:
--� se excluya el sexo.
--� las/os jugadoras/es superen los 25000�, en el acumulado de todos sus ingresos,
---en los 10 meses del a�o.

--go
--alter view vw_mejorpagada as
--select j.nombre, j.ape1, j.ape2, e.numReg, j.salMes, j.publicidad, j.fichAnual from jugadoras j
--  join equipos e on j.numReg = e.numReg
--  where (j.salMes + j.fichAnual + j.publicidad) * 10 > 25000

--8. Modificar la vista anterior de forma que se incluya:
--� el c�digo de la jugadora.
--� el nombre del equipo al que pertenece cada jugador.
--� la comunidad aut�noma a la que est� asignado el equipo.

--go
--alter view vw_mejorpagada as
--select j.numFed, j.nombre [Nombre Jugadora], j.ape1, j.ape2, e.numReg, e.nombre [Nombre Equipo], j.salMes, j.publicidad, j.fichAnual, ca.nombre [Nombre Comunidad] from jugadoras j
--  join equipos e on j.numReg = e.numReg
--  join comunidades ca on ca.ccaa = e.ccaa
--  where (j.salMes + j.fichAnual + j.publicidad) * 10 > 25000

--9. Se desea gratificar a las jugadoras con menor ingreso en publicidad de entre las
--personas que puede ver la vista VW_mejorpagada.
--En esta gratificaci�n se incluyen a:
--� las personas que no tengan ingresos en publicidad.
--� las personas con el menor ingreso en publicidad.
--La gratificaci�n consiste en aumentar en 5000� el cap�tulo de ficha anual.
--Se debe usar la vista VW_mejorpagada para la ejecuci�n de la gratificaci�n.

--update vw_mejorpagada
--set fichAnual = fichAnual + 5000
--where publicidad = 0 or publicidad = (select min(publicidad) from vw_mejorpagada)

--10. Se desea gratificar a las jugadoras con menor ingreso en publicidad.
--En esta gratificaci�n se incluyen a:
--� Solo a las personas con el menor ingreso en publicidad.
--La gratificaci�n consiste en aumentar en 5000� el cap�tulo de ficha anual.
--Se debe usar la tabla, donde se mantienen los ingresos de las jugadoras, para la
--ejecuci�n de la gratificaci�n.
--Antes de realizar la gratificaci�n comprueba:
--� la visibilidad que tiene la vista VW_mejorpagada antes de actualizar la tabla.
--� la visibilidad que tiene la vista VW_mejorpagada despu�s de la actualizaci�n.

--select * from vw_mejorpagada
  
--update vw_mejorpagada
--set fichAnual = fichAnual + 5000
--where publicidad = (select min(publicidad) from vw_mejorpagada)

--select * from vw_mejorpagada

--11. La federaci�n catalana de hockey, para la entrega del premio stick de oro, precisa
--conocer las/los goleadoras/es, y n�mero de goles, de las/los que intervienen en los
--equipos catalanes de la liga regular.
--Para ello, el equipo de desarrollo de software, facilita la vista VW_stick al equipo de
--desarrollo de la federaci�n catalana.
--La vista contiene:
--� Nombre del equipo
--� C�digo de la jugadora
--� Nombre completo de la jugadora
--� N�mero total de goles

--go
--create view vw_stick as
--select e.nombre [NombreEquipo], j.numFed, j.nombre NombreJugadora, j.ape1, j.ape2, count(*) [N� Goles] from golear gol
--	join jugadoras j on gol.numfed = j.numfed
--	join equipos e on j.numreg = e.numreg
--group by e.nombre, j.numFed, j.nombre, j.ape1, j.ape2
  
--12. La organizaci�n precisa conocer cu�ntas/os deportistas hay por equipo no desaparecido.
--Para ello encarga la creaci�n de la vista VW_juegaequipo.
--La vista contiene:
--� C�digo del equipo
--� Nombre del equipo
--� N�mero total de jugadoras/es

--go
--create view vw as
--select e.numReg, e.nombre, count(j.numFed) [N� Jugadoras] from equipos e
--  join jugadoras j on j.numReg = e.numReg
--  where desaparecido = 'n'
--group by e.numReg, e.nombre

