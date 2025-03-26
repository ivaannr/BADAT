use EMPLEADOS
--51. Mostrar el número de pedido, su importe, el nombre de cliente y su límite de crédito.
--select ped.pedido, ped.importe, cli.cliente, cli.lim_credito from clientes cli, pedidos ped 
--where ped.cliente = cli.cliente

--select ped.pedido, ped.importe, cli.cliente, cli.lim_credito from clientes cli
--inner join pedidos ped on ped.cliente = cli.cliente

--select ped.pedido, ped.importe, cli.cliente, cli.lim_credito from clientes cli
--join pedidos ped on ped.cliente = cli.cliente

--52. Listar los nombres de los comerciales, la ciudad y la región en la que trabajan.
--select com.comercial, ofi.oficina, ofi.ciudad, ofi.region from comerciales com, oficinas ofi
--where com.oficina = ofi.oficina

--select com.comercial, ofi.oficina, ofi.ciudad, ofi.region from comerciales com
--inner join oficinas ofi on ofi.oficina = com.oficina

--select com.comercial, ofi.oficina, ofi.ciudad, ofi.region from comerciales com
--inner join oficinas ofi on ofi.oficina = com.oficina

--53. Obtener los nombres de las oficinas y los nombres y títulos de sus directores
--select ofi.oficina, ofi.director, com.cargo from comerciales com, oficinas ofi
--where ofi.oficina = com.oficina

--select ofi.oficina, ofi.director, com.cargo from comerciales com
--inner join oficinas ofi on ofi.oficina = com.oficina

--select ofi.oficina, ofi.director, com.cargo from comerciales com
--join oficinas ofi on ofi.oficina = com.oficina

--54. Obtener los nombres de las oficinas y los nombres y cargos de sus directores, mostrando
--únicamente las oficinas con un objetivo de ventas superior a 600.000.
--select ofi.oficina, com.director, com.cargo, ofi.objetivos from comerciales com, oficinas ofi
--where ofi.oficina = com.oficina and ofi.objetivos > 600000

--select ofi.oficina, com.director, com.cargo, ofi.objetivos from comerciales com
--inner join oficinas ofi on ofi.oficina = com.oficina
--where ofi.objetivos > 600000

--select ofi.oficina, com.director, com.cargo, ofi.objetivos from comerciales com
--join oficinas ofi on ofi.oficina = com.oficina
--where ofi.objetivos > 600000

--55. Listar todos los pedidos mostrando los importes y las descripciones del producto.
--select ped.pedido, ped.importe, prod.producto, prod.descripcion 
--from productos prod, pedidos ped
--where ped.producto = prod.producto

--select ped.pedido, ped.importe, prod.producto, prod.descripcion 
--from productos prod 
--inner join pedidos ped
--on ped.producto = prod.producto

--select ped.pedido, ped.importe, prod.producto, prod.descripcion 
--from productos prod 
--join pedidos ped
--on ped.producto = prod.producto

--56. Mostrar la lista de los pedidos superiores a 25.000 incluyendo el nombre del comercial
--que tomó el pedido y el nombre del cliente que lo solicitó.
--select ped.pedido, com.comercial, cli.cliente
--from pedidos ped, comerciales com, clientes cli
--where ped.comercial = com.comercial
--and ped.cliente = cli.cliente
--and ped.pedido > 25000

--select ped.pedido, com.comercial, cli.cliente
--from pedidos ped
--inner join comerciales com on com.comercial = ped.comercial
--inner join clientes cli on cli.cliente = ped.cliente
--where ped.pedido > 25000

--select ped.pedido, com.comercial, cli.cliente
--from pedidos ped
--join comerciales com on com.comercial = ped.comercial
--join clientes cli on cli.cliente = ped.cliente
--where ped.pedido > 25000


--57. Mostrar la lista de los pedidos superiores a 25.000 mostrando el nombre del cliente que
--lo solicitó y el nombre del comercial asignado a ese cliente.
--select ped.pedido, com.comercial, cli.cliente, com.nombre
--from pedidos ped, comerciales com, clientes cli 
--where ped.comercial = com.comercial
--and ped.cliente = cli.cliente
--and ped.pedido > 25000

