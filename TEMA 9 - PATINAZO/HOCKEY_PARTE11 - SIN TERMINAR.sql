use PATINAZO

--1. Generar el script con una transacción, que controle la correcta ejecución del script.
--El script consiste en poner a todos los equipos que pertenecen a la comunidad autónoma del
--Principado de Asturias.
--Para comprobar el correcto funcionamiento de todo el proceso, realizamos 2 ejecuciones:
--• Código incorrecto. Asignamos el valor de la ccaa de comunidades al atributo
--numFed de equipos.
--• Código correcto. Asignamos correctamente los valores.
go
CREATE PROCEDURE pa_AsignarValoresIncorrectos
AS
BEGIN
    
	declare @mError int
  
	begin tran t1

	update equipos
	set ccaa = 'AST'
	  where ccaa != 'AST'

	set @mError = @@ERROR

	if @mError != 0
	begin

		print 'Hubo un error'

		rollback t1
	end
	else 
	begin
		commit t1
	end
END

--2. Generar el script con una transacción, que controle la correcta ejecución del script.
--El script consiste en actualizar la comunidad autónoma de todos los equipos en función de la
--tabla que se presenta:
--Para comprobar el correcto funcionamiento del proceso se utilizará la variable @@ERROR
--tantas veces como actualizaciones debamos introducir.
--Al finalizar todas las actualizaciones se validará si es posible confirmar, definitivamente,
--todas las actualizaciones o retornar al punto de partida.

go
CREATE PROCEDURE pa_AsignarValoresCorrectos
AS
BEGIN

declare @miError int

begin tran t1 


  update equipos
  set ccaa = 'AST'
  where numReg in (1, 10, 12, 21)

  update equipos
  set ccaa = 'CAT'
  where numReg in (2, 4, 5, 7, 9, 13, 14, 15, 16)
  
  update equipos set ccaa = 'ARA' where numReg = 3
  update equipos set ccaa = 'GAL' where numReg = 6
  update equipos set ccaa = 'CAN' where numReg = 20
  update equipos set ccaa = 'CYL' where numReg = 8
  update equipos set ccaa = 'MAD' where numReg = 11
  update equipos set ccaa = 'FIC' where numReg = 99
  
  set @miError = @@ERROR


if @miError != 0
	begin
		print 'Hubo un error'
		rollback t1
	end
	else 
	begin
		commit t1
	end
END
  
--3. Generar un script de programa que controle la correcta ejecución del mismo.
--El proceso consiste en:
--• Borrar todos los goles del partido 12 por haber realizado una introducción incorrecta.
--• Insertar goles para el partido 12. Los nuevos datos de los goles son:
--(12, 31, '13:25')
--(12, 34, '22:19')
--El algoritmo debe:
--• controlar que se realizan correctamente todas las operaciones, o se volverá al
--estado antes del inicio del proceso.
--• usar transacciones y control flujo de programa con Try-Catch


go
CREATE PROCEDURE pa_BorrarYAgregarGoles
AS
BEGIN
BEGIN TRY
  
BEGIN TRAN T1

delete from golear
where codPar = 12

insert into golear (codPar, numFed, minuto)
values
(12, 31, '13:25'),
(12, 34, '22:19')
  
COMMIT T1
  
END TRY
BEGIN CATCH

ROLLBACK T1

print 'Hubo un error'
  
END CATCH

END


--4. Realizar un proceso que permita obtener el número de las/os jugadoras/es que han sido
--eliminadas/os de la base de datos.
--Recuerda que existe una jugadora ficticia que no se debe tener en cuenta para el cálculo de
--las/os jugadoras/es existentes.
--Notas.-
--a.- Utilizar las estructuras WHILE e IF
--b.- La salida será del tipo:





--5. Realizar un proceso que permita borrar la tabla medallero de la base de datos patinazo, si
--esta tabla existe, para posteriormente crearla con la estructura que se propone a
--continuación:
--Notas.-
--a.- La tabla del sistema SYSOBJECTS, mantiene información sobre todos los objetos
--que posee la base de datos.
--b.- El campo name de la tabla SYSOBJECTS, mantiene información del nombre de
--todos los objetos que posee la base de datos.
--c.- SOLO la parte del proceso de creación de la tabla se controlará con un Try-Catch.
--d.- Una vez ejecutado el proceso y creada la tabla, repetir la ejecución del script, pero
--SOLO ejecutando LA PARTE correspondiente al Try-Catch.

SELECT name, xtype
FROM sysobjects
WHERE xtype = 'U'