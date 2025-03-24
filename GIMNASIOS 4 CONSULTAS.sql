use GIMNASIOS

--1. Listado de todas las actividades activas
--select * from Actividades
--where activa like 's'

--2. Listado de las actividades (nombre) que son solicitadas (demandadas)
--select ac.idActividad, ac.descripcion from Actividades ac
--inner join Demandar de 
--on de.idActividad = ac.idActividad
--group by ac.descripcion, ac.idActividad

--3. Listado de profesores con las actividades que imparten.
--select prof.nombre, ac.descripcion
--from Profesores prof inner join Actividades ac
--on ac.idProfesor = prof.idProfesor
 

--4. Listado de todos los alumnos que participan en la actividad 2
--select al.*, de.idActividad from Alumnos al inner join Demandar de 
--	on de.idAlumno = al.idAlumno
--	where de.idActividad like 2

--5. Listado de todos los alumnos que participan en la actividad Halterofilia
--select al.nombre, al.idalumno, de.idActividad from Alumnos al 
--	inner join Demandar de 
--	on de.idAlumno = al.idAlumno
--	where de.idActividad = (select idActividad from Actividades where descripcion like 'Halterofilia')

--6. Listado de todas las actividades (activas o no) con un coste entre 24 y 26 euros
--select descripcion, idactividad, importeActividad from Actividades
--	where importeActividad between 24 and 26

--7. Acumulado del precio de todas las actividades que se están impartiendo
--select SUM(importeActividad) [Acumulado del precio] from Actividades

--8. Actividad y Precio más alto de las actividades que se imparten
--select MAX(importeActividad) [PRECIO.MAX], descripcion from Actividades
--	group by descripcion

--9. Importe por actividad que cobraremos por las clases que estamos impartiendo.
--select importeActividad, descripcion, activa from Actividades
--	where activa like 's'

--10. Listado de las actividades que no se están impartiendo, y que han sido
--solicitadas por alguno de los alumnos que están cursando alguna actividad.
--select ac.descripcion, ac.activa, de.idalumno from 
--Actividades ac inner join Demandar de 
--on ac.idActividad = de.idActividad
--	where ac.activa like 'n'