USE GIMNASIOS

--1. Crear un índice no agrupado que no permita valores duplicados en la tabla
--profesores.
--El campo de actuación será el dni en sentido descendente y la denominación del
--índice será idx_dniprofe.

create unique index idx_dniprofe
on Profesores (Dni desc) 


--2. Crear un índice no agrupado que no permita valores duplicados en la tabla
--alumnos.
--El campo de actuación será el dni y la denominación del índice será
--idx_dnialum.

create unique index idx_dnialum
on Alumnos (Dni)

--3. Crear un índice compuesto y no agrupado que permita valores duplicados en la
--tabla alumnos.
--El conjunto de campos de actuación será el formado por apellido1, apellido2 y
--el nombre del alumno/a. La denominación del índice será idx_nombre.

create index idx_nombre
on Alumnos (Apellido1, Apellido2, nombre)

--4. Crear un índice compuesto y no agrupado que no permita valores duplicados en
--la tabla demandar.
--El conjunto de campos de actuación será el formado por la actividad y el
--alumno. La denominación del índice será idx_activinombre.

create unique index idx_activinombre
on Demandar (idActividad, idAlumno)

--5. Desactivar el índice de la tabla profesores.

alter index idx_dniprofe on
Profesores disable

--6. Activar el índice idx_dniprofe de la tabla profesores.

alter index idx_dniprofe on
Profesores rebuild

--7. Borrar el índice idx_dniprofe de la tabla profesores.

drop index idx_dniprofe

--8. Insertar la demanda de la actividad 3 por el alumno 3. Recuerda que tiene
--un campo clave de autoincremento y existe un índice de unicidad. ¿Qué sucede?

insert into Demandar (idAlumno, idActividad)
values(3,3)


--9. Insertar la demanda de la actividad 4 por el alumno 5. Recuerda que tiene
--un campo clave de autoincremento y existe un índice de unicidad. ¿Qué sucede?

insert into Demandar (idAlumno, idActividad)
values(4,5)


--10. Insertar una nueva demanda de actividad por parte del alumno 7. Este
--nuevo registro poseerá el código de registro 10 para la actividad número 6.
--(Deben incluirse los 3 valores en la orden de inserción)

--terminar