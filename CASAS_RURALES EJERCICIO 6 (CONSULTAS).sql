use CASAS_RURALES 

--1. Obtener el grado de dificultad y el número de actividades que cumplen el grado de
--dificultad, de aquellas actividades que se dedican a la actividad del paseo.

--select distinct dificultad, count(idactividad) [Nº Actividades] from Actividades
--	where descripcion not in (select descripcion from Actividades where descripcion not like '%Paseo%')
--	group by dificultad
--	having dificultad > 1
	

--2. Obtener el nombre, teléfono de los alojamientos y el nombre de los empleados que han
--trabajado, en los alojamientos que están situados en el concejo de Castropol.

--select a.nombre, a.telefono, p.nombre from personal p
--	left join alojamientos a on a.pContacto = p.idTrabajador
--	left join trabajar t on t.idTrabajador = p.idTrabajador
--	where a.direccion like '%Castropol%'
--	and t.fecBaja is not null

--SELECT -- compilador priego
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


--select a.descripcion, count(o.idactividad) [Veces Ofertada], isnull(o.dia, 'Sin día') [Día] from Actividades a
--	left join Organizar o on o.idActividad = a.idActividad
--	group by a.descripcion, o.dia


--select a.idactividad, 
--	count(o.idactividad) [Numero De Veces],
--	isnull(o.dia, 'SIN DIA') Dia
--	from Actividades a left join organizar o
--	on o.idActividad = a.idActividad
--	group by a.idActividad, o.dia
--	order by 2, 3, 1  --solucion compilador priego


--4. De los alojamientos que dirigen personal con residencia en Gijón. ¿Cuántos ofertan más de
--2 y menos de 7 actividades a la semana?

--select count(o.idAlojamiento) [Actividades Ofertadas] from Alojamientos a
--	right join Organizar o on o.idAlojamiento = a.idAlojamiento
--	where a.pContacto in(select idTrabajador from personal where direccion like '%Gijón%') PREGUNTAR
--	group by a.pContacto
--	having count(o.idAlojamiento) between 3 and 6

--select COUNT(*) as [Número de establecimientos hoteleros] from alojamientos
--	where pcontacto in (select idtrabajador from Personal
--	where direccion like '%gijon%')
--	and idalojamiento =any (select idalojamiento from organizar
--	group by idalojamiento
--	having COUNT(*) between 3 and 6)

--5. Obtener el nombre del alojamiento, la habitación y el precio de las habitaciones más caras
--del sistema.

--select a.nombre, h.idhabitacion, h.precio from alojamientos a
--	inner join habitaciones h on h.idAlojamiento = a.idAlojamiento
--	where h.precio = (select max(precio) from Habitaciones)

--6. Obtener el nombre de los alojamientos que poseen más de 3 habitaciones, y el precio de
--alguna de sus habitaciones, aplicándole un 35% de descuento es superior al precio medio
--de todas las habitaciones del sistema.


select alo.nombre, alo.direccion --REHACER
	from Alojamientos alo
		where 3 < (select count(*) from habitaciones hab
		 where hab.idAlojamiento = alo.idAlojamiento)
			and alo.idAlojamiento in (select distinct idalojamiento
						from Habitaciones
							where precio*0.65 > (select AVG(precio)
							from habitaciones))

--7. ¿Cuántos empleados han trabajado donde trabaja actualmente el Sr. Peláez?

	
--select count(*) as [Número de empleados]
--	from Trabajar tra
--	where tra.idAlojamiento = (select tra.idalojamiento
--								from Personal per JOIN trabajar tra
--								ON per.idTrabajador=tra.idTrabajador
--								where per.nombre like '%Pelaez%'
--								and tra.fecBaja is null)
--	and tra.fecBaja is not null
	

--8. Obtener los alojamientos que han realizado al menos 2 contratos de personal

--select a.nombre from alojamientos a
--	where 2 <= (select count(t.idAlojamiento) from Trabajar t
--	where t.idAlojamiento = a.idAlojamiento ) -- mi solucion

--select alo.nombre
--from Trabajar tra
--JOIN Alojamientos alo ON tra.idAlojamiento = alo.idAlojamiento
--group by alo.nombre
--having (COUNT(*)>=2) --solucion compilador priego

--9. ¿Cuál es el precio medio de las habitaciones dobles con baño por alojamiento?

--select a.nombre, cast(avg(h.precio) as decimal(5,2)) [Precio Medio] 
--	from Habitaciones h inner join Alojamientos a
--	on h.idAlojamiento = a.idAlojamiento
--	where baño = 's' and tipo = 'doble'
--	group by a.nombre

--10.¿Qué alojamientos tienen en común entre todos sus contratos el Sr. Luis Martínez y Sra.
--Susana García? (Utilizar intersecciones)

