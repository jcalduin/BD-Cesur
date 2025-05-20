CREATE DATABASE IF NOT EXISTS NetflixF;
USE NetflixF;

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

Ejercicio  1.-

delimiter //
create function ej1() returns varchar(100) no sql
begin
declare resultado varchar(100);
declare pelis int;
declare actores int;
declare mayor int;
declare menor int;
set pelis = (select count(*) from peliculas);
set actores = (select count(*) from reparto);
set mayor = (select year(fecha_nac) from reparto order by fecha_nac asc limit 1);
set menor = (select year(fecha_nac) from reparto order by fecha_nac desc limit 1);
set resultado = concat("En la base de datos Netflix existen ",pelis," peliculas y ",actores," actores, nacidos entre los años ",mayor," y ",menor);
return resultado;
end//

select ej1();

Ejercicio 2.-

delimiter //
create function ej2(actor1 varchar(10), actor2 varchar(10)) returns varchar(50) no sql
begin
declare resultado varchar(50);
declare pelisactor1 int;
declare pelisactor2 int;

set pelisactor1 = (select count(protagonista) from peliculas where protagonista = (select dni from reparto where nombre like actor1));
set pelisactor2 = (select count(protagonista) from peliculas where protagonista = (select dni from reparto where nombre like actor2));

 if pelisactor1 > pelisactor2 then
	set resultado= concat(actor1," ha rodado ",pelisactor1," pelicula(s) en total");
elseif pelisactor1 < pelisactor2 then
	set resultado= concat(actor2," ha rodado ",pelisactor2," pelicula(s) en total");
else
	set resultado = concat("Ambos actores han rodado ",pelisactor1," en total");
end if;
return resultado;
end//

select ej2("george","will");

Ejercicio 3.-

delimiter //
create function ej3(n int) returns varchar(15) no sql
begin
declare resultado varchar(15);
declare orden int;
set orden = n -1;
set resultado = (select nombre from peliculas order by nota desc limit orden ,1);
return resultado;
end//

select ej3(5);

Ejercicio 4.-

delimiter //
create function ej4(n1 int, n2 int) returns varchar(50) no sql
begin
declare resultado varchar(50);
declare dentro int;
declare fuera int;

set dentro = (select count(*) from peliculas where nota between n1 and n2);
set fuera = (select count(*) from peliculas where nota < n1) + (select count(*) from peliculas where nota > n2);
set resultado = concat("Dentro del rango: ",dentro,"; Fuera del rango: ",fuera);
return resultado;
end//

select ej4(3,6);