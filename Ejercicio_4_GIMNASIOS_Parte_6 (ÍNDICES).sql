USE GIMNASIOS

--1. Crear un �ndice no agrupado que no permita valores duplicados en la tabla
--profesores.
--El campo de actuaci�n ser� el dni en sentido descendente y la denominaci�n del
--�ndice ser� idx_dniprofe.

create unique index idx_dniprofe
on Profesores (Dni desc) 


--2. Crear un �ndice no agrupado que no permita valores duplicados en la tabla
--alumnos.
--El campo de actuaci�n ser� el dni y la denominaci�n del �ndice ser�
--idx_dnialum.

create unique index idx_dnialum
on Alumnos (Dni)

--3. Crear un �ndice compuesto y no agrupado que permita valores duplicados en la
--tabla alumnos.
--El conjunto de campos de actuaci�n ser� el formado por apellido1, apellido2 y
--el nombre del alumno/a. La denominaci�n del �ndice ser� idx_nombre.

create index idx_nombre
on Alumnos (Apellido1, Apellido2, nombre)

--4. Crear un �ndice compuesto y no agrupado que no permita valores duplicados en
--la tabla demandar.
--El conjunto de campos de actuaci�n ser� el formado por la actividad y el
--alumno. La denominaci�n del �ndice ser� idx_activinombre.

create unique index idx_activinombre
on Demandar (idActividad, idAlumno)

--5. Desactivar el �ndice de la tabla profesores.

alter index idx_dniprofe on
Profesores disable

--6. Activar el �ndice idx_dniprofe de la tabla profesores.

alter index idx_dniprofe on
Profesores rebuild

--7. Borrar el �ndice idx_dniprofe de la tabla profesores.

drop index idx_dniprofe

--8. Insertar la demanda de la actividad 3 por el alumno 3. Recuerda que tiene
--un campo clave de autoincremento y existe un �ndice de unicidad. �Qu� sucede?

insert into Demandar (idAlumno, idActividad)
values(3,3)


--9. Insertar la demanda de la actividad 4 por el alumno 5. Recuerda que tiene
--un campo clave de autoincremento y existe un �ndice de unicidad. �Qu� sucede?

insert into Demandar (idAlumno, idActividad)
values(4,5)


--10. Insertar una nueva demanda de actividad por parte del alumno 7. Este
--nuevo registro poseer� el c�digo de registro 10 para la actividad n�mero 6.
--(Deben incluirse los 3 valores en la orden de inserci�n)

--terminar