use GIMNASIOS

--1. Se desea crear una vista que contenga la relación Profesor-Alumno-Clase. Las
--columnas se etiquetarán como Profesorado, Alumnado y Actividad, siendo su
--contenido el que se muestra en la figura ‘Ejemplo de Salida’.
--La vista se llamará vw_ProfesorAlumno.

--GO

--CREATE VIEW view_ProfesorAlumno AS 

--select prof.nombre Nombre_Profesor, a.nombre as Nombre_Alumno, cla.idActividad from alumnos a
--	inner join clases cla on cla.idAlumno = a.idAlumno
--	inner join Actividades ac on ac.idActividad = cla.idActividad
--	inner join Profesores prof on prof.idProfesor = ac.idProfesor

--select * from view_ProfesorAlumno
	

--2. Actuando sobre la vista anterior, muestra todos los alumnos del profesor Felipe y
--la descripción de la actividad que están recibiendo.

--select nombre_alumno, a.descripcion, nombre_profesor from view_ProfesorAlumno, Actividades a
--	where a.idActividad = view_ProfesorAlumno.idActividad
--	and view_ProfesorAlumno.nombre_profesor = 'Felipe'
	 

--3. La profesora Rosa, ha dicho que quiere figurar como Rosario y no como Rosa.
--Actualiza su nombre desde la vista view_ProfesorAlumno.

--UPDATE view_ProfesorAlumno
--set nombre_Profesor = 'Rosario'
--where nombre_profesor = 'Rosa'

--4. En la tabla Recibos, el campo fPago debe poder admitir valores nulos
--select * from recibos
--ALTER TABLE RECIBOS
--ALTER COLUMN fPago date NULL

--5. Generar una vista que permita generar todos los recibos de las actividades
--cursadas. La vista deberá tener, el identificador del alumno y la suma de lo que
--tiene que pagar por los cursos en los que está matriculado. La vista se
--denominará vw_GeneraRecibo

--GO 

--CREATE VIEW vw_GeneraRecibo AS
	
--select distinct al.idalumno Alumno, sum(a.importeActividad) ImporteAlumno from Actividades a, Alumnos al, clases cla
--	where a.idActividad = cla.idActividad
--	and cla.idalumno = al.idalumno
--	group by al.idalumno


--select * from vw_GeneraRecibo

--6. Insertar en la tabla Recibos los recibos del alumnado, es decir, los datos que se
--deben insertar están en la vista vw_GeneraRecibo (alumno e importe). La fecha
--de Emisión es la fecha del día y la fecha de pago es NULL.

--insert into Recibos
--select Alumno, getDate(), null, ImporteAlumno	
--	from vw_GeneraRecibo

--select * from recibos

--7. Generar la vista vw_Recibos115. El contenido de la vista será:
--• Importe de aquellos recibos que son superiores al 115% del importe medio de
--todos los recibos generados.
--• Nombre completo del alumno/a al que pertenece cada recibo.
--(Utiliza las vistas creadas)

--GO 

--CREATE VIEW vw_Recibos115 AS

--select distinct importeAlumno, al.nombre, al.apellido1, al.apellido2 from vw_GeneraRecibo
--	inner join alumnos al on al.idAlumno = vw_GeneraRecibo.alumno
--	where importeAlumno > (select ((sum(importeAlumno)  / count(importeAlumno)) * 1.15) from vw_GeneraRecibo)
	

--8. Muestra el nombre de las actividades en las que participan más de 3 alumnos.
--Utiliza las vistas creadas y realiza la consulta de 2 formas diferentes:
--• Con subconsultas
--• Sin subconsultas

--select ac.descripcion from Actividades ac
--	where 3 < (select count(*) from view_ProfesorAlumno vpa where vpa.idactividad = ac.idActividad)

--select ac.descripcion, count(*) as veces from Actividades ac
--	JOIN view_ProfesorAlumno vpa ON vpa.idActividad = ac.idActividad
--	group by ac.descripcion
--	having 3 < count(*)

