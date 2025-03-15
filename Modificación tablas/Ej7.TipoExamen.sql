Create database TINDER;
Use TINDER;

Create table USUARIOS(
ID int auto_increment Primary Key,
Nombre varchar (15) not null,
Apellido varchar(20),
Edad int not null constraint edad_chk check(Edad between 18 and 99),
Orientacion enum("heterosexual","homosexual")
);

Create table LIKES(
	ID int Primary Key,
	Fecha date,
	Tipo Enum("like" , "superlike") default "like" not null,
	Usuario1 int not null,
	usuario2 int not null
);

insert into USUARIOS (Nombre, Apellido, Edad, Orientacion) values
("Jon", "Zamora", 34, "Heterosexual"),
("Francisco", "Romero", 52, "Homosexual"),
("Julia", "Torrejon", 46, "Heterosexual"),
("Beatriz", "Ruiz", 18, "Homosexual");

insert into LIKES (ID, Fecha, Tipo, Usuario1, Usuario2) values
(101, "2002-12-12", "like", 1, 2),
(102, "2022-01-01","superlike", 2, 1),
(103, "2016-05-15", "like", 4, 2),
(104, "2020-04-12", "like", 4, 3);

ALTER TABLE LIKES ADD CONSTRAINT fk_usuario1 FOREIGN KEY (Usuario1) REFERENCES USUARIOS(ID);
ALTER TABLE LIKES ADD CONSTRAINT fk_usuario2 FOREIGN KEY (Usuario2) REFERENCES USUARIOS(ID);

select * from usuarios;
select * from likes;

Ejercicio 1.- Añade una nueva columna "Altura" a la tabla USUARIOS que por defecto tenga un valor 1.70 
y deba ser un valor entre 1.50 y 2.00 (ambos incluidos).

alter table usuarios add column altura decimal(3,2) default 1.70;
alter table usuarios add constraint chk_altura check(altura between 1.50 and 2.00);

Ejercicio 2.- Añade un usuario a la tabla USUARIOS con los siguientes datos. 

	- Nombre: "Antonio"
	- Apellido: "Alcantara"
	- Edad: 17
	- Orientacion: "Otro"
alter table usuarios modify orientacion enum("heterosexual","homosexual","otro");
alter table usuarios drop constraint edad_chk;
insert into usuarios (nombre,apellido,edad,orientacion) values ("antonio","alcantara",17,"otro");

Ejercicio 3.- Añade un usuario a la tabla LIKES con los siguientes datos. 

	- ID: 105
	- Fecha: "2022-02-30"
	- Tipo: "like"
	- Usuario1: 9
	- Usuario2: 7
alter table likes modify fecha varchar(20);
alter table likes drop constraint fk_usuario1;
alter table likes drop constraint fk_usuario2;
insert into likes values (105,"2022-02-30","like",9,7);

Ejercicio 4.- Añade un usuario a la tabla USUARIOS con los siguientes datos. 

	- Nombre: null
	- Apellido: "Rodriguez"
	- Edad: 30
	- Orientacion: "Homosexual"
	- Altura: 1.425
alter table usuarios modify nombre varchar(15);
alter table usuarios drop constraint chk_altura;
alter table usuarios modify altura decimal(4,3);
insert into usuarios (apellido,edad,orientacion,altura) values ("rodriguez",30,"homosexual",1.425);

Ejercicio 5.- Modifica los siguientes datos de la base de datos TINDER.

- Añade 50 años a la edad de todos los usuarios de Orientación "homosexual"

update usuarios set edad = edad +50 
where orientacion like "homosexual";
	
- Modifica el nombre de los usuarios con orientación distinta a "Otro", y edad superior a 75 años, para que su nombre sea "Pepe"

update usuarios set nombre = "pepe"
where orientacion not like "otro" and edad > 75;

- Elimina los datos de los Usuarios con más de 50 años o que su género sea igual a "Otro".

delete from usuarios
where edad > 50 or orientacion like "otro";

- Elimina los datos de los Usuarios que contengan más de una "a" en su nombre o en su apellido

delete from usuarios
where nombre like "%a%a%" or apellido like "%a%a%"; 
