use CASAS_RURALES 

--1. Obtener el grado de dificultad y el número de actividades que cumplen el grado de
--dificultad, de aquellas actividades que se dedican a la actividad del paseo.

--select count(dificultad)  as NumActividades, dificultad from Actividades
--	where descripcion like '%Paseo%'
--	group by dificultad

--2. Obtener el nombre, teléfono de los alojamientos y el nombre de los empleados que han
--trabajado, en los alojamientos que están situados en el concejo de Castropol.


--select * from Trabajar
--select * from personal
--select * from actividades
--select * from organizar
--select * from alojamientos

--SELECT  REVISAR
--    a.nombre AS [Nombre Alojamiento],
--	a.telefono as [Telefono Alojamiento],
--    p.nombre AS [Nombre Personal]
--FROM 
--    trabajar t
--JOIN 
--    alojamientos a ON a.idAlojamiento = t.idAlojamiento
--JOIN 
--    personal p ON p.idTrabajador = t.idTrabajador
--	where a.direccion like '%castropol%'
--	and t.fecBaja is not null


--3. Independientemente del alojamiento, indicar por cada actividad el número de veces que se
--desarrollan estas en el día.
--Existe la posibilidad que alguna actividad esté en el catálogo de actividades y todavía no se
--esté ofertando.

--select a.idactividad, 
--	count(o.idactividad) [Numero De Veces],
--	isnull(o.dia, 'SIN DIA') Dia
--	from Actividades a left join organizar o
--	on o.idActividad = a.idActividad
--	group by a.idActividad, o.dia
--	order by 2, 3, 1


--4. De los alojamientos que dirigen personal con residencia en Gijón. ¿Cuántos ofertan más de
--2 y menos de 7 actividades a la semana?

--REHACER

--5. Obtener el nombre del alojamiento, la habitación y el precio de las habitaciones más caras
--del sistema.

--select a.nombre, h.idhabitacion, h.precio 
--	from Habitaciones h inner join Alojamientos a
--	on a.idAlojamiento = h.idAlojamiento
--	where precio in (select max(precio) from habitaciones)

--6. Obtener el nombre de los alojamientos que poseen más de 3 habitaciones, y el precio de
--alguna de sus habitaciones, aplicándole un 35% de descuento es superior al precio medio
--de todas las habitaciones del sistema.

select a.nombre, cast((h.precio - (h.precio*0.35)) as decimal(7,2)) precio 
	from Alojamientos a inner join Habitaciones h
	on h.idAlojamiento = a.idAlojamiento
	group by h.idHabitacion, a.nombre, h.precio
	having count(h.idHabitacion) > 3
	


		
		
	

--7. ¿Cuántos empleados han trabajado donde trabaja actualmente el Sr. Peláez?
--8. Obtener los alojamientos que han realizado al menos 2	ontratos de personal
--9. ¿Cuál es el precio medio de las habitaciones dobles con baño por alojamiento?
--10.¿Qué alojamientos tienen en común entre todos sus contratos el Sr. Luis Martínez y Sra.
--Susana García? (Utilizar intersecciones)
--11.¿Qué empleados no han trabajado nunca?
--12.Obtener el nombre, teléfono de los alojamientos y el nombre de los empleados actuales, de
--los alojamientos que están situados en el concejo de Castropol.
--(Utilizar una subconsulta en el FROM para filtrar los alojamientos de Castropol)
--13.Obtener el nombre y el número de actividades que realiza cada alojamiento a lo largo de la
--semana, ordenando la salida por el número de actividades en sentido descendente.
--14.¿Qué alojamientos no ofertan la actividad de máxima dificultad? Se entiende que la máxima
--dificultad está ponderada con el mayor valor en el atributo dificultad.
--(Realizar la consulta con subconsultas encadenadas)
--15.¿Qué actividades ofrece cada alojamiento los fines de semana?
--Realizar la consulta de 2 formas:
--• Solo con JOIN entre tablas en el FROM
--• Solo con subconsultas en la lista de selección