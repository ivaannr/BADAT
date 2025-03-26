use CASAS_RURALES

--2
GO
CREATE VIEW vw_NumActAlo as
	select COUNT(*) [Veces_Ofertada], id_alojamiento [Alojamiento] from ORGANIZAR
		group by Id_Alojamiento
		
--4. De los alojamientos que dirigen personal con residencia en Gijón. ¿Cuántos ofertan más de
--2 y menos de 7 actividades a la semana?
select al.id_Alojamiento from Alojamientos al
	inner join vw_NumActAlo vwnaa on vwnaa.Alojamiento = al.Id_Alojamiento
	where Direccion like 'Gijón'
	and vwnaa.Veces_Ofertada between 3 and 6


--3

GO
CREATE VIEW vw_Pelaez as
	select * from ALOJAMIENTOS al 
		inner join PERSONAL per on per.idTrabajador = al.P_Contacto
		where P_Contacto = (select idTrabajador from PERSONAL
							where nombre like 'Pelaez')

--7. ¿Cuántos empleados han trabajado donde trabaja actualmente el Sr. Peláez?select COUNT(al.p_contacto) [Personal] from ALOJAMIENTOS al		where Id_Alojamiento = vw_Pelaez.Id_Alojamiento--4GOCREATE VIEW vw_Habaño as	select al.Nombre [Alojamiento], COUNT(hab.Baño) [Baño] from ALOJAMIENTOS al		inner join HABITACIONES hab on hab.Id_Alojamiento = al.Id_Alojamiento		where Baño = 's'		group by al.Id_Alojamiento	Union	select al.Nombre [Alojamiento], COUNT(hab.Baño) [No Baño] from ALOJAMIENTOS al		inner join HABITACIONES hab on hab.Id_Alojamiento = al.Id_Alojamiento		where Baño = 'n'		group by al.Id_Alojamiento	select * from HABITACIONES--5GOCREATE VIEW vw_Vintage as	select * from PERSONAL per		inner join TRABAJAR tra on per.idTrabajador = tra.Id_Alojamiento