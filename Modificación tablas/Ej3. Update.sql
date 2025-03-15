Create database cesur;
use cesur;

CREATE TABLE ALUMNO(
DNI varchar(9),
nombre varchar(15),
apellido varchar(20),
edad INT,
PRIMARY KEY(DNI)
);

CREATE TABLE GRADO(
ID INT,
nombre varchar(15),
horas INT,
PRIMARY KEY(ID)
);

INSERT INTO ALUMNO (DNI, nombre, apellido, edad) values
('44566835T', 'jon', 'zamora', 32),
('44576835T', 'manuel', 'fernandez', 22),
('43466835T', 'lorena', 'aleman', 20),
('42166835T', 'pepe', 'gavilan', 18),
('41166835T', 'celia', 'flores', 40);

INSERT INTO GRADO (ID, nombre, horas) values
(001, 'DAM1', 430),
(002, 'DAW2', 300),
(003, 'ASIR1', 500),
(004, 'SMR1', 300),
(005, 'SMR2', 270);

ALTER TABLE ALUMNO ADD COLUMN grado int,
ADD CONSTRAINT `fk_id_grado` FOREIGN KEY (grado) REFERENCES GRADO (id);

select * from alumno;
select * from ciclo;
SHOW CREATE TABLE alumno;

Ejercicio 1.- Añade una nueva columna (no nula) “Ciudad” a la tabla ALUMNO de tipo caracteres (máximo 15 caracteres) 
que por defecto tenga “Malaga” como valor.

alter table alumno
add ciudad varchar(15) not null default "Málaga";

Ejercicio 2.- Modifica la columna “Ciudad” para que acepte valores nulos.

alter table alumno
modify ciudad varchar(15) null;

Ejercicio 3.- Modifica la columna “Ciudad” para que acepte valores de hasta 25 caracteres.

alter table alumno
modify ciudad varchar(25) null;

Ejercicio 4.- Modifica el nombre de la columna “Ciudad” a “Localidad”.

alter table alumno
rename column ciudad to localidad;

Ejercicio 5.- Añade una nueva columna “Media” en la tabla ALUMNO que sea de tipo decimal (con un decimal máximo) 
y pueda tener una nota máxima de 9,9.

alter table alumno
add media decimal(2,1) constraint chk_media check(media <= 9.9);

Ejercicio 6.- Modifica la columna “Media” para que acepte valores con 2 decimales, tenga el valor 0,0 por defecto y no pueda ser NULL.

ALTER TABLE alumno 
MODIFY media DECIMAL(3,2) default 0.00;

Ejercicio 7.- Elimina la restricción de clave foránea de la columna Grado de la tabla ALUMNO.

alter table alumno
drop foreign key fk_id_grado;

Ejercicio 8.- Elimina la restricción de clave primaria de la columna DNI de la tabla ALUMNO.

alter table alumno
drop primary key;

Ejercicio 9.- Elimina la columna Grado de la tabla ALUMNO.

alter table alumno
drop grado;

Ejercicio 10.- Añade una clave primaria a la tabla ALUMNO que sea un entero y se incremente de forma automática.

alter table alumno
add id int auto_increment primary key;

Ejercicio 11.- Añade una restricción a la columna Nombre de la tabla GRADO para que los valores del nombre siempre 
contenga el número 1 o el número 2.

alter table grado
add constraint chk_nombre check(nombre like "%1" or nombre like "%2");

Ejercicio 12- Elimina la restricción de la columna Nombre de la tabla GRADO

alter table grado
drop constraint chk_nombre;

Ejercicio 13.- Modifica el nombre de la tabla GRADO a CICLO.

alter table grado
rename to ciclo;

Ejercicio 14.- Elimina las tablas CICLO y ALUMNO.

drop table ciclo;
drop table alumno;

Ejercicio 15.- Elimina la base de datos CESUR.

drop database cesur;