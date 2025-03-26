use CASAS_RURALES

--1. En la tabla alojamientos se debe añadir un nuevo campo: disponible, el cual contendrá
--un carácter (‘s’ o ‘n’) para indicar si se puede alquilar o no. Cuando se crea un nuevo
--alojamiento y no se dice nada de la disponibilidad, se entiende que está disponible.

--alter table alojamientos
--add disponible nvarchar(1) default 's' not null

--alter table alojamientos
--add constraint CK_DISPONIBLE CHECK(disponible in ('s', 'n')) 


--2. En la tabla habitaciones se debe añadir un nuevo campo: ocupada, el cual contendrá un
--carácter (‘s’ o ‘n’) para indicar si está disponible o no. Cuando se crea una nueva habitación
--y no se dice nada sobre ella, se entiende que está disponible.

--alter table habitaciones
--add ocupada nvarchar(1) default 'n' not null

--alter table habitaciones
--add constraint CK_OCUPADA CHECK(ocupada in ('n', 's'))

--3. El precio de la habitación 4 del alojamiento 1 pasa a costar 45 euros.

--select * from habitaciones

--update habitaciones
--set precio = 45
--	where idhabitacion = 4 and idalojamiento = 1

--select * from habitaciones
--	where idhabitacion = 4 and idalojamiento = 1

--4. La actividad 3 pasa a tener un nivel de dificultad 1.

--select * from actividades

--update actividades
--set dificultad = 1
--	where idactividad = 3

--select * from actividades 
--	where idactividad = 3

--5. Se añade una nueva actividad.
--• Actividad: 8
--• Nombre: Piragüismo
--• Descripción: Descenso de ríos, con zonas de rápidos
--• Dificultad: 5

--insert into actividades(idactividad, nombre, descripcion, dificultad) values
--(8, 'Piragüismo', 'Descenso de ríos, con zonas de rápidos',  5)

--select * from actividades where idactividad = 8 

--6. La restricción de que la fecha de baja de un puesto de trabajo de un empleado debe ser
--mayor a la fecha de alta del empleado en la empresa, se modifica de forma que la fecha
--pueda ser mayor o igual a la fecha de alta.

--alter table trabajar
--drop constraint ck_fechas

--alter table trabajar
--add constraint ck_fechas
--check ((fecBaja >= fecAlta) OR (fecBaja is null))


--7. Las habitaciones que tengan un precio inferior al 70% del valor medio de todas las
--habitaciones, actualizaran el precio de las mismas aumentándolo en un 5%.

--update habitaciones
--set precio = precio*1.05
--	where precio < (select avg(precio) * 0.7 from habitaciones)

--8. Todas las habitaciones de tipo Sencillas, y numeración impar, del alojamiento situado en
--Sales, se transforman en tipo Triples y aumentan su precio en un 30%.

--select * from Habitaciones
--select * from alojamientos

--update Habitaciones
--	set precio = precio * 1.3
--		where tipo = 'Sencilla'
--		and
--		(idhabitacion % 2) != 0
--		and
--		idalojamiento = (select idAlojamiento from Alojamientos
--								where direccion like '%Sales%')


--9. Por falta de personal en cocina, el alojamiento de León, elimina todas las actividades de
--ocio que tenía organizadas con la temática de cocina.

--delete from Organizar
--	where idActividad = 6 and idAlojamiento = 5

--select * from organizar
--select * from organizar where idActividad = 6 and idAlojamiento = 5


--10. Los avances tecnológicos permiten que los teléfonos de los alojamientos posean menos de
--9 dígitos, con lo que nos vemos obligados a modificar la restricción que controlaba la
--cantidad de dígitos introducidos.

alter table alojamientos
drop constraint ck_telefono

--alter table Alojamientos
--add constraint ck_telefono check (CAST(telefono as integer) > 0)

--o tambien

--alter table alojamientos
--add constraint ck_telefono check(len(telefono) < 10 and isnumeric(telefono) = 1)

--11. Para hacer corresponder el contenido de los atributos de las tablas con sus etiquetas se
--decide renombrar, en la tabla organizar, el atributo fecha por dia.
--Una vez renombrado el atributo, deberemos mantener el chequeo de los días, tal como se
--encontraba al crear la tabla.
--(Ver el funcionamiento del procedimiento almacenado sp_rename)

--alter table organizar
--drop CK_DIA_SEMANA

--EXECUTE sp_rename
--@objname = N'dbo.organizar.dia', 
--@newname = N'dia', 
--@objtype = N'COLUMN' 

--alter table organizar
--add constraint CK_DIA_SEMANA CHECK (lower(dia) in ('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado','domingo'))