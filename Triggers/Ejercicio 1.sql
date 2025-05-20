CREATE DATABASE IF NOT EXISTS Netflix06;
USE Netflix06;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
	nombre_peli VARCHAR(30),
	duracion INT,
	director_peli VARCHAR(20),
	género_peli ENUM ('acción', 'drama', 'comedia'),
	nota_peli FLOAT,
	primary key (id_peli)
);

CREATE TABLE IF NOT EXISTS nueva_peliculas(
	id_peli int,
	nombre_peli VARCHAR(30),
	duracion INT,
	director_peli VARCHAR(20),
	género_peli ENUM ('acción', 'drama', 'comedia'),
   	nota_peli FLOAT,
	calidad enum ('buena', 'regular', 'mala'),
	estado enum ('activo', 'eliminado') default 'activo',
	primary key (id_peli)
);

CREATE TABLE IF NOT EXISTS informe_modificaciones(
	id int,
	usuario varchar(30),
	fecha date,
	hora time
);
    
Ejercicio 1.-
    
delimiter //
create trigger ej1
after insert on peliculas
for each row
begin
	insert into nueva_peliculas (id_peli,nombre_peli,duracion,director_peli,género_peli,nota_peli) values
	(new.id_peli,new.nombre_peli,new.duracion,new.director_peli,new.género_peli,new.nota_peli);
end//
insert into peliculas (id_peli,nombre_peli,duracion,director_peli,género_peli,nota_peli) values
(01,"Avatar",164,"De niro","accion",8.1);
select * from nueva_peliculas;
    
Ejercicio 2.-

delimiter //
create trigger ej2
before delete on peliculas
for each row
begin
	update nueva_peliculas set estado="eliminado" where id_peli=old.id_peli;
end//
delete from peliculas where id_peli=1;
select * from peliculas;

Ejercicio 3.-

delimiter //
create trigger ej3
after insert on peliculas
for each row
begin
	if new.nota_peli > 5 then
		update nueva_peliculas set calidad="buena" where id_peli=new.id_peli;
	elseif new.nota_peli < 5 then
		update nueva_peliculas set calidad="mala" where id_peli=new.id_peli;
	else
		update nueva_peliculas set calidad="regular" where id_peli=new.id_peli;
	end if;
end//
insert into peliculas (id_peli,nombre_peli,duracion,director_peli,género_peli,nota_peli) values
(02,"Avatar",164,"De niro","accion",8.1);
insert into peliculas (id_peli,nombre_peli,duracion,director_peli,género_peli,nota_peli) values
(03,"Avatar",164,"De niro","accion",4.1);
insert into peliculas (id_peli,nombre_peli,duracion,director_peli,género_peli,nota_peli) values
(04,"Avatar",164,"De niro","accion",5);
drop trigger ej3;

Ejercicio 4.-

delimiter //
create trigger ej4
after update on peliculas
for each row
begin
	declare usuario varchar(50);
    set usuario =(select user());
    insert into informe_modificaciones (id,usuario,fecha,hora) values
    (new.id_peli,usuario,curdate(),now());
end//
update peliculas set director_peli="Ernesto" where id_peli=03;
select * from informe_modificaciones;