USE GIMNASIOS
CREATE TABLE Actividades
(
	idActividad INT NOT NULL,
	descripcion nvarchar(20) not null,
	idProfesor INT not null,
	activa nvarchar(1) not null default 's'
	constraint FK_ACTIVIDADES_PROFESORES FOREIGN KEY (idProfesores)
		references Profesores(idProfesor)
	constraint PK_ACTIVIDADES PRIMARY KEY (idActividad)
)

CREATE TABLE Profesores
(
	idProfesor INT NOT NULL,
	nombre nvarchar(30) not null,
	apellidos nvarchar(50) not null
	constraint PK_PROFESORES PRIMARY KEY (idProfesor)
)

CREATE TABLE Alumnos 
(
	idAlumno INT NOT NULL,
	nombre nvarchar(30) not null,
	apellidos nvarchar(50) not null,
	telefono nvarchar(9) not null,
	activo nvarchar(1) not null,
	constraint CK_TELEFONO CHECK (telefono like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), --esta muy muy muy muy muy muy muy muy mal
	constraint CK_ACTIVA CHECK ((activa like '%s%') or (activa like '%n%'))
	constraint PK_ALUMNOS PRIMARY KEY (idAlumno)
)

CREATE TABLE Clases 
(
	idAlumno INT not null,
	idActividad int not null,
	fecha date not null,
	constraint FK_CLASES_ACTIVIDADES FOREIGN KEY (idActividad)
		references Actividades(idActividad),
	constraint FK_CLASES_ALUMNOS FOREIGN KEY (idAlumno)
		references Alumnos(idAlumno),
	constraint PK_CLASES PRIMARY KEY (idAlumno, idActividad, fecha)
)

CREATE TABLE Demandar
(
	idAlumno INT not null,
	idActividad int not null,
	constraint FK_DEMANDAR_ACTIVIDADES FOREIGN KEY (idActividad)
		references Actividades(idActividad),
	constraint FK_DEMANDAR_ALUMNOS FOREIGN KEY (idAlumno)
		references Alumnos(idAlumno),
	constraint PK_DEMANDAR PRIMARY KEY (idAlumno, idActividad)
)

CREATE TABLE Recibos 
(
	idAlumno INT not null ,
	fEmision date not null,
	fPago date not null,
	importe int not null,
	constraint FK_RECIBOS_ALUMNOS FOREIGN KEY (idAlumno)
		references Alumnos(idAlumno)
)