create database tragaperras;
use tragaperras;
create table premios(
id int auto_increment primary key,
icono varchar(30),
premio decimal(3,2)
);
insert into premios(icono, premio) values 
("Fresa", 0.40),
("Manzana", 0.80),
("Pera", 1.20),
("Limon", 1.40),
("Frambuesa", 1.60),
("Cereza", 1.80),
("Mandarina", 2.00),
("Naranja", 3.00),
("Melocotón", 4.00),
("Sandía", 6.00);

select * from premios;

delimiter //
create function tragaperras(dinero decimal(6,2)) returns varchar(150) no sql
begin
declare resultado varchar(150);
declare tiradas int;
declare contador int default 0;
declare engranaje1 int;
declare engranaje2 int;
declare engranaje3 int;
declare ganancias float default 0;
declare perdidas float default dinero;
declare monedero float;


set tiradas = dinero /0.20;

while contador <= tiradas do
	set engranaje1 = rand()*(10-1)+1;
    set engranaje2 = rand()*(10-1)+1;
    set engranaje3 = rand()*(10-1)+1;
    
    if engranaje1=engranaje2 and engranaje1=engranaje3 then
		set monedero = (select premio from premios where id = engranaje1);
        set ganancias = ganancias + monedero;
        set perdidas = perdidas - 0.20;
	else
		set perdidas = perdidas - 0.20;
    end if;
	set contador = contador +1;
end while;

set resultado = concat("Ganancias del usuario: ",ganancias,"€; Perdidas del usuario: ",perdidas,"€");
return resultado;
end//
select tragaperras(5.20);

delimiter //
create function tragaperra(dinero decimal(6,2)) returns varchar(1000) no sql
begin
declare resultado varchar(1000);
declare perdidas decimal(6,2);
declare ganancias decimal(6,2);
declare num1 int;
declare num2 int;
declare num3 int;
set ganancias=0;
set perdidas=dinero;
set resultado="";
while dinero >= 0.20 do
set num1=rand()*(10-1)+1;
 set num2=rand()*(10-1)+1;
 set num3=rand()*(10-1)+1;
if num1=num2 and num1=num3 then
 set ganancias=ganancias+(select premio from premios where id=num1);
 end if;
 
set dinero=dinero-0.20;
end while;
set resultado=concat("perdidas: ", perdidas, " y ganancias: ", ganancias);
return resultado;
end//
select tragaperra(5.20);