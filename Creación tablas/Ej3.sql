create database liga_ea;
use liga_ea;

create table jugador(
	dni varchar(9) constraint chk_dni check(char_length(dni)=9),
    nombre varchar(20) constraint chk_nombre check(char_length(nombre)>=10),
    apellido varchar(20),
    altura decimal(3,2) constraint chk_apellido check(altura between 1.50 and 2.10),
    posicion enum("portero","defensa","medio","delantero","no definido") default "no definido",
    fecha_nacimiento date constraint chk_fecha_nacimiento check(month(fecha_nacimiento) between 3 and 10),
    email varchar(30) constraint chk_email check( email like "%@%"),
    direccion varchar(100) constraint chk_direccion check(direccion like "calle" or direccion like "avenida"),
    clave varchar(15) constraint chk_clave check(char_length(clave)>=8)

);

insert into jugador(clave) values ("12345678");

select * from jugador;