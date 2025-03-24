use GIMNASIOS
--EJERCICIO 3.2
--2. Realizar las siguientes acciones de actualización:
--a. El alumno Clara de la Torre Huertas cambia el teléfono de contacto, que pasa a ser 965080807.
--UPDATE Alumnos
--SET telefono = '965080807'
--WHERE nombre = 'Clara' and apellidos = 'de la Torre Huertas'
--b. La actividad Just Pump pasa a estar activa.
--UPDATE Actividades
--SET activa = 's'
--WHERE descripcion = 'Just Pump'
--c. Se ha detectado que el alumno Pérez Carrasco, Ángel tiene el número 22, cuando debería tener
--el número 2.
--UPDATE Alumnos
--SET idAlumno = 2
--WHERE idAlumno = 22
--d. Se debe añadir un nuevo atributo a la tabla de actividades. El atributo es el precio de la
--actividad, que será un campo entero.
--ALTER TABLE Actividades
--ADD importeActividad int
--e. Se establece que todas las actividades cuesten 20 euros.
--UPDATE Actividades
--set importeActividad = 20
--f. El precio de las actividades de Judo y Halterofilia se incrementa un 20%
--UPDATE Actividades
--SET importeActividad = (20+20*0.2)
--WHERE descripcion in ('Judo', 'Halterofilia')
--select * from actividades
--g. El precio del aerobic es un 10% mayor que el precio del Judo
--UPDATE Actividades
--SET importeActividad = (
--(
--select importeActividad from Actividades
--where descripcion = 'Judo'
--)
--+
--(
--select importeActividad from Actividades
--where descripcion = 'Judo'
--) * 0.1 )

--WHERE descripcion in ('Aerobic')
--select * from actividades

--h. En la tabla profesores añadimos los atributos:
	--✓ Apellido1. Es un nvarchar(30) que NO permite nulos.
	--✓ Apellido2. Es un nvarchar(30) que permite nulos.
	--✓ Dni. Es un nvarchar(9) que NO permite nulos.--ALTER TABLE Profesores
--ADD DNI nvarchar(9) not null default ' ',--Apellido1 nvarchar(30) not null default ' ',--Apellido2 nvarchar(30) --select * from Profesores--i. Actualizamos la información de los campos creados en el apartado anterior, asignando los
--apellidos que corresponden a cada profesor en los campos apellido1 y apellido2. Así mismo se
--actualiza la información del dni según la tabla siguiente:--UPDATE Profesores--SET DNI = '11111111H', Apellido1 = 'Fernández', Apellido2 = 'Benítez'--where idProfesor = 1--UPDATE Profesores--SET DNI ='22222222J', Apellido1 = 'García', Apellido2 = 'Rodríguez'--where idProfesor = 2--UPDATE Profesores--SET DNI = '33333333P', Apellido1 = 'Gómez', Apellido2 = 'Rodríguez'--where idProfesor = 3--select * from profesores--j. Eliminar la columna apellidos, previa comprobación de que los datos que van a desaparecer,
--están presentes en los campos creados al efecto.

--select * from profesores

--ALTER TABLE Profesores
--DROP COLUMN apellidos

--select * from profesores

--k. En la tabla alumnos añadimos los atributos:
	--✓ Apellido1. Es un nvarchar(30) que NO permite nulos.
	--✓ Apellido2. Es un nvarchar(30) que permite nulos.
	--✓ Dni. Es un nvarchar(9) que NO permite nulos.--ALTER TABLE Alumnos
--ADD DNI nvarchar(9) not null default ' ',--Apellido1 nvarchar(30) not null default ' ',--Apellido2 nvarchar(30) --select * from Alumnos--l. Actualizamos la información de los campos creados en el apartado anterior, asignando los
--apellidos que corresponden a cada profesor en los campos apellido1 y apellido2. Así mismo se
--actualiza la información del dni según la tabla siguiente:

--UPDATE Alumnos
--SET 
--Apellido1 = 'Núñez', Apellido2 = 'Gil', DNI = '44444444A'
--where idAlumno=1

--UPDATE Alumnos
--SET 
--Apellido1 = 'Pérez', Apellido2 = 'Carrasco', DNI = '55555555K'
--where idAlumno=2

--UPDATE Alumnos
--SET 
--Apellido1 = 'De la Torre', Apellido2 = 'Huertas', DNI = '66666666Q'
--where idAlumno=3

--UPDATE Alumnos
--SET 
--Apellido1 = 'Ojeda', Apellido2 = 'López', DNI = '77777777B'
--where idAlumno=4

--UPDATE Alumnos
--SET 
--Apellido1 = 'Sánchez', Apellido2 = 'Pérez', DNI = '88888888Y'
--where idAlumno=5

--UPDATE Alumnos
--SET 
--Apellido1 = 'López', Apellido2 = 'Vergudo', DNI = '99999999R'
--where idAlumno=6

--UPDATE Alumnos
--SET 
--Apellido1 = 'Ruíz', Apellido2 = 'Jiménez', DNI = '12345678Z'
--where idAlumno=7

--UPDATE Alumnos
--SET 
--Apellido1 = 'Peña', Apellido2 = 'Sola', DNI = '87654321X'--where idAlumno=8--select * from alumnos--m. Eliminar la columna apellidos, previa comprobación de que los datos que van a desaparecer,
--están presentes en los campos creados al efecto.--select * from alumnos--ALTER TABLE alumnos--drop column apellidos--select * from alumnos--n. Se dan de alta 2 nuevos alumnos con el siguiente conjunto de datos:--INSERT INTO Alumnos(idalumno, Apellido1, Apellido2, nombre, dni, activo, telefono)
--Values
--(10, 'Sánchez', 'Pérez', 'Luis', '22228888D', 's', '666888999'),
--(11, 'Núñez', 'Gil', 'David', '55556666M', 's', '655777722')--o. El alumno David Núñez Gil demanda la actividad de Aerobic y Halterofilia.
--Intenta realizar el ejercicio con sentencias select para insertar los valores de los datos
--(Utiliza declare para declarar variables)--declare @nombre int = (select idalumno from Alumnos where nombre = 'David' and Apellido1 = 'Núñez') --declare @actividad1 int = (select idActividad from actividades where descripcion = 'Aerobic')--declare @actividad2 int = (select idActividad from actividades where descripcion = 'Halterofilia')--insert into Demandar--(idAlumno ,idActividad)--values --(@nombre , @actividad1),--(@nombre , @actividad2)--p. Eliminar la restricción de clave principal de la tabla Demandar.

--ALTER TABLE Demandar--DROP CONSTRAINT PK_DEMANDAR

--q. En la tabla demandar añadir el atributo registro.
--El contenido del campo serán valores numéricos que se iniciarán con el valor 1, siendo el resto
--de valores del mismo campo un autoincremento unitario. (Manejar identity(1,1))

--ALTER TABLE Demandar
--ADD registro int identity(1,1)

--r. En tabla demandar crear una restricción de clave principal.
--El campo clave principal será registro y la denominación de la restricción será
--pk_RegistroDemandar.

--ALTER TABLE Demandar
--ADD CONSTRAINT PK_REGISTRO_DEMANDAR PRIMARY KEY (idAlumno, idActividad, registro)