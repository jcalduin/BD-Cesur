create database notas;
use notas;

create table alumnos(
	dni varchar(9) primary key,
    nombre varchar(15) not null,
    apellido varchar(15) not null,
    edad decimal(2,0),
    fecha_nacimiento date,
    genero enum ("masculino","femenino","otros")

);

create table asignaturas(
	id decimal(1,0) primary key,
    nombre varchar(15),
    grado varchar(6),
    curso enum("1","2") not null

);

create table notas(
	cod int auto_increment primary key,
    nota decimal(3,2),
    profesor varchar(20)

);

alter table notas add column id_alumno varchar(9);
alter table notas add constraint fk_id_alumno foreign key (id_alumno) references alumnos(dni);

alter table notas add column id_asignatura decimal(1,0);
alter table notas add constraint fk_id_asignatura foreign key (id_asignatura) references asignaturas(id);

insert into alumnos values
("123456","pepe","villuela",21,"1975-7-21","otros"),
("123457","rosa","palma",35,"1962-9-30","femenino");

insert into asignaturas values
(4,"lengua","dam","1"),
(6,"base datos","daw",2);

insert into notas (nota,profesor,id_alumno,id_asignatura) values
(9.05,"jon","123456",4),
(4.55,"ramon","123457",6);

select * from alumnos;
select * from asignaturas;
select * from notas;