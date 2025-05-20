CREATE DATABASE IF NOT EXISTS Netflix2;
USE Netflix2;

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
create function ej1(num int) returns varchar(25) no sql
begin
declare resultado varchar(25) default "El programa ha terminado";
declare x int default 1;
declare peli varchar(30);

while x <= num do
	set peli = (select nombre from peliculas order by nota desc limit 1);
    update peliculas set nota=nota-1 where nombre like peli;
    set x = x+1;
end while;

return resultado;
end//

select ej1(3);
select * from peliculas;

Ejercicio 2.-

delimiter //
create function ej2() returns varchar(25) no sql
begin
declare resultado varchar(25) default "El programa ha terminado";
declare x int default 0;
declare nomactor varchar(25);
declare apellidoactor varchar(25);

while x < 3 do

set nomactor = (select nombre from reparto order by fecha_nac asc limit x,1);
set apellidoactor = (select apellido from reparto order by fecha_nac asc limit x,1);
update reparto set nombre = apellidoactor where nombre like nomactor;
update reparto set apellido = nomactor where apellido like apellidoactor;

set x = x+1;
end while;
return resultado;
end//

select ej2();
select * from reparto;

Ejercicio 3.-

delimiter //
create function ej3() returns varchar(100) no sql
begin
declare resultado varchar(100);
declare rango int;
declare x int default 0;
declare id1 int;
declare contadorpelis int;

set resultado ="";
set rango =(select count(*) from reparto);

while  x < rango do
	set id1 = (select dni from reparto limit x,1);
    set contadorpelis =(select count(*) from peliculas where protagonista=id1);
    
    if contadorpelis > 1 then
		set resultado=concat(resultado,(select nombre from reparto where dni = id1));
        update reparto set nombre = concat(nombre,"*") where dni = id1;
    end if;
    
    set x = x+1;
end while; 
return resultado;
end//

select ej3();
select * from reparto;

Ejercicio 4.-

delimiter //
create function ej4() returns varchar(25) no sql
begin
declare resultado varchar(25) default "El programa ha terminado";
declare x int default 0;
declare peli varchar(50);

while x < 3 do
	set peli = (select nombre from peliculas order by nota asc limit 1);
    delete from peliculas where nombre like peli;
    set x = x+1;
end while;

return resultado;
end//

select ej4();

select * from peliculas order by nota asc;