--9. Crear la vista vw_ActividadSinUso, con el objeto de mantener el código de las
--actividades que no han sido nunca utilizadas por el alumnado.
--(Utiliza las vistas creadas)

--GO

--CREATE VIEW vw_ActividadSinUso AS

--select idActividad [idActividad] from Actividades
--	where idActividad NOT IN (select idActividad from view_profesoralumno)


--10. Si registramos una alta de actividad/alumno en las clases que se imparte:
--Alumno: 2, Actividad: 5, Fecha: 10/04/2033
--¿Qué sucede con el contenido que hemos generado en las vistas anteriores?
--Comprueba los resultados de todas las vistas antes y después de realizar la
--inserción en la tabla clases.
--select * from vw_ActividadSinUso
--select * from view_ProfesorAlumno
--select * from vw_GeneraRecibo

--insert into clases (idalumno, idactividad, fecha)
--values (2,5,'10/04/2033')
	
--select * from vw_ActividadSinUso
--select * from view_ProfesorAlumno
--select * from vw_GeneraRecibo

--11. El ejercicio nº 10 de la parte 4 pedía realizar un listado de las actividades que
--no se imparten, y que han sido demandadas por alguno de los alumnos que
--están cursando alguna actividad.
--Generar la vista vw_demandas para obtener las actividades demandadas por
--alumnado que cursa alguna actividad.
--Posteriormente modifica las consultas nº10 de la parte 4 con la vista
--vw_demandas.

--go
--create view vw_demandas as
--select distinct dem.idactividad
--	from demandar dem
--	where dem.idalumno in 
--		(
--		select distinct idAlumno from clases cla 
--		JOIN Actividades act ON cla.idActividad = act.idActividad 
--		where act.activa = 's'
--		)
	
--select * from vw_demandas

--select descripcion from Actividades ac
--	where activa = 'n'
--	and
--	ac.idActividad in (select idActividad from vw_demandas)

--select * from (

--		select descripcion from Actividades
--		where activa = 'n' 
--		and
--		idActividad in (select idActividad from vw_demandas)


--		) as Pivote



--12. Se necesita crear la vista vw_Resumen para obtener por cada actividad el
--número de demandas y el número de personas que la cursan.
--La salida será del siguiente tipo:

--GO

--CREATE VIEW vw_resumen AS
--select ac.idactividad,
--	   (select count(*) from demandar d where d.idActividad = ac.idactividad) numDemandas,
--	   (select count(*) from clases c where c.idActividad = ac.idActividad) AlumnosDemandando
--	from Actividades ac
--	group by ac.idactividad

--13. Partiendo de la vista vw_Resumen realizar la consulta que permita conocer
--el nombre de:
--• Las actividades cursadas y no demandadas
--• Las actividades demandadas y no cursadas por nadie.


--	select a.idactividad as [Actividades Cursadas & No Demandadas] from actividades a
--			join vw_resumen vwr on vwr.idactividad = a.idActividad
--			where vwr.numdemandas > 0 and 0 = vwr.alumnosdemandando
--union
--	select a.idactividad as [Actividades Cursadas & No Demandadas] from actividades a
--			join vw_resumen vwr on vwr.idactividad = a.idActividad
--			where vwr.numdemandas = 0 and 0 < vwr.alumnosdemandando


--14. Partiendo de la vista vw_Resumen realizar la consulta que permita conocer
--el número de:
--• actividades demandadas que superan a las cursadas.
--• actividades cursadas que superan a las demandadas.
--• actividades cuyo +número de demandas y número de cursadas coinciden.
--La salida será del siguiente tipo:

select * from vw_resumen


select (select count(*) from vw_resumen vwr 
				where vwr.numdemandas > alumnosdemandando) as DSC,
	(select count(*) from vw_resumen vwr 
				where vwr.numdemandas < alumnosdemandando) as CSD,
	(select count(*) from vw_resumen vwr 
				where vwr.numdemandas = alumnosdemandando) as NDCC