--select ped.pedido, com.comercial, cli.cliente, com.nombre
--from pedidos ped
--inner join comerciales com on com.comercial = ped.comercial
--inner join clientes cli on cli.cliente = ped.cliente
--where ped.pedido > 25000

--select ped.pedido, com.comercial, cli.cliente,com.nombre
--from pedidos ped
--join comerciales com on com.comercial = ped.comercial
--join clientes cli on cli.cliente = ped.cliente
--where ped.pedido > 25000


--58. Listar los pedidos superiores a 25.000 mostrando el nombre del cliente que lo solicitó, el
--nombre del vendedor asignado a ese cliente y la oficina donde el comercial trabaja.
--select ped.pedido, com.comercial, cli.cliente, com.nombre, ofi.oficina
--from pedidos ped, comerciales com, clientes cli, oficinas ofi
--where ped.comercial = com.comercial
--and ped.cliente = cli.cliente
--and ofi.oficina = com.oficina
--and ped.pedido > 25000

--select ped.pedido, com.comercial, cli.cliente, com.nombre, ofi.oficina
--from pedidos ped
--inner join comerciales com on com.comercial = ped.comercial
--inner join clientes cli on cli.cliente = ped.cliente
--inner join oficinas ofi on ofi.oficina = com.oficina
--where ped.pedido > 25000

--select ped.pedido, com.comercial, cli.cliente,com.nombre, ofi.oficina
--from pedidos ped
--join comerciales com on com.comercial = ped.comercial
--join clientes cli on cli.cliente = ped.cliente
--join oficinas ofi on ofi.oficina = com.oficina
--where ped.pedido > 25000

--59. Obtener los pedidos recibidos en los días en fue contratado un nuevo comercial.
--select ped.pedido, 
--cast(com.contrato as date) as [F. De Contratación],
--com.nombre
--from comerciales com, pedidos ped
--where com.comercial = ped.comercial

--select ped.pedido, 
--cast(com.contrato as date) as [F. De Contratación],
--com.nombre
--from comerciales com 
--inner join pedidos ped
--on com.comercial = ped.comercial

--select ped.pedido, 
--cast(com.contrato as date) as [F. De Contratación],
--com.nombre
--from comerciales com 
--join pedidos ped
--on com.comercial = ped.comercial

--60. Listar todas las combinaciones de empleados y oficinas en las que la cuota del comercial
--es superior al objetivo de la oficina.
--select com.comercial, ofi.oficina, com.cuota, ofi.objetivos from comerciales com, oficinas ofi
--where com.cuota > ofi.objetivos

--61. Mostrar los comerciales y las ciudades en las que trabajan.
--select com.comercial, ofi.ciudad from comerciales com, oficinas ofi
--where ofi.oficina = com.oficina

--select com.comercial, ofi.ciudad from comerciales com
--inner join oficinas ofi on ofi.oficina = com.oficina

--select com.comercial, ofi.ciudad from comerciales com
--join oficinas ofi on ofi.oficina = com.oficina

--62. Visualizar los comerciales que sean directores, sus oficinas de representación, las
--ciudades en que trabajan y su número de identificación.
--select com.nombre, com.comercial, ofi.oficina, ofi.ciudad from comerciales com, oficinas ofi
--where ofi.oficina = com.oficina and com.director is null

--select com.nombre, com.comercial, ofi.oficina, ofi.ciudad from comerciales com 
--inner join oficinas ofi
--on ofi.oficina = com.oficina 
--and com.director is null

--select com.nombre, com.comercial, ofi.oficina, ofi.ciudad from comerciales com 
--join oficinas ofi
--on ofi.oficina = com.oficina 
--and com.director is null

--63. Visualizar los comerciales que sean directores, sus oficinas de representación, las
--ciudades en que trabajan y su número de empleado. Los que no sean directores también
--deben salir (utilizar una operación de combinación externa por la izquierda o Left Join).
--select com.nombre, com.comercial, ofi.oficina, ofi.ciudad from comerciales com 
--left join oficinas ofi
--on ofi.oficina = com.oficina 
--and com.director is null

