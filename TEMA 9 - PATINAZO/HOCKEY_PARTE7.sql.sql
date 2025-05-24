use PATINAZO

--alter table equipos
--add ccaa nvarchar(3)

--alter table equipos
--add numFed int 

--alter table equipos
--add constraint FK_EQUIPOSJUGADORAS FOREIGN KEY (numFed)
--	references jugadoras(numFed)


--1. Crear la tabla COMUNIDADES con las siguientes características:
--• Las que se indican en la tabla comunidades

--create table COMUNIDADES 
--(
--ccaa nvarchar(3) not null,
--nombre nvarchar(30) not null,
--desCorta nvarchar(200) null,
--numFed int not null

--constraint PK_COMUNIDADES PRIMARY KEY (ccaa)
--)

--2. Insertar los datos, que se indican abajo, de algunas comunidades que se incorporan al
--proyecto.

--insert into comunidades (ccaa, nombre, descorta, numfede)
--values
--('AST','Principado de Asturias','Asturias',300),
--('CAT','Cataluña','Cataluña',32000),
--('CAN','Islas Canarias','Canarias',1200),
--('GAL','Galicia','Galicia',2800),
--('ARA','Aragón','Aragón',1500),
--('CYL','Castilla y León','León',1100),
--('MAD','Madrid','Madrid',4950),
--('FIC','Ficticia',NULL,0)

--3. Crear la restricción que permita relacionar el equipo de hockey con la comunidad a la que
--pertenece. La restricción se denominará fk_ccaa y se asociará mediante el atributo ccaa.

--alter table equipos
--add constraint FK_CCAAEQUIPOS foreign key (ccaa)
--	references comunidades(ccaa)

--4. Debemos proceder a actualizar los datos de las ccaa de la tabla EQUIPOS de la base de
--datos.
--Las actualizaciones a realizar se reflejan en la siguiente tabla:
--CCAA Equipos (código)
--AST 1, 10, 12, 21
--CAT 2, 4, 5, 7, 9, 13, 14, 15, 16
--ARA 3
--GAL 6
--CAN 20
--CYL 8
--MAD 11
--FIC 99

--update equipos
--set ccaa = 'AST' where numreg in (1,10,12,21)

--update equipos
--set ccaa = 'CAT' where numreg in (2,4,5,7,9,13,14,15,16)

--update equipos set ccaa = 'ARA' where numreg = 3
--update equipos set ccaa = 'GAL' where numreg = 6
--update equipos set ccaa = 'CAN' where numreg = 20

--alter table equipos check constraint FK_CCAAEQUIPOS

--update equipos set ccaa = 'CYN' where numreg = 8

--update equipos set ccaa = 'MAD' where numreg = 11
--update equipos set ccaa = 'FIC' where numreg = 9



--5. Crear la tabla COMPETICION con las siguientes características:
--• Las que se indican en la tabla competición.
--• Se chequea que la fecha de inicio es anterior o igual a la fecha final.

--create table COMPETICION
--(
--idComp int not null,
--nombre nvarchar(50) not null,
--fecIni date not null,
--fecFin date not null,

--constraint CK_FECHAS check (fecIni <= fecFin),
--constraint PK_COMPETICION primary key (idComp)

--)

--6. Crear la tabla PARTIDOS con las siguientes características:
--• Las que se indican en la tabla partidos.
--• Tanto el número de los goles locales, goles visitantes y número de espectadores debe
--ser 0 por defecto.
--• Se chequea que el número de goles locales no sea negativo.
--• Se chequea que el número de goles visitantes no sea negativo.
--• Se chequea que el número de espectadores no sea negativo.
--• La restricción de la clave ajena para los equipos locales y visitantes no deben permitir
--actualizar en cascada.
--• La restricción de la clave ajena para el partido puede permitir la actualización en
--cascada.

