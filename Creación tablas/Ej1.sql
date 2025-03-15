create database cesur;
use cesur;

create table alumno(
	dni varchar(9) primary key,
    nombre varchar(15),
    apellido varchar(20),
    edad int

);

create table grado(
	id int primary key,
    nombre varchar(15),
    horas int

);

alter table alumno add column grado int;
alter table alumno add constraint fk_grado foreign key (grado) references grado(id);

insert into grado values
(1,"DAM",20),
(2,"DAW",19),
(3,"DAM",21),
(4,"DAW",16),
(5,"DAW",15);

insert into alumno values
("A001","paco","ramirez",21,1),
("A002","Rodolfo","sanchis",31,2),
("A003","Aitor","Menta",18,3),
("A004","Tomás","Turbado",20,4),
("A005","María","Flores",24,5);