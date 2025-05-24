use PATINAZO

--1. Insertar, el registro que se indica, en la tabla COMUNIDADES
--'PAV','Pais Vasco','Euskadi',2500

--insert into comunidades(ccaa, nombre, desCorta, numFed)
--Values ('PAV','Pais Vasco','Euskadi',2500)

--2. Insertar, los registros que se detallan abajo, en la tabla COMPETICION
--Notas.-
--• Recuerda que esta tabla posee un atributo de tipo identity.
--• En esos casos no se debe incluir el valor de atributo, pero si se quiere incorporar ese valor, tenemos
--que desactivar la opción identity_insert.
--Datos a insertar:
--'Liga regular','2024-10-01', '2025-05-20',1
--'Copa del Rey','2025-01-15', '2025-04-15',2
--'Copa de la Reina','2025-01-15', '2025-04-15',3
--'Lega Catalunya','2024-12-05', '2025-05-10',4

--SET IDENTITY_INSERT COMPETICION ON
--GO

--insert into competicion(idComp, nombre, fecIni, fecFin)
--values (1,'Liga regular','2024-10-01', '2025-05-20'),
--(2,'Copa del Rey','2025-01-15', '2025-04-15'),
--(3,'Copa de la Reina','2025-01-15', '2025-04-15'),
--(4,'Lega Catalunya','2024-12-05', '2025-05-10')

--SET IDENTITY_INSERT COMPETICION OFF;
--GO

--3. Insertar en la tabla PARTIDOS los registros del fichero partidos.csv
--Realizar la carga utilizando el comando BULK INSERT


--BULK INSERT PARTIDOS
--FROM 'C:\csvs\partidos.csv'
--WITH
--(
--    FIRSTROW = 2,
--    FIELDTERMINATOR = ';',  
--    ROWTERMINATOR = '\n',  
--    TABLOCK
--)

--4. Insertar en la tabla GOLEAR los registros fichero golear.csv
--Realizar la carga utilizando el comando BULK INSERT

--BULK INSERT GOLEAR
--FROM 'C:\csvs\golear.csv'
--WITH
--(
--    FIRSTROW = 2,
--    FIELDTERMINATOR = ';',  
--    ROWTERMINATOR = '\n',  
--    TABLOCK
--)


--5. Insertar el siguiente bloque de datos en las tablas PARTIDOS y GOLEAR.
--Nota.- Este conjunto de datos los necesitaremos en los siguientes temas con el objetivo de verificar los
--procesos de entrada de datos en la base de datos.
--• Registros a insertar en la tabla PARTIDOS:
--14, '2025-02-01','19:00', 1, 1, 200, 5, 11, 1
--15, '2025-02-01','17:00', 2, 0, 275, 6, 8, 1
--16, '2025-02-01','12:00', 0, 0, 450, 10, 12, 1
--• Registros a insertar en la tabla GOLEAR:
--14, 2,'05:40'
--14, 68,'30:02'
--15, 89,'10:11'
--15, 83,'31:10'
--16, 4,'16:55'
--16, 51,'21:21'
--16, 53,'33:34'
  
--insert into Partidos(codPar, fecCel, hora, golLoc, golVis, numEsp, eqLoc, eqVis, idComp)
--values
--(14, '2025-02-01','19:00', 1, 1, 200, 5, 11, 1),
--(15, '2025-02-01','17:00', 2, 0, 275, 6, 8, 1),
--(16, '2025-02-01','12:00', 0, 0, 450, 10, 12, 1)

--insert into Golear(codPar, numFed, minuto)
--values
--(14, 2,'05:40'),
--(14, 68,'30:02'),
--(15, 89,'10:11'),
--(15, 83,'31:10'),
--(16, 4,'16:55'),
--(16, 51,'21:21'),
--(16, 53,'33:34')