--64. Mostrar el nombre y cargo de cada comercial, el número de su oficina, sus ventas
--objetivo y su ciudad.
--select com.nombre, com.cargo, ofi.oficina, ofi.objetivos, ofi.ciudad 
--from comerciales com, oficinas ofi
--where com.oficina = ofi.oficina

--65. Hacer una consulta para mostrar el nombre de la empresa cliente y las características de
--los pedidos para el número de cliente 2103.
--select cli.cliente, cli.empresa, ped.* from clientes cli, pedidos ped
--where cli.cliente = ped.cliente  and cli.cliente = 2103

--select cli.cliente, cli.empresa, ped.* from clientes cli
--inner join pedidos ped
--on cli.cliente = ped.cliente where cli.cliente = 2103

--select cli.cliente, cli.empresa, ped.* from clientes cli
--join pedidos ped
--on cli.cliente = ped.cliente where cli.cliente = 2103


--66. Mostrar el nombre y las ventas de los comerciales, así como la ciudad de cada oficina de
--los empleados, con sus objetivos de ventas.
--select com.nombre, com.ventas, ofi.ciudad, ofi.objetivos 
--from oficinas ofi, comerciales com
--where ofi.oficina = com.oficina

--select com.nombre, com.ventas, ofi.ciudad, ofi.objetivos 
--from oficinas ofi 
--inner join comerciales com
--on ofi.oficina = com.oficina

--select com.nombre, com.ventas, ofi.ciudad, ofi.objetivos 
--from oficinas ofi 
--join comerciales com
--on ofi.oficina = com.oficina

--67. Mostrar toda la información de los comerciales y de las oficinas en las que trabajan.
--select * from comerciales com, oficinas ofi
--where com.oficina = ofi.oficina

--68. Mostrar toda la información de los comerciales y sólo la ciudad y la región de las oficinas
--en las que trabajan.
--select com.*, ofi.ciudad, ofi.region 
--from comerciales com, oficinas ofi
--where ofi.oficina = com.oficina

--select com.*, ofi.ciudad, ofi.region
--from comerciales com
--inner join oficinas ofi
--on ofi.oficina = com.oficina

--69. Listar los nombres de los comerciales y de sus directores.
--select nombre, director from comerciales

--70. Listar los nombres de los comerciales con una cuota superior a la de sus directores.
--select nombre, director, cuota from comerciales
--where director is not null and cuota > any (select cuota from comerciales where director is null) 

--71. Obtener la cuota promedio, las ventas promedio y el rendimiento de ventas (ventascuota) promedio de los comerciales.
--select cuota, ventas, avg(cuota) [Promedio Cuota], 
--avg(ventas) [Promedio Ventas], 
--Concat( ((ventas/cuota) * 100), '%')[Ventas/Cuota] 
--from comerciales
--group by cuota, ventas

--72. Calcular el mejor rendimiento de ventas (ventas-cuota) de todos los comerciales.
--select top 1 concat( (ventas/cuota * 100), '%' )[Mejor Rendimiento] from comerciales 

--73. Calcular las cuotas y las ventas totales para todos los comerciales, así como su cuota
--máxima y mínima.
--select sum(cuota) CUOTAS_TOTAL, 
--sum(ventas) VENTAS_TOTAL, COMERCIAL, 
--max(cuota) CUOTA_MAX, 
--min(cuota) CUOTA_MIN
--FROM COMERCIALES
--group by ventas, cuota, comercial

--74. Obtener los importes total y medio de los pedidos aceptados por Bill Adams.
--select sum(ped.importe) as [IMPORTE TOTAL],
--avg(ped.importe) as [IMPORTE MEDIO],
--com.nombre
--from pedidos ped, comerciales com
--where com.nombre = 'Bill Adams'
--group by nombre

--75. Calcular el precio promedio de los productos del fabricante ACI.
--select avg(importe) [IMPORTE AVG], id_fabrica from pedidos
--where id_fabrica = 'ACI'
--group by id_fabrica

--76. Mostrar el número de comerciales que superan su cuota.
--select comercial, ventas, cuota 
--from comerciales
--where ventas > cuota

