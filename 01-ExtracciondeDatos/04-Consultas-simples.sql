--Consultas Simples
Use Northwind;


--Seleccionar cada una de las tablas de la bd nothwind

SELECT *
FROM customers;
GO 

SELECT * FROM Employees;

SELECT * FROM orders;

SELECT *
FROM Shippers;

SELECT * FROM Products;

SELECT * FROM OrderDetails;

SELECT * FROM Suppliers;
--PROYECCION DE LA TABLA 
SELECT ProductName, unit, price
From Products;

--Alias de columna
SELECT ProductName AS NombreProducto, 
unit 'Unidades Medida',
price AS [Precio Unitario]
FROM Products;

--Campo Calculado
SELECT 
OrderID AS [NUMERO DE ORDEN],
Products.ProductID AS [NUMERO DE PRODUCTO],
ProductName AS 'NOMBRE DEL PRODUCTO',
Quantity CANTIDAD,
price AS PRECIO, (Quantity * price) AS SUBTOTAL
FROM OrderDetails
INNER JOIN 
Products
ON Products.ProductID = OrderDetails.ProductID;

SELECT 
OrderID AS [NUMERO DE ORDEN],
pr.ProductID AS [NUMERO DE PRODUCTO],
ProductName AS 'NOMBRE DEL PRODUCTO',
Quantity CANTIDAD,
price AS PRECIO, (Quantity * price) AS SUBTOTAL
FROM OrderDetails AS od
INNER JOIN 
Products pr
ON pr.ProductID = od.ProductID;

--Operadores Relacionales (<,> <=,>=, =, != o <>)
SELECT 
ProductName AS [NombreProducto],
Unit AS [Descripcion],
Price AS [Precio]
FROM Products
WHERE price >20;

--Seleccionar todos los clietes que no sean de Mexico
SELECT * 
FROM Customers
WHERE country <> 'Mexico';

--Seleccionar todas aquellas ordenes realizadas en 1997
SELECT 
OrderID AS [Número de Orden],
OrderDate AS [Fecha de Orden],
YEAR (OrderDate) AS [Año con Year],
DATEPART (YEAR, OrderDate) AS [Año con DATEPART]
FROM Orders
WHERE YEAR (OrderDate) = 1997;

--Operadores lógicos (AND, OR, NOT)
SELECT *
FROM 