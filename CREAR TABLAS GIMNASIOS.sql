USE GIMNASIOS
CREATE TABLE Actividades
(
idActividad INT NOT NULL PRIMARY KEY,
descripcion nvarchar(20) not null,
idProfesor INT not null,
activa nvarchar(1) not null
)

CREATE TABLE Profesores
(
idProfesor INT NOT NULL PRIMARY KEY,
nombre nvarchar(30) not null,
apellidos nvarchar(50) not null
)

CREATE TABLE Alumnos 
(
idAlumno INT NOT NULL PRIMARY KEY,
nombre nvarchar(30) not null,
apellidos nvarchar(50) not null,
telefono nvarchar(9) not null,
activo nvarchar(1) not null
)

CREATE TABLE Clases 
(
idAlumno INT not null primary key,
idActividad int not null,
fecha date not null
)

CREATE TABLE Demandar
(
idAlumno INT not null primary key,
idActividad int not null
)

CREATE TABLE Recibos 
(
idAlumno INT not null primary key,
fEmision date not null,
fPago date not null,
importe int not null
)