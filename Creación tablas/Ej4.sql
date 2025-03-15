create database POKEMON_GO;
use POKEMON_GO;

create table pokemon(
	id int primary key auto_increment,
    nombre varchar(15) constraint chk_nombre check(nombre not like "% %"),
    altura decimal(3,2) constraint chk_altura check(altura between 0.51 and 3.49),
    edad int constraint chk_edad check(edad between 1 and 100),
    fecha_nac date not null

)auto_increment=100;

create table entrenador(
	dni varchar(9) primary key constraint chk_dni check(char_length(dni)>=1),
    nombre varchar(15) default "NULL",
    apellido varchar(20) constraint chk_apellido check(apellido like "%a%a%"),
    genero enum ("masculino","femenino","otro") not null,
    pokemon int

);

alter table entrenador add constraint fk_pokemon foreign key(pokemon) references pokemon(id); 

insert into pokemon (nombre,altura,edad,fecha_nac) values
("pikachu",0.70,5,"2021-5-12");

insert into entrenador values
("123456","ash","aranda","otro",100);

select * from pokemon;
select * from entrenador;