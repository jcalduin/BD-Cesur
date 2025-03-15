CREATE DATABASE IF NOT EXISTS Tienda;
USE Tienda;

CREATE TABLE IF NOT EXISTS Categorias (
    id_categoria INT AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion TEXT,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS Productos (
    id_producto INT AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT,
    fecha_creacion DATE NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Categorias (id_categoria, nombre_categoria, descripcion) VALUES
(1, 'Electrónica', 'Dispositivos electrónicos y accesorios'),
(2, 'Hogar', 'Productos para el hogar y decoración'),
(3, 'Ropa', 'Vestimenta para todas las edades'),
(4, 'Alimentos', 'Productos comestibles y bebidas');

INSERT INTO Productos (nombre_producto, precio, stock, id_categoria, fecha_creacion) VALUES
('Televisor 4K', 1200.99, 10, 1, '2023-11-01'),
('Laptop Gamer', 1500.50, 5, 1, '2023-09-15'),
('Sofá de Cuero', 800.00, 3, 2, '2023-06-20'),
('Mesa de Comedor', 450.00, 8, 2, '2023-07-10'),
('Camisa de Algodón', 20.00, 50, 3, '2023-12-01'),
('Pantalones Jeans', 35.99, 40, 3, '2023-10-05'),
('Galletas de Chocolate', 2.50, 100, 4, '2023-11-25'),
('Botella de Agua', 1.00, 200, 4, '2023-12-05');

Consulta 1: Muestra el nombre de los productos, su precio y el nombre de su categoría. Ordena los resultados por precio de menor a mayor.

select p.nombre_producto, p.precio, c.nombre_categoria
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
order by precio asc;

Consulta 2: Muestra el nombre de las categorías junto con el número de productos que pertenecen a cada categoría. 
Ordena los resultados alfabéticamente por el nombre de la categoría.

select c.nombre_categoria, count(p.id_producto)
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
group by c.nombre_categoria;

Consulta 3: Muestra los productos que tienen un stock menor a 10. Incluye su nombre, precio, categoría y la fecha en la que 
se añadieron al inventario.

select p.nombre_producto, p.precio, c.nombre_categoria, p.fecha_creacion
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria; 

Consulta 4: Muestra el precio promedio de los productos agrupados por categoría. 
Ordena los resultados por precio promedio de mayor a menor.

select avg(p.precio)
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
group by c.id_categoria;

Consulta 5: Muestra el producto más caro de cada categoría junto con su nombre, precio y categoría.

select c.nombre_categoria, p.nombre_producto, p.precio
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
where p.precio = (select max(p2.precio) from productos as p2 where p2.id_categoria = p.id_categoria);

Consulta 6: Muestra las categorías que tienen productos con un precio superior a $500. 
Solo incluye el nombre de la categoría y el número de productos que cumplen esta condición.

select c.nombre_categoria, count(p.id_producto)
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
where p.precio >= 500
group by c.nombre_categoria;

Consulta 7: Muestra los productos cuya fecha de creación sea del mes de diciembre, junto con su nombre, precio y categoría.

select p.nombre_producto, p.precio, c.nombre_categoria
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
where month(fecha_creacion) = 12;

Consulta 8: Muestra los productos cuya descripción de la categoría contiene la palabra "para". 
Incluye el nombre del producto, el nombre de la categoría y su precio.

select p.nombre_producto, c.nombre_categoria, p.precio
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
where c.descripcion like "%para%";

Consulta 9: Muestra el stock total de productos agrupado por categoría. Ordena los resultados de mayor a menor cantidad de stock.

select c.nombre_categoria, sum(p.stock)
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
group by p.id_categoria
order by sum(p.stock) desc;

Consulta 10: Muestra las categorías que no tienen productos asociados en la tabla de productos.

select c.nombre_categoria
from categorias as c inner join productos as p on c.id_categoria=p.id_categoria
where p.id_categoria is null;