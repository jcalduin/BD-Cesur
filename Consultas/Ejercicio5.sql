CREATE DATABASE IF NOT EXISTS Netflix5;
USE Netflix5;

CREATE TABLE IF NOT EXISTS Peliculas(
	id int,
    	nombre VARCHAR(30),
    	duracion INT,
   	director VARCHAR(20),
    	genero ENUM ('acción', 'drama', 'comedia'),
    	nota FLOAT,
	protagonista int,
    	primary key (id)
);


CREATE TABLE IF NOT EXISTS Actores(
	id_actor INT,
    	nombre VARCHAR(30),
    	fecha_nac DATE,
    	sueldo INT,
    	genero ENUM ('femenino', 'masculino', 'otros'),
    	primary key (id_actor)
);

INSERT INTO Actores(id_actor, nombre, fecha_nac, sueldo, genero) VALUES
(101, 'Leonardo', '1980/12/01' , 3000000, 'masculino'),
(102, 'Julia', '1997/09/09' , 1000000, 'femenino'),
(103, 'Brad', '1983/02/02' , 700000, 'masculino'),
(104, 'Carlos', '1986/03/03' , 250000, 'masculino'),
(105, 'Santiago', '1970/04/04' , 4000000, 'masculino'),
(106, 'Penelope', '1976/05/05' , 23000, 'femenino'),
(107, 'Noa', '1981/06/06' , 770000, 'otros'),
(108, 'Jon', '1996/07/07' , 6000, 'otros');

INSERT INTO Peliculas (nombre, duracion, director, genero, nota, id, protagonista) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1, 103),
('Frida', 100, 'Daniel', 'drama', 7.6, 2, 107),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 3, 103),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 4, 101),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 5, 102),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 6, 102),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 7, 105),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 8, 108);

Ejercicio 1.- Muestra el nombre de los actores junto al número de películas que hayan rodado. 
Ordena los resultados alfabéticamente por el nombre del actor.

select a.nombre, count(p.protagonista)
from actores as a inner join peliculas as p on a.id_actor=p.protagonista
group by a.nombre
order by a.nombre asc;

Ejercicio 2.- Muestra los diferentes géneros de las películas junto al número de películas de dicho género. 
Ordena los resultados por el número de películas, de menor a mayor.

select genero, count(id)
from peliculas
group by genero
order by count(genero) asc;

Ejercicio 3.- Muestra los diferentes géneros de los actores junto al número de películas que hayan rodado los actores de ese género. 
Siempre y cuando el género no tenga menos de 6 letras.

select a.genero, count(p.id)
from actores as a inner join peliculas as p on a.id_actor=p.protagonista
where char_length(a.genero) >= 6
group by a.genero;

Ejercicio 4.- Muestra el identificador y  nombre de los actores junto con la nota máxima de la película que hayan rodado, 
y la duración media de las películas que hayan rodado. Ordena los resultados por la nota máxima (de mayor a menor).

select a.id_actor, a.nombre, max(p.nota), avg(p.duracion)
from actores as a inner join peliculas as p on a.id_actor=p.protagonista
group by a.id_actor
order by max(p.nota) desc;

Ejercicio 5.- Muestra el género de los actores junto a la media de salario de los actores de dicho género siempre. 
Muesta solo los datos de los 2 géneros con una media de salario mayor, ordenador de mayor a menor.

select distinct(genero), avg(sueldo)
from actores
group by genero
order by avg(sueldo) desc
limit 2;