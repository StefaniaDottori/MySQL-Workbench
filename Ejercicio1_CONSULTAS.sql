use Ejercicio1;

-- 1- Obtener todos los datos de la tabla Deptos.
select * from departamento;
-- 2- Obtener todos los datos de la tabla Empleados.
select * from empleado;
-- 3- Obtener todos los datos de los Deptos situados en BCN
select * from departamento where localizacion = "BCN";
-- 4- Obtener el nombre del empleado con mayor salario
select Nombre from empleado order by salario desc limit 1;





