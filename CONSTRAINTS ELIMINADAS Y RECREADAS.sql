use GIMNASIOS
ALTER TABLE Alumnos
DROP CONSTRAINT CK_ACTIVO

ALTER TABLE Demandar
DROP CONSTRAINT FK_DEMANDAR_ACTIVIDADES, FK_DEMANDAR_ALUMNOS
 
ALTER TABLE Actividades
DROP CONSTRAINT FK_ACTIVIDADES_TEACHERS

ALTER TABLE Profesores
DROP CONSTRAINT PK_PROFESORES

ALTER TABLE Demandar
	add constraint FK_DEMANDAR_ACTIVIDADES FOREIGN KEY (idActividad)
		references Actividades(idActividad),
	constraint FK_DEMANDAR_ALUMNOS FOREIGN KEY (idAlumno)
		references Alumnos(idAlumno)

ALTER TABLE Actividades
add constraint FK_ACTIVIDADES_TEACHERS FOREIGN KEY (idProfesor)
	references Profesores(idProfesor)

ALTER TABLE Profesores
	add constraint PK_TEACHERS PRIMARY KEY (idProfesor)


