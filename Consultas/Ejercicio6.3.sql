create database empresa;
use empresa;

CREATE TABLE Departamento ( 
cod varchar (4) PRIMARY KEY, 
nombre varchar (20) NOT NULL, 
ciudad varchar (15)
);

CREATE TABLE Empleado (
id VARCHAR( 12 ) NOT NULL PRIMARY KEY,
nombre VARCHAR( 30 ) NOT NULL ,
genero CHAR( 1 ) NOT NULL CHECK (genero IN ('F', 'M') ), 
fecha_nac DATE NOT NULL ,
fecha_incorporacion DATE NOT NULL,
salario INT NOT NULL,
comision FLOAT NOT NULL, 
cargo VARCHAR( 15 ) NOT NULL, 
jefeID VARCHAR( 12 ),
Departamento VARCHAR( 4 ) NOT NULL
);

INSERT INTO Departamento (cod, nombre, ciudad) VALUES
('1000', 'GERENCIA', 'CALI'),
('1500', 'PRODUCCIÓN', 'CALI'),
('2000', 'VENTAS', 'CALI'),
('3000', 'INVESTIGACIÓN', 'CALI'),
('3500', 'MERCADEO', 'CALI'),
('2100', 'VENTAS', 'POPAYAN'),
('2200', 'VENTAS', 'BUGA'),
('2300', 'VENTAS', 'CARTAGO'),
('4000', 'MANTENIMIENTO', 'CALI'),
('4100', 'MANTENIMIENTO', 'POPAYAN'),
('4200', 'MANTENIMIENTO', 'BUGA'),
('4300', 'MANTENIMIENTO', 'CARTAGO');

INSERT INTO Empleado (id, nombre, genero, fecha_nac, fecha_incorporacion, salario, comision, cargo, jefeID, departamento) VALUES
('31.840.269', 'María Rojas', 'F', '1959-01-15', '1990-05-16', 6250000, 1500000, 'Gerente', NULL, '1000'),
('16.211.383', 'Luis Pérez', 'M', '1956-02-25', '2000-01-01', 5050000, 0, 'Director', '31.840.269', '1500'),
('31.178.144', 'Rosa Angulo', 'F', '1957-03-15', '1998-08-16', 3250000, 3500000, 'Jefe Ventas', '31.840.269', '2000'),
('16.759.060', 'Darío Casas', 'M', '1960-04-05', '1992-11-01', 4500000, 500000, 'Investigador', '31.840.269', '3000'),
('22.222.222', 'Carla López', 'F', '1975-05-11', '2005-07-16', 4500000, 500000, 'Jefe Mercadeo', '31.840.269', '3500'),
('22.222.333', 'Carlos Rozo', 'M', '1975-05-11', '2001-09-16', 750000, 500000, 'Vigilante', '31.840.269', '3500'),
('1.751.219', 'Melissa Roa', 'F', '1960-06-19', '2001-03-16', 2250000, 2500000, 'Vendedor', '31.178.144', '2100'),
('768.782', 'Joaquín Rosas', 'M', '1947-07-07', '1990-05-16', 2250000, 2500000, 'Vendedor', '31.178.144', '2200'),
('737.689', 'Mario Llano', 'M', '1945-08-30', '1990-05-16', 2250000, 2500000, 'Vendedor', '31.178.144', '2300'), 
('333.333.333', 'Elisa Rojas', 'F', '1979-09-28', '2004-06-01', 3000000, 1000000, 'Jefe Mecánicos', '31.840.269', '4000'), 
('888.888', 'Iván Duarte', 'M', '1955-08-12', '1998-05-16', 1050000, 200000, 'Mecánico', '333.333.333', '4100'),
('11.111.111', 'Irene Díaz', 'F', '1979-09-28', '2004-06-01', 1050000, 200000, 'Mecánico', '333.333.333', '4200'),
('444.444', 'Abel Gómez', 'M', '1939-12-24', '2000-10-01', 1050000, 200000, 'Mecánico', '333.333.333', '4300'),
('1.130.222', 'José Giraldo', 'M', '1985-01-20', '2000-11-01', 1200000, 400000, 'Asesor', '22.222.222', '3500'),
('19.709.802', 'William Daza', 'M', '1982-10-09', '1999-12-16', 2250000, 1000000,'Investigador', '16.759.060', '3000'),
('31.174.099', 'Diana Solarte', 'F', '1957-11-19', '1990-05-16', 1250000, 500000, 'Secretaria', '31.840.269', '1000'),
('1.130.777', 'Marcos Cortez', 'M', '1986-06-23', '2000-04-16', 2550000, 500000, 'Mecánico', '333.333.333', '4000'),
('1.130.782', 'Antonio Gil', 'M', '1980-01-23', '2010-04-16', 850000, 1500000, 'Técnico', '16.211.383', '1500'), 
('333.333.334', 'Marisol Pulido', 'F', '1979-10-01', '1990-05-16', 3250000, 1000000, 'Investigador', '16.759.060', '3000'), 
('333.333.335', 'Ana Moreno', 'F', '1992-01-05', '2004-06-01', 1200000, 400000, 'Secretaria', '16.759.060', '3000'),
('1.130.333', 'Pedro Blanco', 'M', '1987-10-28', '2000-10-01', 800000, 3000000, 'Vendedor', '31.178.144', '2000'),
('1.130.444', 'Jesús Alfonso', 'M', '1988-03-14', '2000-10-01', 800000, 3500000, 'Vendedor', '31.178.144', '2000'),
('333.333.336', 'Carolina Ríos', 'F', '1992-02-15', '2000-10-01', 1250000, 500000, 'Secretaria', '16.211.383', '1500'),
('333.333.337', 'Edith Muñoz', 'F', '1992-03-31', '2000-10-01', 800000, 3600000, 'Vendedor', '31.178.144', '2100'),
('1.130.555', 'Julián Mora', 'M', '1989-07-03', '2000-10-01', 800000, 3100000, 'Vendedor', '31.178.144', '2200'),
('1.130.666', 'Manuel Millán', 'M', '1990-12-08', '2004-06-01', 800000, 3700000, 'Vendedor', '31.178.144', '2300');

