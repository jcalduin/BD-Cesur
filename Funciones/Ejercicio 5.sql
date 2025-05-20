CREATE DATABASE IF NOT EXISTS Netflix1;
USE Netflix1;

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

Ejercicio 1.-

delimiter //
create function ej1() returns varchar(100) no sql
begin
declare resultado varchar(100);
declare x int default 0;
declare pelis varchar(20);
set resultado ="";

while x < 3 do
	set pelis = (select nombre from peliculas order by duracion desc limit x,1);
	set resultado = concat(resultado,pelis," ,");
	set x = x +1;
end while;

return resultado;
end//

select ej1();

Ejercicio 2.-

delimiter //
create function ej2() returns varchar(100) no sql
begin
declare resultado varchar(100);
declare rango int;
declare x int default 0;
declare pelis varchar(20);

set rango = (select count(*) from peliculas where nota > (select nota from peliculas where nombre like "oceans eleven"));
set resultado ="";

while x < rango do
	set pelis = (select nombre from peliculas where nota > (select nota from peliculas where nombre like "oceans eleven") order by nota desc limit x,1);
	set resultado = concat(resultado,pelis," ;");
	set x = x + 1;
end while;

return resultado;
end//

select ej2();

Ejercicio 3.-

delimiter //
create function ej3(letra varchar(1)) returns varchar(50) no sql
begin
declare resultado varchar(50);
declare x int default 1;

set resultado ="";
while x <= 10 do
	set resultado = concat(resultado,(char(ord(letra)+x)),"-");
    set x = x +1;
end while;
return resultado;
end//

Ejercicio 4.-

delimiter //
create function ej4(num int) returns varchar(15) no sql
begin
declare resultado varchar(15);
declare x int default 1;
declare contador int default 0;

while x <= num do
	if mod(num,x) = 0 then
		set contador = contador +1;
	end if;
    set x = x + 1;
end while;

if contador = 2 then
	set resultado = "Es primo";
else
	set resultado = "No es primo";
end if;
return resultado;
end//

select ej4(35);