use PATINAZO

--1. Añadir la competición Autonómica Asturiana que comienza el 12/03/2025 y finaliza
--el 25/05/2025. En la ejecución no debe incluirse el campo clave.

insert into competicion(nombre, fecIni, fecFin)
values ('Competición Autonómica Asturiana','2025-03-12', '2025-05-25')

--2. Añadir la competición Lega2 Catalunya que comienza el 12/03/2025 y finaliza el
--25/05/2025. En la ejecución no debe incluirse el campo clave.

insert into competicion(nombre, fecIni, fecFin)
values ('Competición Lega2 Catalunya','2025-03-12', '2025-05-25')

--3. Añadir el equipo Hockey Club Coruña que se asienta en la localidad de A Coruña.
--El equipo fue creado el 15/04/2023, se encuentra en estado de desaparecido, por lo
--que los valores de comunidad autónoma y representante deben ser los que se identifican
--como valores por defecto o ficticios.
--¿Es posible insertar este registro? ¿Podrías justificar el motivo?
--Datos a insertar:
--30,'Hockey Club Coruña','A Coruña','2023-04-15',null,null,'s','GAL',99

--No se podrá insertar el valor de ccaa como nulo ya que es la clave principal de la
--tabla de comunidades lo que impide que se puedan insertar valores nulos.


--4. Crear la vista VW_equipos, con la información que se pide abajo, para los equipos que
--no han desaparecido:
--Formato de vista: Código del equipo, nombre del equipo, descripción corta de la ccaa
  
go
create view vw_equipos as
select e.numReg [idEquipo], e.nombre [Nombre], ca.descCorta [DescCorta] from equipos e
  inner join comunidades as ca on ca.ccaa = e.ccaa
  where e.desaparecido = n

--5. Obtener la vista VW_Numequipos. La vista devuelve el número de equipos que no han
--desaparecido por cada comunidad autónoma, publicando: clave y nombre de la
--comunidad autónoma, y el número de equipos por CCAA.
--Realizar el ejercicio de 2 formas:
--• Sin el uso de la vista VW_Equipos.
--• Con el uso de la vista VW_Equipos.

go
create view vw_Numequipos as
select ca.nombre, ca.ccaa, count(ve.idEquipo) [nº Equipos] from vw_equipos ve
  inner join comunidades ca on ca.descCorta = ve.descCorta
  group by ca.nombre, ca.ccaa

--o

create view vw_Numequipos as
select ca.nombre, ca.ccaa, count(e.idEquipo) [nº Equipos] from Equipos e
  inner join comunidades ca on ca.ccaa = e.ccaa
  group by ca.nombre, ca.ccaa

--6. Realizar la vista denominada VW_mejor pagada que contenga:
--• nombre completo de las/os jugadoras/es
--• código del equipo
--• sexo
--• ingresos para aquellos jugadores que superen los 80000€, en el acumulado de
--todos sus ingresos, en los 10 meses del año.

go
create view vw_mejorpagada as
select j.nombre, j.ape1, j.ape2, e.numReg, j.sexo, j.salMes from jugadores j
  join equipos e on j.numReg = e.numReg
  join equipos on e.numReg = j.numReg
  where j.salMes * 10 > 80000

--7. Modificar la vista anterior de forma que:
--• se excluya el sexo.
--• las/os jugadoras/es superen los 25000€, en el acumulado de todos sus ingresos,
---en los 10 meses del año.

alter view vw_mejorpagada
select j.nombre, j.ape1, j.ape2, e.numReg, j.salMes from jugadores j
  join equipos e on j.numReg = e.numReg
  where j.salMes * 10 > 25000

--8. Modificar la vista anterior de forma que se incluya:
--• el código de la jugadora.
--• el nombre del equipo al que pertenece cada jugador.
--• la comunidad autónoma a la que está asignado el equipo.

alter view vw_mejorpagada
select j.numFed, j.nombre, j.ape1, j.ape2, e.numReg, e.nombre, j.salMes, ca.nombre from jugadores j
  join equipos e on j.numReg = e.numReg
  join comunidades ca on ca.ccaa = e.ccaa
  where j.salMes * 10 > 25000

--9. Se desea gratificar a las jugadoras con menor ingreso en publicidad de entre las
--personas que puede ver la vista VW_mejorpagada.
--En esta gratificación se incluyen a:
--• las personas que no tengan ingresos en publicidad.
--• las personas con el menor ingreso en publicidad.
--La gratificación consiste en aumentar en 5000€ el capítulo de ficha anual.
--Se debe usar la vista VW_mejorpagada para la ejecución de la gratificación.

update vw_mejorpagada
set fichAnual = fichAnual + 5000
where publicidad = 0 or publicidad = (select min(publicidad) from vw_mejorpagada)

--10. Se desea gratificar a las jugadoras con menor ingreso en publicidad.
--En esta gratificación se incluyen a:
--• Solo a las personas con el menor ingreso en publicidad.
--La gratificación consiste en aumentar en 5000€ el capítulo de ficha anual.
--Se debe usar la tabla, donde se mantienen los ingresos de las jugadoras, para la
--ejecución de la gratificación.
--Antes de realizar la gratificación comprueba:
--• la visibilidad que tiene la vista VW_mejorpagada antes de actualizar la tabla.
--• la visibilidad que tiene la vista VW_mejorpagada después de la actualización.

select * from vw_mejorpagada
  
update vw_mejorpagada
set fichAnual = fichAnual + 5000
where publicidad = (select min(publicidad) from vw_mejorpagada)

select * from vw_mejorpagada

--11. La federación catalana de hockey, para la entrega del premio stick de oro, precisa
--conocer las/los goleadoras/es, y número de goles, de las/los que intervienen en los
--equipos catalanes de la liga regular.
--Para ello, el equipo de desarrollo de software, facilita la vista VW_stick al equipo de
--desarrollo de la federación catalana.
--La vista contiene:
--• Nombre del equipo
--• Código de la jugadora
--• Nombre completo de la jugadora
--• Número total de goles

create view vw_stick as
select e.nombre, j.numFed, j.nombre, j.ape1. j.ape2, count(go.*) from equipos e
  join jugadoras j on j.numReg = e.numReg 
  join jugadoras on e.numReg = j.numReg 
  join golear go on go.numFed = j.numFed
group by e.nombre, j.numFed, j.nombre, j.ape1. j.ape2
  
--12. La organización precisa conocer cuántas/os deportistas hay por equipo no desaparecido.
--Para ello encarga la creación de la vista VW_juegaequipo.
--La vista contiene:
--• Código del equipo
--• Nombre del equipo
--• Número total de jugadoras/es

create view vw as
select e.numReg, e.nombre, count(j.numFed) from equipos e
  join jugadoras j on j.numReg = e.numReg 
  join jugadoras on e.numReg = j.numReg 
group by e.numReg, e.nombre
