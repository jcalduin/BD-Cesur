create database tienda;
use tienda;

create table tienda(
	id int auto_increment primary key,
    nombre varchar(25) constraint chk_nombre check(nombre not like "%a%" and nombre not like "%e%" and nombre not like "%i%" and nombre not like "%o%" and nombre not like "%u%" and nombre not like "%s%s%s%" and char_length(nombre)>=10),
    apellido varchar(15) constraint chk_apellido check(char_length(apellido)>=5 and apellido not like "%s" and apellido not like "%a" and apellido not in ("zamora","torres","sánchez")),
    altura decimal(4,3) constraint chk_altura check(altura between 1.000 and 2.499) not null,
    orientacion enum("heterosexual","homosexual","otro") default "otro" not null

)auto_increment=500;

create table animales(
	id int auto_increment primary key,
    fecha date constraint chk_fecha check(month(fecha) in ("2","4","6","8","10","12") and month(fecha) > year(fecha)/100),
    raza enum("pastor","chihuahua","bulldog") default "pastor"

);


alter table animales add column cliente1 int not null;
alter table animales add column cliente2 int not null;

alter table animales add constraint fk_cliente1 foreign key (cliente1) references tienda(id);
alter table animales add constraint fk_cliente2 foreign key (cliente2) references tienda(id);

insert into tienda (altura) values
(1.64),
(1.875),
(2.33);

insert into animales(cliente1,cliente2) values
(500,500),
(501,501),
(502,502);

select * from tienda;
select * from animales;


ME MEREZCO EL 10 Y LO SABES!!!