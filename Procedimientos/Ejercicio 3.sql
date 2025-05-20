CREATE DATABASE IF NOT EXISTS Netflix03;
USE Netflix03;

CREATE TABLE IF NOT EXISTS Actores(
	id_actor INT,
    nombre VARCHAR(30),
    fecha_nac DATE,
    sueldo INT,
    sexo ENUM ('femenino', 'masculino', 'otros'),
    primary key (id_actor)
);

INSERT INTO Actores(id_actor, nombre, fecha_nac, sueldo, sexo) VALUES
(101, 'Leonardo', '1980/12/01' , 3000000, 'masculino'),
(102, 'Julia', '1997/09/29' , 1000000, 'femenino'),
(103, 'Brad', '1983/02/12' , 700000, 'masculino'),
(104, 'Carlos', '1986/03/23' , 250000, 'masculino'),
(105, 'Santiago', '1970/04/30' , 4000000, 'masculino'),
(106, 'Penelope', '1976/05/20' , 23000, 'femenino'),
(107, 'Noa', '1981/06/16' , 770000, 'otros'),
(108, 'Jon', '1996/07/03' , 6000, 'otros'),
(109, 'pepa', '1972/07/07' , 526000, 'otros'),
(110, 'JOse', '1971/03/03' , 986000, 'otros');

Ejercicio 1.-

delimiter //
create procedure ej1()
begin

declare x int default 0;
declare numactores int;
declare nuevo_dia int;
declare nuevo_mes int;
declare id1 int;
declare año int;
declare nueva_fecha varchar(30);

set numactores =(select count(*) from actores);

while x < numactores do
	set id1 = (select id_actor from actores order by id_actor asc limit x,1);
    set nuevo_dia =(select month(fecha_nac) from actores order by id_actor asc limit x,1);
    set nuevo_mes =(select day(fecha_nac) from actores order by id_actor asc limit x,1);
    set año=(select year(fecha_nac) from actores order by id_actor asc limit x,1);
    set nueva_fecha = concat(año,"-",nuevo_mes,"-",nuevo_dia);
    
	if nuevo_mes <= 12 then
		if nuevo_mes=2 and nuevo_dia<=28 then
			update actores set fecha_nac=nueva_fecha where id_actor=id1;
		elseif mod(nuevo_mes,2)=0 and nuevo_dia<=30 then
			update actores set fecha_nac=nueva_fecha where id_actor=id1;
		elseif mod(nuevo_mes,2)!=0 and nuevo_dia<=31 then
			update actores set fecha_nac=nueva_fecha where id_actor=id1;
		end if;
    end if;
	set x = x+1;
end while;
select * from actores order by id_actor asc;
end//
call ej1();

Ejercicio 2.-

delimiter //
create procedure ej2(num int, genero varchar(25))
begin
declare x int default 0;
declare dia int;
declare mes int;
declare id1 int;
alter table actores modify sexo varchar (50);
while x < num do
	set dia=(select day(fecha_nac) from actores order by fecha_nac limit x,1);
    set mes=(select month(fecha_nac) from actores order by fecha_nac limit x,1);
    set id1 =(select id_actor from actores order by fecha_nac limit x,1);
    if dia=mes then
		update actores set sexo=genero where id_actor=id1;
    end if;
	set x = x+1;
end while;
select * from actores order by fecha_nac;
end//
call ej2(4,"travesti");

Ejercicio 3.-

delimiter //
create procedure ej3(x int, porcentaje int)
begin
declare num int default 0;
declare media float;
declare id1 int;
declare salario float;
declare cambio float;
set media = (select avg(sueldo) from actores);
while num < x do
	set salario=(select sueldo from actores order by id_actor limit num,1);
    set id1=(select id_actor from actores order by id_actor limit num,1);
    
    if media>salario then
		set cambio = (porcentaje*salario)/100;
        set cambio = salario+cambio;
        update actores set sueldo=cambio where id_actor=id1;
	else
		set cambio = (porcentaje*salario)/100;
        set cambio = salario-cambio;
        update actores set sueldo=cambio where id_actor=id1;
    end if;
	set num = num+1;
end while;
select * from actores order by id_actor;
end//
call ej3(5,50);

delimiter //
create procedure ej4()
begin
declare salario int;
declare x int default 1;
declare y int default 0;
declare numactores int;
declare id1 int;

set numactores=(select count(*) from actores);

while x < numactores do

	set salario =(select sueldo from actores order by fecha_nac limit x,1);
    set id1 =(select id_actor from actores order by fecha_nac limit y,1);
	update actores set sueldo=salario where id_actor=id1;
    
	set x = x+1;
	set y = y+1;
end while;

select * from actores order by fecha_nac;
end//
call ej4();