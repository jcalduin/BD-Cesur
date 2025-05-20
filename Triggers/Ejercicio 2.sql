CREATE DATABASE IF NOT EXISTS Netflix07;
USE Netflix07;

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

CREATE TABLE IF NOT EXISTS historial(
	id int,
	vieja_peli varchar(30),
	nueva_peli varchar(30)
);

CREATE TABLE IF NOT EXISTS peliculones(
	id int,
	nombre varchar(30),
	nota float
);

Ejercicio 1.-

delimiter //
create trigger ej1
after update on peliculas
for each row
begin
	if new.nombre_peli != old.nombre_peli then
		insert into historial (id,vieja_peli,nueva_peli)
        values (old.id_peli,old.nombre_peli,new.nombre_peli);
	end if;
end//
insert into peliculas (id_peli,nombre_peli,duracion,director_peli,género_peli,nota_peli) values
(02,"Avatar",164,"De niro","accion",9.1);
update peliculas set nombre_peli="Nuevo" where id_peli=01;
select * from peliculas;
select * from historial;

Ejercicio 2.-

delimiter //
create trigger ej2
after delete on peliculas
for each row
begin
	delete from historial where id=old.id_peli;
end//
delete from peliculas where id_peli=01;

Ejericicio 3.-

delimiter //
create trigger ej3
after insert on peliculas
for each row
begin
	if new.nota_peli > 9 then
		insert into peliculones (id,nombre,nota) values
        (new.id_peli,new.nombre_peli,new.nota_peli);
    end if;
end//
select * from peliculones;

Ejercicio 4.-

delimiter //
create trigger ej4
after insert on peliculas
for each row
begin
	declare media float;
    set media=(select avg(nota_peli) from peliculas);
    if media >new.id_peli then
		insert into peliculones (id,nombre,nota) values
        (new.id_peli,new.nombre_peli,new.nota_peli);
    end if;
end//