--select alo.nombre
--from Trabajar tra
--JOIN Alojamientos alo ON tra.idAlojamiento=alo.idAlojamiento
--where tra.idtrabajador = (select idtrabajador from Personal
--where nombre like '%Luis Martínez%')
--INTERSECT
--select alo.nombre
--from Trabajar tra
--JOIN Alojamientos alo ON tra.idAlojamiento=alo.idAlojamiento
--where tra.idtrabajador =(select idtrabajador from Personal
--where nombre = 'Sunana García')

--11.¿Qué empleados no han trabajado nunca?
 
--select * from Personal per
--where per.idTrabajador != ALL (select distinct idTrabajador from trabajar)

--12.Obtener el nombre, teléfono de los alojamientos y el nombre de los empleados actuales, de
--los alojamientos que están situados en el concejo de Castropol.
--(Utilizar una subconsulta en el FROM para filtrar los alojamientos de Castropol)

--select telefono, nombre, nombreAlojamiento from
--							(
							
--							select p.nombre, a.telefono, a.nombre as nombreAlojamiento from Alojamientos a
--							inner join Personal p on
--							p.idTrabajador = a.pContacto
--							where a.direccion like '%Castropol%'
							
--							)
--							as Resumen

--select per.nombre, alo.Nombre, alo.Telefono
--	from Personal per JOIN Trabajar tra ON tra.idTrabajador = per.idTrabajador
--	JOIN (select * from Alojamientos 
--		where direccion like '%castropol%') alo
--		ON alo.idAlojamiento = tra.idAlojamiento
--			where tra.fecBaja is null --solucion compilador priego

--13.Obtener el nombre y el número de actividades que realiza cada alojamiento a lo largo de la
--semana, ordenando la salida por el número de actividades en sentido descendente.

--select a.nombre, count(o.idAlojamiento) [Nº Actividades]
--	from Alojamientos a join organizar o
--	on o.idAlojamiento = a.idAlojamiento
--		group by a.nombre
--order by 2 desc

--select alo.nombre, COUNT(org.idActividad) as [Número de Actividades]
--	from Alojamientos alo
--	LEFT JOIN Organizar org
--	ON alo.idAlojamiento = org.idAlojamiento
--		group by alo.nombre
--order by 2 desc --solucion compilador priego

--14.¿Qué alojamientos no ofertan la actividad de máxima dificultad? Se entiende que la máxima
--dificultad está ponderada con el mayor valor en el atributo dificultad.
--(Realizar la consulta con subconsultas encadenadas)

--select distinct a.* from Alojamientos a inner join Organizar o
--	on o.idAlojamiento = a.idAlojamiento inner join Actividades ac
--	on ac.idActividad = o.idActividad
--	where ac.dificultad != (select max(dificultad) from Actividades)
	
--select * from Alojamientos
--	where idAlojamiento !=all
--		(select idalojamiento from organizar
--		where idactividad IN 
--			(select idactividad from actividades
--			where dificultad IN 
--				(select max(dificultad) from actividades))) --solucion compilador priego

--15.¿Qué actividades ofrece cada alojamiento los fines de semana?
--Realizar la consulta de 2 formas:
--• Solo con JOIN entre tablas en el FROM
--• Solo con subconsultas en la lista de selección

--select a.nombre, org.dia, ac.descripcion from Actividades ac join 
--		(select idActividad, idAlojamiento, dia from organizar
--		where dia in ('Sabado', 'Domingo')) org 
--		on org.idActividad = ac.idActividad
--		join Alojamientos a on org.idAlojamiento = a.idAlojamiento

--select alo.nombre, org.dia, act.descripcion
--		from organizar org
--		JOIN Alojamientos alo ON org.idAlojamiento = alo.idAlojamiento
--		JOIN Actividades act ON org.idActividad = act.idActividad
--		where org.dia in ('Sabado','Domingo')
--		order by 1, 2 -- solucion compilador priego

--select 
--	(select ac.descripcion from Actividades ac
--		where ac.idActividad = o.idActividad) [Actividad],
--	(select a.nombre from Alojamientos a
--		where a.idAlojamiento = o.idAlojamiento) [Alojamiento],
--	o.dia [Día]
--	from organizar o
--	where o.dia in ('Sabado', 'Domingo')

--select
--	(select alo.nombre from alojamientos alo
--		where alo.IdAlojamiento = org.IdAlojamiento) as NOMBRE,
--	org.dia as DIA,
--	(select act.descripcion from actividades act
--		where act.IdActividad = idActividad) as DESCRIPCIÓN
--	from organizar org
--	where org.dia in ('Sabado','Domingo')
--order by 1, 2 -- la de priego está mal?