--77. Mostrar el número de pedidos con importe superior a 25.000.
--select pedido, importe from pedidos
--where importe > 25000

--78. ¿Cuántos cargos diferentes tienen los comerciales?
--select distinct cargo from comerciales

--79. ¿Cuántos comerciales superan su cuota de ventas?
--select distinct comercial, ventas, cuota from comerciales
--where ventas > cuota

--80. Mostrar el importe medio de los pedidos de cada comercial.
--select avg(ped.importe) [IMPORTE AVG], 
--com.comercial, com.nombre 
--from comerciales com, pedidos ped
--where com.comercial = ped.comercial
--group by com.comercial, com.nombre

--select avg(ped.importe) [IMPORTE AVG], 
--com.comercial, com.nombre 
--from comerciales com
--inner join pedidos ped on com.comercial = ped.comercial
--group by com.comercial, com.nombre

--select avg(ped.importe) [IMPORTE AVG], 
--com.comercial, com.nombre 
--from comerciales com
--join pedidos ped on com.comercial = ped.comercial
--group by com.comercial, com.nombre

--81. Obtener el número de comerciales asignados a cada oficina.
--select count(comercial) comerciales, oficina from comerciales
--group by oficina


--82. Obtener el total de importes de los pedidos, agrupados por cada cliente y por cada
--comercial.
--select sum(ped.importe) [IMPORTE TOTAL], 
--cli.cliente, com.comercial
--from pedidos ped
--left join clientes cli on cli.cliente = ped.cliente
--left join comerciales com on com.comercial = ped.comercial
--group by cli.cliente, com.comercial

--83. Listar el importe total de los pedidos de cada comercial, mostrando su número de
--identificación y nombre.
--select sum(ped.importe) as 'Importe total', com.comercial, com.nombre from comerciales com
--inner join pedidos ped on ped.comercial = com.comercial
--group by com.comercial, com.nombre

--84. Calcular el importe medio de los pedidos de cada comercial cuyos pedidos sumen más de
--30.000.
--select avg(ped.importe) IMPORTE_AVG, 
--com.comercial
--from comerciales com
--inner join pedidos ped on ped.comercial = com.comercial
--where 30000 < (select sum(importe) from pedidos) 
--group by com.comercial

--85. Para cada oficina con dos o más personas, calcular la cuota total y las ventas totales
--para todos los empleados que trabajan en la oficina.
--select sum(com.cuota) [Cuota Total], 
--sum(ofi.ventas) [Ventas Totales],
--com.comercial
--from comerciales com
--inner join oficinas ofi on ofi.oficina = com.oficina
--where 
--(select count(*) 
--from comerciales com_sub 
--where com_sub.oficina = com.oficina) >= 2
--group by com.comercial

--86. Visualizar las oficinas cuyo objetivo de ventas excede a la suma de las cuotas de todos
--los comerciales.
--select ofi.oficina, ofi.objetivos, (select sum(cuota) from comerciales) [Suma Cuotas] from oficinas ofi
--inner join comerciales com on com.oficina = ofi.oficina
--where 
--(
--select sum(cuota) from comerciales
--)
--< ofi.objetivos 
--group by ofi.oficina, ofi.objetivos

--87. Visualizar las oficinas cuyo objetivo de ventas excede a la suma de las cuotas de todos
--los comerciales de la oficina.
--select ofi.oficina, ofi.objetivos, 
--	(select sum(cuota) from comerciales) [Suma Cuotas] 
--from oficinas ofi
--	inner join comerciales com on  ofi.oficina = com.oficina 
--group by ofi.oficina, ofi.objetivos
--	having (
--select sum(com.cuota) from comerciales com, oficinas ofi
--where com.oficina = ofi.oficina
--	) < ofi.objetivos 

--88. Listar los nombres de los comerciales cuyas cuotas son iguales o superiores al objetivo
--de la oficina de ventas de Atlanta.
--select com.nombre, com.cuota, ofi.objetivos, ofi.ciudad 
--from oficinas ofi
--inner join comerciales com on ofi.oficina = com.oficina
--where ofi.ciudad = any (
--select ciudad from oficinas
--where ciudad like 'ATLANTA' 
--)
--and ofi.objetivos <= com.cuota

