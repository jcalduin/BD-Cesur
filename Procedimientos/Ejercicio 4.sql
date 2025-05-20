CREATE DATABASE IF NOT EXISTS Netflix05;
USE Netflix05;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
    nombre_peli VARCHAR(30),
    duracion INT,
    director_peli VARCHAR(20),
    género_peli ENUM ('acción', 'drama', 'comedia'),
    nota_peli FLOAT,
    primary key (id_peli)
);

CREATE TABLE IF NOT EXISTS Actores(
	id_actor INT,
    nombre VARCHAR(30),
    fecha_nac DATE,
    sueldo INT,
    sexo ENUM ('femenino', 'masculino', 'otros'),
    primary key (id_actor)
);

INSERT INTO Actores(id_actor, nombre, fecha_nac, sueldo, sexo) VALUES
(101, 'Leonarno', '1980/12/01' , 3000000, 'masculino'),
(102, 'Julia', '1997/09/09' , 1000000, 'femenino'),
(103, 'Brad', '1983/02/02' , 700000, 'masculino'),
(104, 'Carlos', '1986/03/03' , 250000, 'masculino'),
(105, 'Santiago', '1970/04/04' , 4000000, 'masculino'),
(106, 'Penelope', '1976/05/05' , 23000, 'femenino'),
(107, 'Noa', '1981/06/06' , 770000, 'otros'),
(108, 'Jon', '1996/07/07' , 6000, 'otros');

INSERT INTO Peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1),
('Frida', 100, 'Daniel', 'drama', 7.6, 2),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 3),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 4),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 5),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 6),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 7),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 8);

Ejercicio 1.-

delimiter //
create function sumapunto(num float) returns float no sql
begin
declare resultado float;
set resultado = num+1;
return resultado;
end//
delimiter //
create procedure ej1(nom varchar(50))
begin
declare puntuacion float;
set puntuacion =(select nota_peli from peliculas where nombre_peli=nom);
set puntuacion =(select sumapunto(puntuacion));
update peliculas set nota_peli=puntuacion where nombre_peli=nom;
select * from peliculas;
end//
call ej1("bright");

Ejercicio 2.-

delimiter //
create function duplicar(num float) returns float no sql
begin
declare resultado float;
set resultado = num*2;
return resultado;
end//
delimiter //
create function dividir(num float) returns float no sql
begin
declare resultado float;
set resultado = num/2;
return resultado;
end//
delimiter //
create procedure ej2()
begin
declare mayor float;
declare menor float;
declare idmayor int;
declare idmenor int;

set mayor=(select sueldo from actores order by sueldo desc limit 1);
set mayor=(select dividir(mayor));
set idmayor=(select id_actor from actores order by sueldo desc limit 1);
set menor=(select sueldo from actores order by sueldo asc limit 1);
set menor=(select duplicar(menor));
set idmenor=(select id_actor from actores order by sueldo asc limit 1);
update actores set sueldo=mayor where id_actor=idmayor;
update actores set sueldo=menor where id_actor=idmenor;
select * from actores order by sueldo desc;
end//
call ej2();

Ejercicio 3.-

delimiter //
create function restartiempo(num int) returns int no sql
begin
declare resultado int;
set resultado =(select duracion from peliculas where id_peli=num);
set resultado = resultado-5;
return resultado;
end//
delimiter //
create procedure modificarduracion()
begin
declare x int default 0;
declare numpelis int;
declare tiempo int;
declare id1 int;

set numpelis =(select count(*) from peliculas);

while x < numpelis do
	set tiempo =(select duracion from peliculas order by duracion desc limit x,1);
    set id1 =(select id_peli from peliculas order by duracion desc limit x,1);
    if tiempo>145 then
		set tiempo=(select restartiempo(id1));
        update peliculas set duracion=tiempo where id_peli=id1;
    end if;
	set x = x+1;
end while;
select * from peliculas order by duracion desc;
end//

Ejercicio 4.-

delimiter //
create function prefijo_sr(nom varchar(50)) returns varchar(50) no sql
begin
declare resultado varchar(50);
set resultado = concat("Sr ",nom);
return resultado;
end//
delimiter //
create function prefijo_sra(nom varchar(50)) returns varchar(50) no sql
begin
declare resultado varchar(50);
set resultado = concat("Sra ",nom);
return resultado;
end//
delimiter //
create procedure modificarnombre()
begin
declare x int default 0;
declare numactores int;
declare nom varchar(50);
declare sex varchar(50);
declare id1 int;

set numactores=(select count(*) from actores);
while x < numactores do
	set sex =(select sexo from actores order by id_actor limit x,1);
    if sex="masculino" then
		set nom=(select nombre from actores order by id_actor limit x,1);
        set id1=(select id_actor from actores order by id_actor limit x,1);
        set nom=(select prefijo_sr(nom));
        update actores set nombre=nom where id_actor=id1;
	elseif sex="femenino" then
		set nom=(select nombre from actores order by id_actor limit x,1);
        set id1=(select id_actor from actores order by id_actor limit x,1);
        set nom=(select prefijo_sra(nom));
        update actores set nombre=nom where id_actor=id1;
    end if;
	set x=x+1;
end while;
select * from actores;
end//
call modificarnombre();

Ejercicio 5.-

delimiter //
create function calcularedad(id1 int,año int,mes int,dia int) returns int no sql
begin
declare resultado int;
declare año_nac int;
declare mes_nac int;
declare dia_nac int;

set año_nac=(select year(fecha_nac) from actores where id_actor=id1);
set mes_nac=(select month(fecha_nac) from actores where id_actor=id1);
set dia_nac=(select day(fecha_nac) from actores where id_actor=id1);

if año_nac<año then
	set resultado=año-año_nac;
	if mes_nac>mes then
		set resultado=resultado-1;
	elseif mes_nac=mes then
		if dia_nac>dia then
			set resultado=resultado-1;
		end if;
	end if;
end if;
return resultado;
end//
delimiter //
create procedure modificar_edades(año int,mes int, dia int)
begin
declare x int default 0;
declare numactores int;
declare id1 int;
declare age int;

set numactores=(select count(*) from actores);
alter table actores add column edad int;

while x < numactores do
	set id1=(select id_actor from actores order by id_actor limit x,1);
    set age=(select calcularedad(id1,año,mes,dia));
    update actores set edad=age where id_actor=id1;
set x=x+1;
end while;
select * from actores;
end//
call modificar_edades(2025,5,6);
select * from actores;






