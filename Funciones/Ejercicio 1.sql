use pokemon_go;

Ejercicio 1.-

delimiter //
create function ej1(n1 int, n2 int) returns int no sql
begin
declare resultado int;
set resultado=n1+n2;
return resultado;
end//
select ej1(10,5);

Ejercicio 2.-

delimiter //
create function ej2(num int, palabra varchar(20)) returns int no sql
begin
declare resultado int;
declare caracteres int;
set caracteres=char_length(palabra);
set resultado=num+caracteres;
return resultado;
end//
select ej2(5,"hola");

Ejercicio 3.-

delimiter //
create function ej3(palabra1 varchar(40),palabra2 varchar(40)) returns varchar(85) no sql
begin
declare resultado varchar(85);
set resultado=concat(palabra1," y ",palabra2);
return resultado;
end//
select ej3("hola","adios");

Ejercicio 4.-

delimiter //
create function ej4(n1 int, n2 int) returns decimal(6,2) no sql
begin
declare resultado decimal(6,2);
set resultado=n1/n2;
return resultado;
end//
select ej4(91,9);

Ejercicio 5.-

delimiter //
create function ej5(n1 int) returns varchar(50) no sql
begin
declare resultado varchar(50);
declare aleatorio int;
set aleatorio=rand()*(10-1)+1;
if n1>aleatorio then
	set resultado=concat("Número maquina: ",aleatorio,". Tu número es mayor");
elseif n1=aleatorio then
	set resultado=concat("Los números son iguales");
else
	set resultado=concat("Número maquina: ",aleatorio,". Tu número es menor");
end if;
return resultado;
end//
select ej5(8);