--89. Listar los nombres de los comerciales que trabajan en oficinas en las que las ventas de la
--oficina superan el objetivo de la oficina.
--select com.nombre, ofi.ventas, ofi.objetivos 
--from oficinas ofi
--inner join comerciales com
--on ofi.oficina = com.oficina
--where ofi.ventas > ofi.objetivos


--90. Obtener la descripción y las existencias de los productos del fabricante ACI para los que
--las existencias superan a las del producto 41004.
--select descripcion, existencias, id_fabrica
--from productos
--where
--	id_fabrica like 'ACI'
--	and
--	existencias > any 
--	(
--		select existencias from productos
--		where producto like '41004'
--	)

--91. Buscar los nombres de los productos con un precio superior al precio actual mínimo.
--select producto
--from productos
--	where(
--	select min(precio) from productos
--	) < precio

--92. Listar los productos con un importe de pedido superior al importe de pedido actual
--mínimo del cliente 2111.
--select prod.producto 
--from productos prod
--inner join
--	pedidos ped
--	on ped.producto = prod.producto
--	where ped.importe >
--	(
--	select min(importe) from pedidos
--	where cliente like '2111'
--	)


--93. Obtener los productos para los que existe al menos un pedido en la tabla pedidos que se
--refiere al producto en cuestión y que tiene un importe de al menos 25.000.
--select prod.producto from productos prod
--	inner join pedidos ped
--	on ped.producto = prod.producto
--	where (select count(producto) from pedidos) > 1
--	and ped.importe >= 25000

--94. Listar las oficinas en donde haya un comercial cuya cuota represente más del 55% del
--objetivo de la oficina.
--select ofi.oficina from oficinas ofi
--	inner join comerciales com
--	on com.oficina = ofi.oficina
--	where cuota > (0.55 * objetivos)

--95. Mostar los comerciales que han aceptado al menos un pedido que supone más del 10%
--de su cuota.
--select com.comercial, ped.pedido from comerciales com
--	inner join pedidos ped
--	on ped.comercial = com.comercial
--	where ped.importe > (cuota * 0.10)


--96. Listar las oficinas y sus objetivos para las que todos los comerciales tienen ventas que
--superan al 50% del objetivo de la oficina.
--select ofi.oficina, ofi.objetivos from oficinas ofi
--	inner join comerciales com
--	on com.oficina = ofi.oficina
--	where com.ventas > ofi.objetivos * 0.5

--97. Muestra el importe de los productos del fabricante ACI, el importe promedio de todos los
--productos y la diferencia entre el importe del producto y el precio promedio de todos los
--productos.
--select ped.importe, 
--avg(ped.importe) [Importe Medio],
--(ped.importe - avg(importe)) [Diff]
--from pedidos ped
--	inner join productos prod
--	on ped.producto = prod.producto
--	where prod.id_fabrica like 'ACI'
--	group by ped.importe


--98. Obtener todas las oficinas cuyos objetivos exceden a la suma de las cuotas de los
--comerciales que trabajan en ellas.
--select ofi.oficina, sum(com.cuota) [Suma Cuota]
--from oficinas ofi
--	 inner join comerciales com
--	 on com.oficina = ofi.oficina
--	 where ofi.objetivos > com.cuota
--	 group by ofi.oficina

--99. Mostrar los comerciales cuyo importe de pedido medio para productos fabricados por ACI
--es superior al tamaño del pedido medio global.
--select com.comercial from comerciales com
--	inner join pedidos ped
--	on ped.comercial = com.comercial
--	where (
--	select avg(importe) from pedidos ped
--	inner join productos prod
--	on prod.producto = ped.producto
--	where ped.id_fabrica like 'ACI'
--	)
--	>
--	( 
--	select avg(importe) from pedidos ped
--	inner join productos prod
--	on prod.producto = ped.producto
--	)
	
--100.Mostrar las ciudades donde se encuentran las oficinas con su nombre en mayúsculas, en
--minúsculas y el número de caracteres. (ver funciones upper, lower, len)
select upper(ciudad) [Upper], lower(ciudad) [Lower], len(ciudad) [Len] from oficinas