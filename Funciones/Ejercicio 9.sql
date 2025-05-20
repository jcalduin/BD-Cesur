CREATE DATABASE IF NOT EXISTS Netflix9;
USE Netflix9;

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
create function ej1(color varchar(15)) returns varchar(100) no sql
begin
declare resultado varchar(100);
declare aleatorio int;
declare maquina varchar(15);

set aleatorio = rand()*(4-1)+1;

if aleatorio = 1 then
	set maquina = "rojo";
elseif aleatorio = 2 then
	set maquina = "verde";
elseif aleatorio = 3 then
	set maquina = "azul";
else
	set maquina = "amarillo";
end if;

if maquina = color then
	set resultado = concat("El usuario ha elegido: ",color," la máquina ha elegido ", maquina, " AMBOS HAN COINCIDIDO!!");
else
	set resultado = concat("El usuario ha elegido: ",color," la máquina ha elegido ", maquina, " NO HABEIS COINCIDIDO ='(");
end if;

return resultado;
end//

select ej1("rojo");

Ejericicio 2.-

delimiter //
create function ej2(num int) returns varchar(60) no sql
begin
declare resultado varchar(60);
declare x int default 0;
declare contador int default 0;
declare puntuacion float;

while x < num do
    set puntuacion =(select nota from peliculas order by nombre asc limit x,1);
    
    if puntuacion > 6 then
		set contador = contador + 1;
	end if;
    set x = x +1;
end while;

set resultado = concat("Hay ",contador, " peliculas dentro del rango con una nota mayor que 6");
return resultado;
end//

select ej2(5);
select * from peliculas order by nombre asc limit 5;

Ejercicio 3.-

delimiter //
create function ej3(n int) returns varchar(50) no sql
begin
declare resultado varchar(50);

if n = 1 then
	set resultado = concat("El resultado es: ",sqrt(power(n,4)+power(n,2)));
elseif n = 2 then
	set resultado = concat("El resultado es: ",sqrt(power(n,5)));
else
	set resultado = "No es una opcion válida";
end if;
return resultado;
end//

select ej3(1);