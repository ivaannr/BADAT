use CASAS_RURALES

--Se desea eliminar el conjunto de tablas de la base de datos CASAS RURALES.
--En el proceso de eliminación no queremos eliminar la base de datos, solamente queremos
--eliminar el conjunto de todas las tablas creadas y los objetos asociados.

--Este proceso de eliminación se realizará de 2 formas diferentes. Esto obligará a crear
--nuevamente el conjunto de tablas una vez realizado y validado el primer proceso de
--eliminación.

--Los procesos a crear son los siguientes:
--• Proceso 1.- Se ejecutarán secuencialmente todas las órdenes de borrados de las tablas,
--de forma que se utilice exclusivamente la orden DROP TABLE, tantas veces como sea
--preciso.

--No está permitido utilizar otra orden diferente a DROP TABLE

--• Proceso 2.- Se ejecutará el borrado de tablas siguiendo el siguiente orden:
	--✓ 1º eliminar tabla alojamientos
	--✓ 2º eliminar tabla habitaciones
	--✓ 3º eliminar tabla personal
	--✓ 4º eliminar tabla trabajar
	--✓ 5º eliminar tabla actividades
	--✓ 6º eliminar tabla organizar

--Está permitido y será preciso utilizar diferentes tipos de órdenes.


--//FORMA 1

--DROP TABLE Organizar

--DROP TABLE Actividades

--DROP TABLE Habitaciones 

--DROP TABLE Trabajar

--DROP TABLE Alojamientos

--DROP TABLE Personal

--//FORMA 2 

--ALTER TABLE Habitaciones
--DROP constraint FK_HABITACIONES_ALOJAMIENTOS

--ALTER TABLE Organizar
--DROP constraint FK_ORGANIZAR_ALOJAMIENTOS

--ALTER TABLE Organizar
--DROP constraint FK_ORGANIZAR_Actividades

--ALTER TABLE Trabajar
--DROP constraint FK_TRABAJAR_ALOJAMIENTOS

--ALTER TABLE Trabajar
--DROP constraint FK_TRABAJAR_PERSONAL

--ALTER TABLE Alojamientos
--DROP constraint FK_ALOJAMIENTOS_PERSONAL

----✓ 1º eliminar tabla alojamientos
--DROP TABLE Alojamientos 

----✓ 2º eliminar tabla habitaciones
--DROP TABLE Habitaciones

----✓ 3º eliminar tabla personal
--DROP TABLE Personal

----✓ 4º eliminar tabla trabajar
--DROP TABLE Trabajar

----✓ 5º eliminar tabla actividades
--DROP TABLE Actividades

----✓ 6º eliminar tabla organizar
--DROP TABLE Organizar