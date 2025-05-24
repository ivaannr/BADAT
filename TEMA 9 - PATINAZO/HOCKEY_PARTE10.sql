use PATINAZO

--Se ha detectado que los operadores de datos cometen bastantes errores al a�adir los goles de
--la jornada en la tabla GOLEAR, por ello se desea implementar lo siguiente:
--Con la finalidad de acelerar los procesos de b�squeda se ha decidido crear �ndices.

--1. Crear el �ndice no agrupado idx_localidad en la tabla EQUIPOS mediante el atributo
--localidad.

create nonclustered index idx_localidad
on Equipos(Localidad)

--2. Crear el �ndice �nico no agrupado idx_localidad2 en la tabla EQUIPOS mediante el
--atributo localidad.

create unique nonclustered index idx_localidad2
on equipos(localidad)

--3. Crear el �ndice idx_nombre en la tabla COMUNIDADES mediante el atributo nombre.

create index idx_nombre on
Comunidades(nombre)

--4. Crear el �ndice compuesto idx_jugadora en la tabla JUGADORAS mediante los atributos
--primer apellido y nombre.

create index idx_jugadora
on Jugadoras(nombre, ape1)

--5. Desactivar el �ndice idx_localidad de la tabla EQUIPOS.

alter index idx_localidad on equipos disable

--6. Borrar el �ndice idx_localidad2 de la tabla EQUIPOS.

drop index idx_localidad2 on equipos

--al estar deshabilitado es como si el index no existiera por lo tanto no deja borrarlo

--7. Modificar el �ndice compuesto idx_jugadora en la tabla JUGADORAS, a�adiendo el
--atributo segundo apellido, en sentido descendente, despu�s del primer apellido y antes
--del nombre.

drop index idx_jugadora on jugadoras
create index idx_jugadora on Jugadoras(ape1, ape2 desc, nombre)

--8. Activar nuevamente el �ndice idx_localidad de la tabla EQUIPOS:

alter index idx_localidad on equipos rebuild
