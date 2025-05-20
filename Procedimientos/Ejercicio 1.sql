CREATE DATABASE IF NOT EXISTS Netflix02;
USE Netflix02;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
    nombre_peli VARCHAR(30),
    duracion INT,
    director_peli VARCHAR(20),
    género_peli ENUM ('acción', 'drama', 'comedia'),
    nota_peli FLOAT,
    primary key (id_peli)
);

INSERT INTO Peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1),
('Frida', 100, 'Daniel', 'drama', 7.6, 10),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 11),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 100),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 21),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 17),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 41),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 101);

Ejercicio 1.-

delimiter //
create procedure ej1()
begin
insert into peliculas(nombre_peli,duracion,director_peli,género_peli,nota_peli,id_peli) values 
("la historia interminable",110,"barbara","accion",8,3);
select * from peliculas;
end//
call ej1();

Ejercicio 2.-

delimiter //
create procedure ej2(nom varchar(50),nota float)
begin
update peliculas set nota_peli=nota where nombre_peli=nom;
select * from peliculas;
end//
call ej2("el hoyo", 6.5);

Ejercicio 3.-

delimiter //
create procedure ej3()
begin
alter table peliculas add column valoraciones enum("buena","mala","regular");
update peliculas set valoraciones="buena" where nota_peli > 7;
update peliculas set valoraciones="mala" where nota_peli < 3.5;
update peliculas set valoraciones="regular" where nota_peli between 3.5 and 7;
select * from peliculas;
end//
call ej3();

Ejercicio 4.-

delimiter //
create procedure ej4(identificador int,nom varchar(50))
begin
update peliculas set director_peli=nom where id_peli=identificador;
select * from peliculas;
end//
call ej4(3,"Felipe gologluglu");