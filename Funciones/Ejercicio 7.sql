CREATE DATABASE IF NOT EXISTS Netflix3;
USE Netflix3;

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

Ejercicio 1.-

delimiter //
create function ej1() returns varchar(150) no sql
begin
declare resultado varchar(150);
declare numpelis int;
declare media decimal (6,2);
declare maxi float;
declare mini float;

set numpelis =(select count(*) from peliculas);
set media =(select avg(duracion) from peliculas);
set maxi =(select nota from peliculas order by nota desc limit 1);
set mini =(select nota from peliculas order by nota asc limit 1);

set resultado = concat("La tabla contiene ",numpelis," peliculas con una duración media de ",media,". Puntuación máxima: ",maxi,"- Puntuacion minima: ",mini);

return resultado;
end//

select ej1();

Ejercicio 2.-

delimiter //
create function ej2(id1 int, id2 int) returns varchar(50) no sql
begin
declare resultado varchar(50);
declare rango int;
declare peli1 float;
declare peli2 float;

set peli1 = (select nota from peliculas where id = id1);
set peli2 = (select nota from peliculas where id = id2);
set rango = (select count(*) from peliculas where id between id1 and id2);

if rango < 2 then
	set resultado = "Alguno de los IDs no existen";
else 
	if peli1 < peli2 then
		set resultado = concat("La película con menor puntuación es: ",(select nombre from peliculas where id = id1));
	elseif peli2 < peli1 then
		set resultado = concat("La película con menor puntuacion es: ",(select nombre from peliculas where id = id2));
	else
		set resultado = "Ambas películas tienen la misma puntuacion";
	end if;	
end if;

return resultado;
end//

select ej2(1,2);

Ejercicio 3.-

delimiter //
create function ej3(genre varchar(20)) returns varchar(150) no sql
begin
declare resultado varchar(150);
declare existe int;

set existe = (select count(*) from peliculas where genero like genre);

if existe < 1 then 
	set resultado = "El género no existe";
elseif existe <= 2 then
	set resultado = concat("Solo hay ",existe," pelicula(s) de ",genre," en la BD");
else
	set resultado = concat("Hay ",existe," peliculas del género ",genre," en la BD");
end if;
return resultado;
end//

select ej3("accion");

Ejercicio 4.-

delimiter //
create function ej4(num1 int, num2 int) returns varchar(150) no sql
begin
declare resultado varchar(150);
declare x int default 0;
declare registros int;
declare peli varchar(30);
declare suma int;

set registros = (select count(*) from peliculas);
set resultado ="";
set suma = num1+num2;

if suma >= registros then
	set resultado="ERROR!!";
else
	while x < num2 do
		set peli = (select nombre from peliculas order by id asc limit num1,1);
        set resultado = concat(resultado,peli,"  ");
        set x = x+1;
        set num1 = num1 + 1;
	end while;
end if;
return resultado;
end//

select ej4(3,3);