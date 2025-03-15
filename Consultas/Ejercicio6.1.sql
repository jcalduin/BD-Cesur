CREATE DATABASE IF NOT EXISTS Netflix_6;
USE Netflix_6;

CREATE TABLE IF NOT EXISTS Peliculas(
	ID int primary key,
    Nombre VARCHAR(30),
    Duracion INT,
    Director VARCHAR(20),
    Genero ENUM ('acción', 'drama', 'comedia'),
    Nota FLOAT
);

CREATE TABLE IF NOT EXISTS Reparto(
	DNI VARCHAR(9) primary key,
    Nombre VARCHAR(30),
    Apellido VARCHAR(30),
    Fecha_nac DATE
);

ALTER TABLE Peliculas ADD COLUMN Protagonista VARCHAR(9), 
ADD CONSTRAINT `FK_PROTAGONISTA` 
FOREIGN KEY (Protagonista) 
REFERENCES Reparto(DNI);

INSERT INTO Reparto (DNI, Nombre, Apellido, Fecha_nac) VALUES
("1234", "Will", "Smith", "1985-12-13"),
("1357", "Salma", "Hayek", "1976-02-11"),
("1222", "George", "Clooney", "2000-02-23"),
("1265", "Adam", "Sandler", "1980-12-13"),
("1212", "Nemo", " ", "1985-01-07");


INSERT INTO Peliculas (ID, Nombre, Duracion, Director, Genero, Nota, Protagonista) VALUES
(1, 'Bright', 120, 'Fernando', 'acción', 3.1, "1234"),
(2, 'Frida', 100, 'Daniel', 'drama', 7.6, "1357"),
(3, 'Los dos papas', 160, 'Adrián', 'comedia', 8.3, "1222"),
(4, 'Animales nocturnos', 185, 'Tomás', 'drama', 9.5, "1357"),
(5, 'Oceans Eleven', 150, 'Nuria', 'acción', 3.5, "1222"),
(6, 'Buscando a Nemo', 120, 'Jon', 'comedia', 2.1, "1212"),
(7, 'El Hoyo', 110, 'Ivan', 'acción', 9.9, "1265"),
(8, 'Diamante en bruto', 140, 'Paola', 'acción', 8.1, "1265");

Ejercicio 1.- Muestra los datos de los actores que hayan nacido antes del actor con DNI "1212" ordenador por Nombre.

select * 
from reparto
where fecha_nac < (select fecha_nac from reparto where dni like "1212")
order by nombre asc;

Ejercicio 2.- Muestra los datos de los actores que hayan nacido el mes de febrero y tengan el mismo número de caracteres (o más)
en el nombre que la actriz de apellido "Hayek". El resultado no debe incluir a la actriz con apellido "Hayek".

select *
from reparto
where month(fecha_nac) = 2 and char_length(nombre) >= (select nombre from reparto where apellido like "hayek") and apellido != "hayek";

Ejercicio 3.- Muestra los DNIs de los actores junto con la media de puntuación de las películas que hayan rodado.
No utilices la función GROUP BY.

select dni, 
	(select avg(nota)
	from peliculas 
	where dni = protagonista)
from reparto ;

Ejercicio 4.- Muestra los datos de la película con puntuación menor a la película rodada por el actor de nombre "Will".

select *
from peliculas
where nota < (select p.nota from reparto as r inner join peliculas as p on r.dni=p.protagonista where r.nombre like "will");

Ejercicio 5.- Muestra los datos de las películas con puntuación mayor que la película con mayor puntuación rodada por el actor de 
apellido "Clooney". Ordena los resultados por la puntuación de mayor a menor.

select *
from peliculas
where nota > (select max(p.nota) from peliculas as p inner join reparto as r on r.dni=p.protagonista where r.apellido = "clooney")
order by nota desc;

Ejercicio 6.- Muestra el número de peliculas que haya rodado el protagonista de Oceans Eleven en una columna llamada "Número".

select count(id) as numero
from peliculas
where protagonista = (select protagonista from peliculas where nombre="oceans eleven");

Ejercicio EXTRA.- Muestra los datos de las películas con puntuación mayor que la peor película del actor que haya nacido 
en el mes de diciembre, y menor que la mejor película que haya rodado el mismo actor. 
El actor en cuestión no puede ser el mismo que haya rodado la película "Bright".

select p.*
from peliculas as p inner join reparto as r on r.dni=p.protagonista
where p.nota >
	(select min(p.nota)
	from peliculas as p inner join reparto as r on r.dni=p.protagonista
	where month(fecha_nac)=12) 
    and p.nota <
	(select max(p.nota)
	from peliculas as p inner join reparto as r on r.dni=p.protagonista
	where month(fecha_nac)=12)
    and p.protagonista not like
    (select r.dni
	from peliculas as p inner join reparto as r on r.dni=p.protagonista
	where p.nombre like "bright" );