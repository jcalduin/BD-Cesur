create database usuarios;
use usuarios;

create table usuario(
	dni varchar(9) primary key,
    nombre varchar(30),
    apellido varchar(30),
    fecha_nac date
);

create table alta_usuario(
	id int auto_increment primary key,
	alta enum ("mañana", "tarde", "noche"),
    edad int,
    gestion varchar(50)
);

create table modificaciones_usuario(
	id int auto_increment primary key,
    columna varchar(30),
    pre varchar(30),
	post varchar(30)
);

Ejercicio 1.-

delimiter //
create trigger ej1
after update on usuario
for each row
begin
	if old.nombre != new.nombre then
		insert into modificaciones_usuario (columna, pre, post) values
        ("nombre",old.nombre,new.nombre);
    end if;
	if old.apellido != new.apellido then
		insert into modificaciones_usuario (columna, pre, post) values
        ("apellido",old.apellido,new.apellido);
    end if;
	if old.fecha_nac != new.fecha_nac then
		insert into modificaciones_usuario (columna, pre, post) values
        ("fecha_nac",old.fecha_nac,new.fecha_nac);
    end if;
end//
insert into usuario (dni,nombre,apellido,fecha_nac) values("76845219G","javi","cabrera","1994-12-17");
select * from usuario;
update usuario set nombre="Alberto" where dni="76845219G";
select * from modificaciones_usuario;

Ejercicio 2.-

delimiter //
create trigger ej2
after insert on usuario
for each row
begin
	declare hora_actual time;
    declare años int;
    set años =(select year(curdate()))-(select year(new.fecha_nac));
    set hora_actual=curtime();
    
    if month(curdate()) < month(new.fecha_nac) or (month(curdate()) = month(new.fecha_nac) and day(curdate()) < day(new.fecha_nac)) then
		set años=años-1;
	end if;
    
	if hora_actual >= "06:00:00" and hora_actual <= "13:59:59" then
		insert into alta_usuario (alta,edad,gestion) values ("mañana",años,user());
	elseif hora_actual >= "14:00:00" and hora_actual <= "20:59:59" then
		insert into alta_usuario (alta,edad,gestion) values ("tarde",años,user());
    else
		insert into alta_usuario (alta,edad,gestion) values ("noche",años,user());
    end if;
end//
insert into usuario (dni,nombre,apellido,fecha_nac) values("8A","javi","cabrera","1994-05-20");
select * from alta_usuario;
drop trigger ej2;