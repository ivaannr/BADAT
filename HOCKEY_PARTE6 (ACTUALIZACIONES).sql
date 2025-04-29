use PATINAZO

1. Modificar el teléfono de contacto del único equipo de Gijón. El nuevo número de
teléfono es el 777666555.
2. En el proceso de carga de datos se produjo una asignación incorrecta de equipo. El
Sr. Moisés Aguirre Vela se asignó al equipo 14, cuando debería estar asignado al
equipo 16. Actualizar la situación del jugador.
3. La federación de hockey compensa con un incremento de 2500€ en la ficha anual al
deportista más joven, si su salario mensual es superior al 20% de su publicidad.
4. Todas las jugadoras contratadas un 4 de septiembre reciben una penalización del
20% en los ingresos por publicidad y una revisión al alza de un 15% en concepto de
salario mensual (Ver funciones DAY y MONTH).
5. Aquellos equipos que no tengan jugadores contratados deben actualizar el
presupuesto del equipo con valor 0 y el estado de desaparecido debe ser ‘s’.
6. Aquellos deportistas, que en la fecha de contratación por el equipo tenían menos de
14 años, y que sus ingresos en concepto de ficha anual superan en 5 veces los
ingresos por publicidad, deben actualizar la ficha anual al importe de 5 veces los
ingresos por publicidad exceptuando las que no tenían publicidad que no actualizarán
la ficha anual.
7. De las/os deportistas que no poseen ningún tipo de ingreso, la/el de menor edad
tiene errores en su fecha de nacimiento y categoría a la que pertenece. Actualizar la
información del deportista añadiendo 2 años (más joven) a la fecha de nacimiento, y
asignando la categoría de Junior (Ver función DATEADD).
8. Se pide aumentar, para los equipos que no han desaparecido, un 20% el presupuesto
del equipo cuando el 50% de los ingresos de las/os deportistas, por sus 3 conceptos
en los 10 meses del año, excedan el presupuesto del equipo.
9. Las jugadoras que superan en 8 años la edad media de todas las jugadoras de
hockey, y que sus ingresos por salario mensual no alcancen 1500€, deben actualizar
estos ingresos a 1500€.
10.Insertar 2 nuevos equipos de hockey.
11.Eliminar, físicamente, los equipos de hockey que pertenecen a la localidad de Grado.
12.El equipo de la ciudad de Mataro decide rescindir el contrato de la jugadora que más
ingresos obtiene a lo largo de los 10 meses. Se debe eliminar a esta jugadora de la
base de datos.
13.El hermano mayor de la saga Llanes Galito decide abandonar la competición para
continuar con sus estudios de paleontología. Esta situación obliga a ejecutar el
proceso de borrado del jugador de la base de datos.
