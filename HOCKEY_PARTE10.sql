use PATINAZO

--Se ha detectado que los operadores de datos cometen bastantes errores al añadir los goles de
--la jornada en la tabla GOLEAR, por ello se desea implementar lo siguiente:
--Con la finalidad de acelerar los procesos de búsqueda se ha decidido crear índices.

--1. Crear el índice no agrupado idx_localidad en la tabla EQUIPOS mediante el atributo
--localidad.

create non clustered index idx_localidad
on Equipos(Localidad)

--2. Crear el índice único no agrupado idx_localidad2 en la tabla EQUIPOS mediante el
--atributo localidad.

create non clustered unique index idx_localidad2
on Equipos(Localidad)

--3. Crear el índice idx_nombre en la tabla COMUNIDADES mediante el atributo nombre.

create index idx_nombre on
Comunidades(nombre)

--4. Crear el índice compuesto idx_jugadora en la tabla JUGADORAS mediante los atributos
--primer apellido y nombre.

create clustered index idx_jugadora
on Jugadoras(nombre, ape1)

--5. Desactivar el índice idx_localidad de la tabla EQUIPOS.

alter index idx_localidad on equipos disable

--6. Borrar el índice idx_localidad2 de la tabla EQUIPOS.

drop index idx_localidad2

--7. Modificar el índice compuesto idx_jugadora en la tabla JUGADORAS, añadiendo el
--atributo segundo apellido, en sentido descendente, después del primer apellido y antes
--del nombre.

alter index idx_jugadora on Jugadoras(ape1, ape2 desc, nombre)

--8. Activar nuevamente el índice idx_localidad de la tabla EQUIPOS:

alter index idx_localidad on equipos rebuild
