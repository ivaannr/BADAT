use CASAS_RURALES

CREATE TABLE Actividades 
(
idActividad int not null,
nombre nvarchar(20) not null,
descripcion nvarchar(200) not null,
dificultad int default 1,

constraint CK_Actividades CHECK (dificultad <= 10 OR dificultad >= 1),
constraint PK_Actividades PRIMARY KEY (idActividad)
)

CREATE TABLE Alojamientos
(
idAlojamiento int not null,
nombre nvarchar(50) not null,
direccion nvarchar(80) not null, 
telefono nvarchar(9) not null,
pContacto int not null,

constraint CK_TELEFONO CHECK (len(telefono) = 9 AND isnumeric(telefono) = 1), 
constraint PK_ALOJAMIENTOS PRIMARY KEY (idAlojamiento),

--constraint CK_TELEFONO CHECK (len(telefono) = 9 AND (cast(telefono as integer) > 0) otra opción
)


CREATE TABLE Personal 
(
idTrabajador int not null,
nombre nvarchar(50) not null,
direccion nvarchar(50) not null,
nif nvarchar(9) not null,

constraint CK_NIF CHECK (len(nif) = 9),
constraint PK_PERSONAL PRIMARY KEY (idTrabajador)
)

CREATE TABLE Habitaciones 
(
idHabitacion int not null,
idAlojamiento int not null,
tipo nvarchar(20) not null,
baño nvarchar(1) not null,
precio decimal(3,2) not null,

constraint CK_PRECIO CHECK (precio > 0),
constraint CK_BAÑO CHECK (baño = 'n' or baño = 's'),
constraint CK_IDHABITACION CHECK (idHabitacion > 0),
constraint PK_HABICATIONES PRIMARY KEY (idHabitacion, idAlojamiento),
constraint FK_HABITACIONES_ALOJAMIENTOS
	foreign key (idAlojamiento) references Alojamientos (idAlojamiento)
on update cascade
)

CREATE TABLE Organizar 
(
idActividad int not null,
idAlojamiento int not null,
dia nvarchar(10),

constraint CK_DIA_SEMANA CHECK (lower(dia) in ('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado','domingo')),
constraint FK_ORGANIZAR_ALOJAMIENTOS FOREIGN KEY (idAlojamiento)
	references Alojamientos(idAlojamiento)
	on update cascade,
constraint FK_ORGANIZAR_Actividades FOREIGN KEY (idActividad)
	references Actividades(idActividad)
	on update cascade,
constraint PK_ORGANIZAR PRIMARY KEY (idActividad, idAlojamiento)
)

CREATE TABLE Trabajar 
(
idAlojamiento int not null,
idTrabajador int not null,
fecAlta date not null,
fecBaja date not null,

constraint CK_FECHAS CHECK (fecAlta <= fecBaja),
constraint FK_TRABAJAR_ALOJAMIENTOS FOREIGN KEY (idAlojamiento)
	references Alojamientos(idAlojamiento)
	on update cascade,
constraint FK_TRABAJAR_PERSONAL FOREIGN KEY (idTrabajador)
	references Personal(idTrabajador)
	on update cascade,
constraint PK_TRABAJAR PRIMARY KEY (idAlojamiento, idTrabajador, fecAlta)
)

ALTER TABLE Alojamientos
add constraint FK_ALOJAMIENTOS_PERSONAL FOREIGN KEY (pContacto)
	references Personal(idTrabajador)