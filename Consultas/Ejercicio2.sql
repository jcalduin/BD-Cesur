CREATE DATABASE POKEMON_GO;
USE POKEMON_GO;

CREATE TABLE POKEMON (
	ID int primary key not null,
    	Nombre varchar(15),
    	Tipo enum("ROCA","TIERRA","PLANTA"),
    	Altura decimal(4,2),
    	Edad decimal (3,0),
    	Fecha_nac DATE
);

INSERT INTO POKEMON VALUES
	(1, 'JON', 'TIERRA', '1.20', '123', '2001-12-30'),
	(2,'MARCOS', 'TIERRA', '1.40', '11', '2012-10-18'),
	(3, 'CELIA', 'PLANTA', '1.00', '29', '2000-02-02'),
	(4, 'JUANMA', 'ROCA', '2.15', '32', '1999-01-01'),
	(5, 'JAVIER', 'TIERRA', '0.90', '2', '2002-07-12'),
	(6, 'CARMEN', 'PLANTA', '2.42', '14', '1997-03-27');


Ejercicio 1.- Muestra el nombre de todos los Pokemon que sean de tipo tierra.

select nombre
from pokemon
where tipo like "tierra";

Ejercicio 2.- Muestra el ID de los Pokemon de nombre Carmen o de altura mayor que 2

select id
from pokemon
where nombre like "carmen" or altura > 2;

Ejercicio 3.- Muestra el tipo de los Pokemon con edad distinta a 32 sin que se repitan datos en el resultado.

select distinct(tipo)
from pokemon
where edad <>32;

Ejercicio 4.- Muestra el nombre y tipo de los Pokemon que hayan nacido en el año 2000 o 2001 ordenador alfabéticamente por el nombre.

select nombre, tipo
from pokemon
where year(fecha_nac) in (2000,2001)
order by nombre;

Ejercicio 5.- Muestra el ID de los Pokemon que su nombre comience por la letra "C" 
y contengan la letra "A" ordenador por el nombre del Pokemon.

select id,nombre
from pokemon
where nombre like "c%a%"
order by nombre asc;

Ejercicio 6.- Muestra todos pokemon que hayan nacido en el mes de octubre o su edad esté entre 29 y 35 años (ambos incluidos).

select *
from pokemon
where month(fecha_nac) in (10) or edad between 29 and 35;

Ejercicio 7.- Muestra El ID y la altura de los 2 Pokemon de mayor altura que en su nombre no contengan la letra "E" 
ordenados por la altura de mayor a menor.

select id, altura
from pokemon
where nombre not like "%e%"
order by altura desc
limit 2;

Ejercicio 8.- Muestra todos los datos de los Pokemon que sean de tipo PLANTA o ROCA, tengan una altura superior a 1.50 y 
su edad sea distina a 14.

select *
from pokemon
where (tipo="planta" or tipo="roca") and altura > 1.50 and edad <> 14;
where tipo in ("planta","roca") and altura > 1.50 and edad <> 14;

Ejercicio 9.- Muestra los datos de los 3 Pokemon de menor edad que su nombre tenga una longitud exacta de 6 caracteres. 
Ordena el resultado de menor a mayor.

select *
from pokemon
where char_length(nombre) = 6
order by edad asc
limit 3;

Ejercicio 10.- Muestra el ID, Nombre y Edad de los Pokemon con un nombre que comience por la letra J, contenga una letra "M"
 y termine por la letra "A", o que su edad se muestre con un solo caracter. 
 Ordena los resultados alfabéticamente por el nombre del Pokemon.
 
 select id,nombre, edad
 from pokemon
 where nombre like "J%M%A" or char_length(edad)=1;
 order by nombre asc;
