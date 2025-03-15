Ejercicio 1.- Crea las siguientes tablas en la base de datos “Centro_adopción”.

		Perros (ID, nombre, edad, altura, raza, color, fecha_nac)
		Humanos(DNI, nombre, apellido, n_cuenta, edad, sexo)
			
- El número de cuenta estará formado por 8 números
- El valor del atributo “color” deberá ser marrón, gris o blanco
- El valor del atributo “sexo” deberá ser F o M

create database centro_adopcion;
use centro_adopcion;

create table perros(
	id int,
    nombre varchar(20),
    edad int,
    altura decimal(3,2),
    raza varchar(20),
    color enum("marron","gris","blanco"),
    fecha_nac date
);

create table humanos(
	dni varchar (15),
    nombre varchar(20),
    apellido varchar(25),
    n_cuenta int constraint chk_n_cuenta check(char_length(n_cuenta)=8),
    edad int,
    sexo enum("F","M")
);

select * from perros;
select * from humanos;

Ejercicio 2.- Añade una clave primaria a cada una de las tablas creadas.

alter table perros add primary key(id);
alter table humanos add primary key(dni);

Ejercicio 3.- Añade la clave de la tabla ‘Perros’ en la tabla ‘Humanos’ como clave foránea.

alter table humanos add column id_perros int;
alter table humanos add constraint fk_id_perro foreign key (id_perros) references perros (id);

Ejercicio 4.- Añade los siguientes contenidos a las tablas creadas.

INSERT INTO PERROS values
(1,'Toby',1,0.65,'Bulldog','marron','2018-10-10'),
(2,'Toby',5,1.20,'Pastor Alemán','gris','2015-01-12'),
(3,'Toby',12,2.05,'Galgo','blanco','2007-03-03'),
(4,'Toby',3,0.85,'Labrador','gris','2016-12-15'),
(5,'Toby',6,1.60,'Chihuahua','marron','2014-05-05');

insert into Humanos values
('44566880R','Jon','Zamora',12345678,22,'M',5),
('12300200M','Nuria','Lester',49213572,35,'F',3),
('42424242P','Aitor','Ramiro',67356870,43,'M',2),
('12345678L','Maria','Jimenez',68806005,19,'F',4);

Ejercicio 5.- Inserta los siguientes datos en las tablas creadas.

	- Inserta un nuevo perro con los siguientes datos:
- ID: 25
- Nombre: Timmy
- Edad: 3 años
- Altura: 1,85
- Raza: Shar Pei
- Color: Marrón
- Fecha_nac: 12 de octubre de 2016

insert into perros values (25,"timmy",3,1.85,"shar pei","marron","2016-10-12");

	- Añade en la tabla “Perros” una nueva columna “Estado” (Adiestrado o salvaje)
	- Inserta valores para que el valor “Estado” no sea nulo
    
alter table perros add column estado enum("adiestrado","salvaje") default "adiestrado";

Ejercicio 6.- Realiza las siguientes modificaciones de contenidos en las tablas creadas.

- Modifica la altura de los perros para que los datos se muestren en centímetros en vez de en metros
alter table perros modify altura decimal(5,2);
update perros set altura = altura*100;
alter table perros modify altura int;
alter table perros rename column altura to altura_cm;
- Modifica la edad de los perros para que los datos se muestren en meses en vez de en años
update perros set edad = edad*12;
alter table perros rename column edad to edad_en_meses;
- Añade en los nombres de los humanos el prefijo Sr o Sra dependiendo de su sexo
update humanos set nombre = concat("Sr ",nombre) where sexo like "m";
update humanos set nombre = concat("Sra ",nombre) where sexo like "f";
- Modifica el atributo “sexo” para que aparezca Femenino o Masculino en vez de F o M
alter table humanos modify sexo enum("masculino","femenino","f","m");
update humanos set sexo ="masculino" where nombre like "Sr %";
update humanos set sexo ="femenino" where nombre like "Sra %";
alter table humanos modify sexo enum("masculino","femenino");

* Los datos de la edad se actualizan una sola vez al año
Ejercicio 7.- Realiza las siguientes modificaciones de contenidos en las tablas creadas.

- Modifica la columna Edad de la tabla Humanos para que se llame ‘Años’
alter table humanos rename column edad to años;
- Modifica la columna N_cuenta para que los números de cuenta puedan contener 12 cifras más
alter table humanos drop constraint chk_n_cuenta;
alter table humanos modify n_cuenta int constraint chk_n_cuenta check(char_length(n_cuenta)>=8 and char_length(n_cuenta)<=20);
- Modifica las claves primarias para que no puedan ser NULL
alter table humanos modify dni varchar(15) not null;
alter table perros modify id int not null;

Ejercicio 8.- Elimina los siguientes contenidos de las tablas creadas

- Elimina los perros que tengan más de 80 meses de edad.
alter table humanos drop constraint fk_id_perro;
delete from perros where edad_en_meses > 80;
- Elimina los humanos con menos de 30 años
delete from humanos where años < 30;
- Elimina la columna Años de la tabla Humanos
alter table humanos drop column años;
- Elimina la clave foránea de la tabla Humanos
//ya hecho
- Elimina la tabla Humanos
drop table humanos;
- Elimina la base de datos “Centro_adopción”
drop database centro_adopcion;