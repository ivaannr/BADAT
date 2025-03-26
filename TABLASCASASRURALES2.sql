use CASAS_RURALES 

--alter table actividades
--add constraint pk_idActividad PRIMARY KEY (idActividad)
--alter table actividades
--add default 1 for dificultad
--alter table actividades
--add constraint ck_dificultad
--CHECK (Dificultad IN ('1','2','3','4','5','6','7','8','9','10'))
--alter table actividades
--alter column descripcion nvarchar(200) null

--CREATE TABLE ALOJAMIENTOS
--(
--idAlojamiento integer not null,
--Nombre nvarchar(50) not null,
--Direccion nvarchar(80) not null,
--Telefono nvarchar(9) not null,
--pContacto integer not null,
--constraint pk_idAlojamiento PRIMARY KEY (idAlojamiento),
--constraint ck_telefono
--check (CAST(telefono as integer) > 0 and LEN(telefono)=9),
--constraint fk_pcontacto_idPersonal
--foreign key (pContacto)
--references Personal (idTrabajador)
--ON UPDATE CASCADE
--)
--CREATE TABLE TRABAJAR
--(
--idAlojamiento integer not null,
--Trabajador integer not null,
--fAlta date not null,
--fBaja date null,
--constraint pk_trabajador_alojamiento_fAlta
--PRIMARY KEY(Trabajador,idAlojamiento,fAlta),
--constraint ck_fechas check (fBaja > fAlta),
--constraint fk_talojamiento_talojamientos
--foreign key (idAlojamiento)
--references ALOJAMIENTOS (idAlojamiento)
--ON UPDATE CASCADE,
--constraint fk_ttrabajadores_personal
--foreign key (Trabajador)
--references Personal (IdTrabajador)
--ON UPDATE NO ACTION
--)



--CREATE TABLE Habitaciones 
--(
--idHabitacion int not null,
--idAlojamiento int not null,
--tipo nvarchar(20) not null,
--baño nvarchar(1) not null,
--precio decimal(3,2) not null,

--constraint CK_PRECIO CHECK (precio > 0),
--constraint CK_BAÑO CHECK (baño in ( 'n', 's')),
--constraint CK_IDHABITACION CHECK (idHabitacion > 0),
--constraint PK_HABICATIONES PRIMARY KEY (idHabitacion, idAlojamiento),
--constraint FK_HABITACIONES_ALOJAMIENTOS
--	foreign key (idAlojamiento) references Alojamientos (idAlojamiento)
--on update cascade
--)
--CREATE TABLE Organizar 
--(
--idActividad int not null,
--idAlojamiento int not null,
--dia nvarchar(10),

--constraint CK_DIA_SEMANA CHECK (lower(dia) in ('lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado','domingo')),
--constraint FK_ORGANIZAR_ALOJAMIENTOS FOREIGN KEY (idAlojamiento)
--	references Alojamientos(idAlojamiento) 
--	on update cascade,
--constraint FK_ORGANIZAR_Actividades FOREIGN KEY (idActividad)
--	references Actividades(idActividad)
--	on update cascade,
--constraint PK_ORGANIZAR PRIMARY KEY (idActividad, idAlojamiento)
--)

