use EMPRESAS
--61. A partir de la tabla de empleados, visualizar el número de departamento y el número
--de empleados que hay en ese departamento.
--SELECT count(CEMPL) Empleados, dept FROM empleados
--group by dept

--62. Repetir la consulta anterior, pero visualizando sólo aquéllos departamentos con más
--de cuatro empleados.
--SELECT count(CEMPL) Empleados, dept FROM empleados
--group by dept
--having count(cempl) > 4

--63. Repetir la consulta anterior ordenando la salida descendentemente por número de
--empleados.
--SELECT count(CEMPL) Empleados, dept FROM empleados
--group by dept
--having count(cempl) > 4
--order by CEMPL desc

--64. Obtener la suma de los salarios, el salario máximo y el mínimo de cada departamento.
--Etiquetar las columnas convenientemente.
--select sum(salario) [Sum Salarios], 
--max(salario) [Salario Máximo],
--min(salario) [Salario Mínimo],
--dept
--from empleados
--group by dept

--65. Visualizar el número de empleados por departamento y cargo
--select count(cempl) [Empleados], dept, cargo
--from empleados
--group by dept, cargo

--66. A partir de la tabla empleados, visualizar el número de “COMERCIALES” del
--departamento 30 (Comercial).
--select cargo, count(cempl) [Nº Empleados] from empleados
--where dept = 30 and cargo = 'COMERCIAL'
--group by cargo

--67. A partir de la tabla empleados, visualizar el número de “COMERCIALES” del
--departamento COMERCIAL sin utilizar el número de departamento para realizar la
--consulta.
--select count(cempl) [Nº Empleados], dept from empleados
--where dept = any 
--(
--select dept from empleados
--where cargo like 'COMERCIAL'
--)
--group by dept

--68. Partiendo de la solución del ejercicio anterior y sin modificarla. ¿Qué ocurre si
--añadimos a la sentencia SELECT el nombre de departamento? Resuelve correctamente
--el ejercicio.
--select count(em.cempl) [Nº Empleados], dep.dept, dep.nombre from empleados em, DEPARTAMENTOS dep
--where dep.dept = em.dept 
--and dep.dept = any 
--(
--select dept from empleados
--where cargo like 'COMERCIAL'
--)
--group by dep.dept, dep.nombre

--69. Visualizar el nombre y el sueldo del jefe de JORGE
--select nombre, salario from empleados
--	where
--		cempl =  
--		(
--		select jefe from empleados
--		where nombre like 'JORGE'
--		)
		
--70. Visualizar los nombres, salarios y departamento de los componentes del departamento
--del jefe del empleado JORGE.
--select nombre, salario, dept from empleados
--	where
--		dept = 
--		(
--		select dept from empleados
--	where
--		cempl =  
--		(
--		select jefe from empleados
--		where nombre like 'JORGE'
--		)
--		)

--71. Visualizar los nombres, salarios y nombre del departamento de los componentes del
--departamento del jefe del empleado JORGE.
--select em.nombre, em.salario, dep.nombre from empleados em
--	inner join DEPARTAMENTOS dep
--	on dep.dept = em.dept
--	where
--		dep.dept = 
--		(
--		select dept from empleados
--	where
--		cempl =  
--		(
--		select jefe from empleados
--		where nombre like 'JORGE'
--		)
--		)

--72. Partiendo de la tabla de empleados, visualizar por cada cargo de los empleados del
--departamento COMERCIAL, la suma de salarios. Hacerlo sin usar el número de
--departamento.
--select cargo, dept, sum(salario) [Total Salarios] from empleados
--	where dept = any (select dept from empleados where cargo like 'comercial') 
--	group by cargo, dept

--73. A partir de la tabla de empleados, visualizar el número de empleados de cada
--departamento cuyo oficio sea “EMPLEADO”
--select count(cempl) [Nº Empleados], cargo from empleados
--	where cargo like 'EMPLEADO' group by cargo


--74. Mostrar los departamentos que tienen más de una persona trabajando en la misma
--profesión.
--select distinct count(cargo) [Cargos], dept, cargo from empleados --son 3 en vez de 4 pero no se porque me lo cuenta mal
--	group by dept, cargo
--	having count(cargo) > 2

--75. Buscar los departamentos que tienen menos de cuatro trabajadores.
--select dept, count(*) [Trabajadores] from empleados
--	group by dept
--	having count(*) < 4

--76. Calcular el salario medio de los empleados de los departamentos 20 y 30
--select avg(salario) [Media Salario], dept from empleados
--	where dept in (20,30)
--	group by dept

--77. Obtener el mínimo salario del departamento 10
--select min(salario) [Salario Mínimo] from empleados
--	where dept = 10

--78. Obtener el nombre del empleado que tenga el menor salario.
--select top 1 min(salario) [Salario Más Bajo], nombre from empleados
--	group by nombre

--79. Visualizar los distintos trabajos que realizan aquellos empleados que tienen una ‘R’ en
--su nombre.
--select cargo, nombre from empleados
--	where nombre like '%R%'

--80. Obtener el nombre y salario del empleado con nombre máximo (último por orden
--alfabético) de la tabla de empleados.
--select TOP 1 nombre, salario from empleados
--	order by 1 desc

--81. Presentar los nombres y cargo de los empleados que tienen el mismo trabajo que
--MARTIN.
--select nombre, cargo from empleados
--	where cargo like (select cargo from empleados where nombre like 'MARTIN')

--82. Mostrar los empleados (nombre, cargo y fecha de alta), que desempeñen el mismo
--cargo que Jorge, o que tengan un salario mayor o igual al de Luis.
--select nombre, cargo, cast(falta as date) [Fecha De Alta] from empleados
--	where cargo = (select cargo from empleados where nombre like 'JORGE')
--	or salario >= (select salario from empleados where nombre like 'LUIS') 

--83. Consultar los datos de los empleados que trabajen en Oviedo o Avilés.
--select em.* from empleados em
--	inner join DEPARTAMENTOS dep
--	on dep.dept = em.dept
--	where dep.ciudad in ('OVIEDO',  'AVILES')
	

--84. Consultar los nombres y cargos de todos los empleados del departamento 20 cuyo
--trabajo sea idéntico al de cualquiera de los empleados del departamento COMERCIAL.
--select em.nombre, em.cargo from empleados em, DEPARTAMENTOS dep
--	where dep.dept = em.dept
--	and em.dept like 20


--85. Obtener el nombre de los empleados con el mismo cargo y salario que MARTIN.
--Utilizar INTERSECT.
--select nombre from empleados
--where cargo = (select cargo from empleados where nombre like 'martin')
--intersect
--select nombre from empleados
--where salario = (select salario from empleados where nombre like 'martin')