--create table partidos 
--(
--codPar int not null,
--fecCel date not null,
--hora nvarchar(5) not null,
--golLoc int not null default 0,
--golVis int not null default 0,
--numEsp int not null default 0,
--eqLoc char(10) not null,
--eqVis char(10) not null,
--idComp int not null,

--constraint CK_VALORESNEGATIVOS check (golLoc >=0 and golVis >= 0 and numEsp >= 0),

--constraint FK_PARTIDOSCOMPETICION foreign key (idComp)
--	references competicion(idComp) ON UPDATE CASCADE,
   
--constraint FK_LOCALPARTIDOSEQUIPOS foreign key (eqLoc)
--	references equipos(numReg) ON UPDATE NO ACTION,

--constraint FK_VISITANTEPARTIDOSEQUIPOS foreign key (eqVis)
--	references equipos(numReg) ON UPDATE NO ACTION

--add constraint PK_PARTIDOS primary key (codpar)

--)


--7. Crear la tabla GOLEAR con las siguientes características:
--• Las que se indican en la tabla golear.
--• La restricción de la clave ajena para los partidos no debe permitir actualizar en cascada.
--• La restricción de la clave ajena para los jugadores no debe permitir actualizar en
--cascada.

--create table GOLEAR
--(
--codPar int not null,
--numFed int not null,
--minuto nvarchar(5) not null,

--constraint PK_GOLEAR PRIMARY KEY (codpar, numfed, minuto),

--constraint FK_GOLEARPARTIDOS foreign key (codpar)
--	references partidos(codpar) on update no action,

--constraint FK_GOLEARJUGADORAS foreign key (numfed)
--	references jugadoras (numfed) on update no action

--)

--8. Añadir una nueva restricción en la tabla PARTIDOS para chequear que los equipos local y
--visitante no sean el mismo dentro de un registro.

--alter table partidos
--add constraint CK_VISLOCAL CHECK(eqLoc != eqVis)

--9. Actualizar el tipo de dato de la columna salMes de la tabla JUGADORAS. El nuevo tipo de
--dato debe ser money.

--alter table jugadoras
--  alter column salMes money null

--10. El tamaño del campo descripción corta de la tabla COMUNIDADES debe ser de 50
--bytes, y no 200 como se había definido inicialmente.

--alter table COMUNIDADES
--  alter column desCorta nvarchar(50) null
  
--11. Realizar los cambios necesarios para garantizar que el campo nombre de la tabla
--EQUIPOS y el campo descripción corta de la tabla COMUNIDADES no permitan
--introducir valores repetidos.

--create unique index idx_descCortaEq on
--  COMUNIDADES(desCorta)

--create unique index idx_nombresEq on
--  Equipos(nombre)
  
--12. Resolver los problemas ocasionados en el proceso de creación de la tabla COMPETICIÓN:
--• El tipo de dato de la clave principal debería haberse definido como tinyint.
--• El tipo de dato de la clave principal debería haberse definido como autonumérico con
--salto de 1, iniciándose en el valor 1.

--alter table partidos Drop constraint FK_PARTIDOSCOMPETICION

--drop table competicion

--create table COMPETICION
--(
--idComp int identity(1,1) not null,
--nombre nvarchar(50) not null,
--fecIni date not null,
--fecFin date not null,

--constraint CK_FECHAS check (fecIni <= fecFin),
--constraint PK_COMPETICION primary key (idComp)

--)

--nota:
--NO DEJA ASIGNAR LA FK A LA TABLA COMPETICION PORQUE idComp no tiene el mismo tipo de dato
--PARA ARREGLAR ESTO LO QUE HABRÍA QUE HACER SERIA DROPEAR LA TABLA PARTIDOS Y LAS DEBIDAS FKs
--Y CREARLO TODO DE NUEVO CON EL NUEVO TIPO DE DATO PERO ME DA MIEDO
--SE HACERLO PERO ME DA MIEDO TOCAR LA MAS MINIMA PARTE DE UNA RELACION DE ESTA BASE DE DATOS

--alter table partidos
--add constraint FK_PARTIDOSCOMPETICION foreign key (idComp)
--	references competicion(idComp) ON UPDATE CASCADE