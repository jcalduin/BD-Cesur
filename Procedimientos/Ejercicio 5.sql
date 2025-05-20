CREATE DATABASE IF NOT EXISTS Netflix04;
USE Netflix04;

CREATE TABLE IF NOT EXISTS Peliculas(
    ID int primary key,
    Nombre VARCHAR(30),
    Duracion INT NOT NULL,
    Director VARCHAR(20),
    Genero ENUM ('acción', 'drama', 'comedia'),
    Nota decimal(2,1),
    Protagonista int
);

INSERT INTO Peliculas (ID, Nombre, Duracion, Director, Genero, Nota, Protagonista) VALUES
(1, 'Bright', 120, 'Fernando', 'acción', 3.1, "1234"),
(2, 'Frida', 100, 'Daniel', 'drama', 7.6, "1357"),
(3, 'Los dos papas', 160, 'Adrián', 'comedia', 8.3, "1222"),
(4, 'Animales nocturnos', 185, 'Tomás', 'drama', 9.5, "1357"),
(5, 'Oceans Eleven', 150, 'Nuria', 'acción', 3.5, "1222"),
(6, 'Buscando a Nemo', 120, 'Jon', 'comedia', 2.1, "1212"),
(7, 'El Hoyo', 110, 'Ivan', 'acción', 9.9, "1265"),
(8, 'Diamante en bruto', 140, 'Paola', 'acción', 8.1, "1265");

Ejercicio 5.-

delimiter //
create procedure ej5(nom varchar(40))
begin
declare id1 int;
declare tiempo int;
declare tipo varchar(40);
declare numero int;

set id1=(select id from peliculas order by id desc limit 1);
set id1=id1+1;
set tiempo =(select duracion from peliculas order by duracion desc limit 1);
set tiempo = tiempo*0.8;
set numero =rand()*(3-1)+1;
if numero=1 then
	set tipo="acción";
elseif numero=2 then
	set tipo="drama";
else
	set tipo="comedia";
end if;
alter table peliculas modify nota decimal(3,1);
INSERT INTO Peliculas (ID, Nombre, Duracion,Genero, Nota) VALUES
(id1,nom,tiempo,tipo,10);
select * from peliculas;
end//
call ej5("paqui");

Ejercicio 6.-

delimiter //
create procedure ej6(id1 int)
begin
declare nom varchar(20);
set nom =(select director from peliculas where id=id1);
set nom = reverse(nom);
update peliculas set director=nom where id=id1;
select * from peliculas;
end//
call ej6(1);

Ejercicio 7.-

delimiter //
create procedure ej7(columna varchar(50), nom varchar(50))
begin

if columna="nombre" then
	select * from peliculas where nombre not like nom order by nombre asc;
elseif columna="duracion" then
	select * from peliculas where duracion not like nom order by duracion asc;
else
	select * from peliculas where nota not like nom order by nota desc;
end if;
end//
call ej7("nota","10.0");