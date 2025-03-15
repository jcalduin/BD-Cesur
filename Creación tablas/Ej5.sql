create database concesionario;
use concesionario;

create table coche(
	id int primary key auto_increment,
    matricula varchar(8) constraint chk_matricula check(char_length(matricula)=8 and matricula like "%-%") unique not null,
    precio decimal(8,2) constraint chk_precio check(precio between 10000.00 and 100000.00),
    color enum("negro","blanco","azul","rojo","gris") default "negro"

)auto_increment=2000;

create table vendedor(
	dni varchar(9) primary key constraint chk_dni check(char_length(dni)=9),
    nombre varchar(10) constraint chk_nombre check((nombre like "%a%a%" or nombre like "%e%e%" or nombre like "%i%i%" or nombre like "%o%o%" or nombre like "%u%u%") and (nombre like "%a%r%" or nombre like "%r%a%")) not null,
    apellido varchar(20) constraint chk_apellido check((apellido like "%s" or apellido like "s%") and char_length(apellido)>=8),
    direccion varchar(100) constraint chk_direccion check((direccion like "%avenida%" or direccion like "%calle%") and (direccion like "%bloque%" or direccion like "%numero%")),
    email varchar(20) constraint chk_email check(email like "%@%" and (email like "%gmail%" or email like "%hotmail%") and (email like "%.com" or email like "%.es")) not null

);

create table venta(
	id_venta int primary key auto_increment,
    coche int not null,
    empleado varchar(9) constraint chk_empleado check(char_length(empleado)=9) not null,
    fecha_venta date constraint chk_fecha_venta check(month(fecha_venta) in ("6","7","8","9")) not null

)auto_increment=1;

alter table venta add constraint fk_coche foreign key (coche) references coche(id);
alter table venta add constraint fk_empleado foreign key (empleado) references vendedor(dni);

insert into coche(matricula,precio,color) values 
("4568-pfg",90000,"rojo"),
("4567-rfs",55700.88,"gris"),
("4521-sop",23440.31,"negro");

insert into vendedor values 
("12345678W","raar","peresssssss","avenida marmol bloque 57","inventado@gmail.es"),
("12345678R","reaer","peresssssss","calle marmol bloque 657","invente@hotmail.com"),
("12345678Q","paocor","serendipiag","calle pepito numero 8","gmail@gmail.com");

insert into venta(coche,empleado,fecha_venta) values
(2002,"12345678R","2019-8-20"),
(2000,"12345678Q","2023-9-13"),
(2001,"12345678W","2024-6-5");

