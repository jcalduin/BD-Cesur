CREATE DATABASE IF NOT EXISTS Netflix4;
USE Netflix4;

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

CREATE TABLE IF NOT EXISTS Cartelera(
	 id_sala VARCHAR(2), 
	sesiones INT, 
	plazas INT, 
	peli INT,
	primary key (id_sala)
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

INSERT INTO Cartelera (id_sala, sesiones, plazas, peli) VALUES
('S1', 4, 320 , 2),
('S2', 2, 500 , 1),
('S3', 5, 150 , 7),
('S4', 2, 100 , 7),
('S5', 3, 210 , 4);

Ejercicio 1.- Muestra el nombre de la pelicula junto con el nombre de su protagonista y toda la información de la sala 
donde se proyecte dicha película.

select p.nombre, a.id_actor, c.*
from actores as a inner join peliculas as p inner join cartelera as c on a.id_actor=p.protagonista and p.id=c.peli;

Ejercicio 2.- Muestra el identificador del actor junto al nombre de la película y el número de plazas TOTAL de las salas 
donde se proyecte dicha película.

select a.id_actor, p.nombre, sum(c.plazas)
from actores as a inner join peliculas as p inner join cartelera as c on a.id_actor=p.protagonista and p.id=c.peli
group by a.id_actor, p.nombre;

Ejercicio 3.- Muestra el nombre del actor junto a las plazas de la sala con más plazas donde se proyecte la película 
donde sea el protagonista.

select a.nombre, max(c.plazas)
from actores as a inner join peliculas as p inner join cartelera as c on a.id_actor=p.protagonista and p.id=c.peli
where a.id_actor = p.protagonista
group by a.nombre;

Ejercicio 4.- Muestra el identificador del actor junto al número de sesiones totales de dicha película, 
siempre y cuando el director de la película no se llame "Tomás" y el género del protagonista no sea "otros".

select a.id_actor, sum(c.sesiones)
from actores as a inner join peliculas as p inner join cartelera as c on a.id_actor=p.protagonista and p.id=c.peli
where p.director not like "tomás" and p.genero not like "otros"
group by a.id_actor;

Ejercicio 5.- Muestra el identificador del actor junto al número de sesiones totales de dicha película, siempre y cuando el director de 
la película no se llame "Tomás" y el género del protagonista no sea "otros", y el número de sesiones sea mayor que 2.

select a.id_actor, sum(c.sesiones)
from actores as a inner join peliculas as p inner join cartelera as c on a.id_actor=p.protagonista and p.id=c.peli
where p.director not like "tomás" and p.genero not like "otros" and c.sesiones >2
group by a.id_actor;
