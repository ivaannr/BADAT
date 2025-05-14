
create table COMUNIDAD
(
ccaa int not null,
nombre nvarchar(25) not null,
desCorta nvarchar(50),
numFede int not null,

constraint PK_COMUNIDAD PRIMARY KEY (ccaa),

)

create table COMPETICION
(

idComp int not null,
nombre nvarchar(25) not null,
fecIni date not null,
fecFin date not null,

constraint PK_COMPETICION PRIMARY KEY (idComp)

)

create table PARTIDOS
(
codPar int not null,
fecCel date not null,
golLoc int not null,
golVis int not null,
numEsp int not null,
eqLoc nvarchar(50) not null,
eqVis nvarchar(50) not null,
idComp int not null

constraint PK_PARTIDOS PRIMARY KEY (codPar)

)

create table GOLEAR
(
codPar int not null,
numFed int not null,
minuto int not null,

constraint PK_GOLEAR PRIMARY KEY (codPar, numFed, minuto)

)

alter table EQUIPOS
add ccaa int not null

alter table EQUIPOS
add constraint FK_EQUIPOSCOMUNIDAD FOREIGN KEY (ccaa)
	references COMUNIDAD(ccaa)

alter table PARTIDOS
add constraint FK_PARTIDOSEQUIPOS_eqLoc foreign key (eqLoc)
	references EQUIPOS(eqLoc)

alter table PARTIDOS
add constraint FK_PARTIDOSEQUIPOS_eqVis foreign key (eqVis)
	references EQUIPOS(eqVis)

alter table PARTIDOS
add constraint FK_PARTIDOSCOMPETICION foreign key (idComp)
	references EQUIPOS(idComp)

alter table GOLEAR
add constraint FK_GOLEARPARTIDOS foreign key (codPar)
	references GOLEAR(codPar)

alter table GOLEAR
add constraint FK_GOLEARJUAGDORAS foreign key (numFed)
	references GOLEAR(numFed)

--create unique index idx_dnijugadoras ----no añadir indices de momento
--	on JUGADORAS(dni)

--create index idx_nombrecomunidad
--	on COMUNIDAD(nombre)

--create index idx_nombreequipos
--	on EQUIPOS(nombre)

--create index idx_nombreecompeticion
--	on COMPETICION(nombre)