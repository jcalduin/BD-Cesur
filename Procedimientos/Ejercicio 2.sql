CREATE DATABASE IF NOT EXISTS Netflix01;
USE Netflix01;

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

select * from actores;

Ejercicio 1.-

delimiter //
create procedure ej1()
begin
declare media decimal(10,2);
set media = (select avg(sueldo) from actores);
update actores set sueldo=media;
select * from actores;
end//
call ej1();

Ejercicio 2.-

delimiter //
create procedure ej2(num int)
begin
delete from actores order by sueldo desc limit num;
select * from actores order by sueldo desc;
end//
call ej2(3);

Ejercicio 3.-

delimiter //
create procedure ej3(nom varchar(50))
begin
declare actor varchar(50);
set actor = (select id_actor from actores order by fecha_nac asc limit 2,1);
update actores set nombre=nom where id_actor=actor;
select * from actores;
end//
call ej3("romualdo");

Ejercicio 4.-

delimiter //
create procedure ej4(eleccion varchar(25))
begin
declare identificador int;
declare numactores int;
declare caracteres int;
declare x int default 0;

set numactores = (select count(*) from actores);

if eleccion="joven" then
	set identificador = (select id_actor from actores order by fecha_nac desc limit 1);
    set eleccion = (select nombre from actores where id_actor=identificador);
    set caracteres =(select char_length(nombre) from actores where id_actor=identificador);
    set caracteres = numactores-caracteres;
    while x < caracteres do
		set eleccion =concat(eleccion,"*");
        set x = x+1;
	end while;
    update actores set nombre=eleccion where id_actor=identificador;
else 
	set identificador = (select id_actor from actores order by sueldo asc limit 1);
    set eleccion = (select nombre from actores where id_actor=identificador);
    set caracteres =(select char_length(nombre) from actores where id_actor=identificador);
    set caracteres = numactores-caracteres;
    while x < caracteres do
		set eleccion =concat(eleccion,"*");
        set x = x+1;
	end while;
    update actores set nombre=eleccion where id_actor=identificador;
end if;

select * from actores;
end//
call ej4("joven");