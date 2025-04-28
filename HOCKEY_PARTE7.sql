use PATINAZO

--2. Insertar los datos, que se indican abajo, de algunas comunidades que se incorporan al
--proyecto.

BULK INSERT COMUNIDADES
FROM 'C:\csvs\comunidades.csv
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    TABLOCK
)

--3. Crear la restricción que permita relacionar el equipo de hockey con la comunidad a la que
--pertenece. La restricción se denominará fk_ccaa y se asociará mediante el atributo ccaa.


--8. Añadir una nueva restricción en la tabla PARTIDOS para chequear que los equipos local y
--visitante no sean el mismo dentro de un registro.

alter table partidos
add constraint CK_VISLOCAL CHECK(eqLoc != eqVis)

--9. Actualizar el tipo de dato de la columna salMes de la tabla JUGADORAS. El nuevo tipo de
--dato debe ser money.

alter table jugadoras
  alter column salMes money not null

--10. El tamaño del campo descripción corta de la tabla COMUNIDADES debe ser de 50
--bytes, y no 200 como se había definido inicialmente.

alter table COMUNIDADES
  alter column desCorta nvarchar(50)
  
  
--11. Realizar los cambios necesarios para garantizar que el campo nombre de la tabla
--EQUIPOS y el campo descripción corta de la tabla COMUNIDADES no permitan
--introducir valores repetidos.

create unique index idx_descCortaEq on
  EQUIPOS(desCorta)

create unique index idx_nombresEq on
  Equipos(nombre)
  
--12. Resolver los problemas ocasionados en el proceso de creación de la tabla COMPETICIÓN:
--• El tipo de dato de la clave principal debería haberse definido como tinyint.
--• El tipo de dato de la clave principal debería haberse definido como autonumérico con
--salto de 1, iniciándose en el valor 1.

drop constraint PK_COMPETICION

alter table COMPETICION
  alter column idComp tinyint identity

alter table COMPETICION
add constraint PK_COMPETICION primary key (idComp)



