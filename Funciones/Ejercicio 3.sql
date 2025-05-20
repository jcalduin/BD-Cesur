use concesionario;

Ejercicio 1.-

delimiter //
create function caracruz(moneda varchar(10)) returns varchar(50) no sql
begin
declare resultado varchar(50);
declare cara int;
declare cruz int;
declare aleatorio int;
declare maquina varchar(10);
 
if moneda = "cara" then
	set cara = 1;
else
	set cruz = 2;
end if;
 
set aleatorio =  rand()*(2-1)+1;
if aleatorio = 1 then
	set maquina = "cara";
else
	set maquina = "cruz";
end if;
 
if cara = aleatorio then
	set resultado = concat("La máquina eligió ",maquina," el usuario ha acertado");
elseif cruz = aleatorio then 
	set resultado = concat("La máquina eligió ",maquina," el usuario ha acertado");
else
	set resultado = concat("La máquina eligió ",maquina," el usuario no ha acertado");
end if;
 
return resultado;
end//
 
select caracruz("cruz");

Ejercicio 2.-

delimiter //
create function juegoazar(n int) returns varchar(100) no sql
begin
declare resultado varchar(100);
declare aleatoriofuncion int;
declare aleatoriomaquina int;

set aleatoriofuncion = rand()*(100-0)+0;
set aleatoriomaquina = rand()*(100-0)+0;

if abs(n - aleatoriofuncion) < abs(aleatoriomaquina - aleatoriofuncion) then
	set resultado = concat("Usuario: ",n,"-- Funcion: ",aleatoriofuncion,"-- Máquina: ",aleatoriomaquina,"---¡¡EL USUARIO HA GANADO!!");
elseif abs(n - aleatoriofuncion) > abs(aleatoriomaquina - aleatoriofuncion) then
	set resultado = concat("Usuario: ",n,"-- Funcion: ",aleatoriofuncion,"-- Máquina: ",aleatoriomaquina,"---¡¡LA MÁQUINA HA GANADO!!");
else 
	set resultado = concat("Usuario: ",n,"-- Funcion: ",aleatoriofuncion,"-- Máquina: ",aleatoriomaquina,"---¡¡AMBOS JUGADORES EMPATAN!!");
end if;

return resultado;
end//

select juegoazar(80);