Ejercicio 1.- Muestra los datos de los empleados nacidos antes del mes de junio, y con un salario mayor que el máximo salario del empleado con cargo "Jefe Ventas". 
Ordena los resultados por el salario de los empleados (de mayor a menor).

select *
from empleado
where month(fecha_nac)<6 and salario > (select salario 
									    from empleado
									    where cargo like "jefe ventas")
order by salario desc;                                          
                                          
Ejercicio 2.- Muestra el nombre e identificador de los empleados con el mismo género que el primer empleado en incorporarse a la empresa. 
Ordena los resultados en orden alfabético por el nombre del empleado.

select nombre, id
from empleado
where genero = (select genero
				from empleado
                order by fecha_incorporacion asc
                limit 1)
order by nombre asc;

Ejercicio 3.- Muestra los datos de los 3 empleados con mayor comisión de la tabla, siempre y cuando el mes de nacimiento sea el mismo que el del empleado 
con cargo "Asesor". Ordena los resultados por la comisión de los empleados (de mayor a menor).

select *
from empleado
where month(fecha_nac) = (select month(fecha_nac)
						  from empleado
                          where cargo like "asesor")
order by comision desc
limit 3;

Ejercicio 4.- Muestra los nombres y fecha de incorporación de los empleados con género "F", que se hayan incorporado antes que el empleado "José Giraldo", 
después del empleado con cargo "Gerente".

select nombre, fecha_incorporacion
from empleado
where genero like "f" and fecha_incorporacion < (select fecha_incorporacion 
												 from empleado
                                                 where nombre like "josé giraldo") and fecha_incorporacion > (select fecha_incorporacion
																											  from empleado
                                                                                                              where cargo like "gerente");

Ejercicio 5.- Muestra los datos de los empleados con cargo de jefe (Jefe Mercadeo, Jefe Mecánicos, Jefe Ventas) y 
que el departamento esté en la ciudad de Cali y el nombre del departamento sea "MANTENIMIENTO".

select *
from empleado 
where cargo like "jefe%" and departamento = (select cod
											 from departamento
                                             where ciudad like "cali" and nombre like "mantenimiento"); 

Ejercicio 6.- Muestra el nombre del departamento donde trabaje el empleado con menor salario de la tabla empleados. 
No utilices el comando INNER JOIN para realizar la consulta.

select nombre
from departamento
where cod = (select departamento
			 from empleado
             order by salario asc
             limit 1);

Ejercicio 7.- Muestra el nombre de los empleados que su diferencia entre salario y comisión (salario - comisión) sea mayor que la diferencia de salario 
y comisión del empleado nacido en el año 1982. Muestra en el resultado de la consulta el nombre del empleado junto con la diferencia entre su salario 
y comisión en una columna de nombre DIFERENCIA. Ordena los resultados por dicha diferencia.

select nombre, (salario-comision) as diferencia
from empleado 
where salario - comision > (select salario - comision
							from empleado
							where year(fecha_nac) = 1982)
order by diferencia desc;

Ejercicio 8.- Muestra el nombre de los empleados con genero "M" y con un nombre con el mismo número de caracteres que el nombre del empleado con cargo 
"Vendedor" con mayor salario de la tabla empleado.

select nombre
from empleado
where genero like "m" and char_length(nombre) = (select char_length(nombre)
												 from empleado
                                                 where cargo like "vendedor"
                                                 order by salario desc
                                                 limit 1);