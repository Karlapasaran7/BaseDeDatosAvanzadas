--Consultas Simples
Use Northwnd;


--Seleccionar cada una de las tablas de la bd nothwind

SELECT *
FROM customers;
GO 

SELECT * FROM Employees;

SELECT * FROM orders;

SELECT *
FROM Shippers;

SELECT * FROM Products;

SELECT * FROM [Order Details];

SELECT * FROM Suppliers;
--PROYECCION DE LA TABLA 
SELECT ProductName, UnitPrice, UnitPrice
From Products;

--Alias de columna
SELECT ProductName AS NombreProducto, 
UnitsInStock 'Unidades Medida',
UnitPrice AS [Precio Unitario]
FROM Products;

--Campo Calculado
SELECT 
[Order Details].OrderID AS [NUMERO DE ORDEN],
Products.ProductID AS [NUMERO DE PRODUCTO],
ProductName AS 'NOMBRE DEL PRODUCTO',
Quantity CANTIDAD,
Products.UnitPrice AS PRECIO, (Quantity *UnitPrice) AS SUBTOTAL
FROM [Order Details]
INNER JOIN 

ON Products.ProductID = OrderDetails.ProductID;

SELECT 
od.OrderId AS [NUMERO DE ORDEN],
pr.ProductID AS [NUMERO DE PRODUCTO],
ProductName AS 'NOMBRE DEL PRODUCTO',
Quantity CANTIDAD,
UnitPrice AS PRECIO, (Quantity * price) AS SUBTOTAL
FROM OrderDetails AS od
INNER JOIN 
Products pr
ON pr.ProductID = od.ProductID;

--Operadores Relacionales (<,> <=,>=, =, != o <>)
SELECT 
ProductName AS [NombreProducto],
UnitPrice AS [Descripcion],
UnitPrice AS [Precio]
FROM Products
WHERE UnitPrice >20;

--Seleccionar todos los clietes que no sean de Mexico
SELECT * 
FROM Customers
WHERE country <> 'Mexico';

--Seleccionar todas aquellas ordenes realizadas en 1997

SELECT 
OrderID AS [Número de Orden],
OrderDate AS [Fecha de Orden],
YEAR (OrderDate) AS [Año con Year],
DATEPART  (YEAR, OrderDate) AS [Año con DATEPART],
DATEPART (QUARTER, OrderDate) As Trimestre,
DATENAME (WEEKDAY, OrderDate) AS [Día Semana],
DATENAME (WEEKDAY, OrderDate) AS [Nombre Día Semana] 
FROM Orders
WHERE YEAR (OrderDate) = 1997;

--Operadores lógicos (AND, OR, NOT) seleccionar loss productos que tengas un precio mayor a 20 y un stock mayor a 30 
SELECT 
 ProductID AS [Número de producto],
 ProductName AS [Nombre del Producto],
 UnitsInStock AS [Existencia],
 UnitPrice AS [Precio],
 (UnitPrice * UnitsInStock) AS [Costo Inventario]
FROM Products 
WHERE UnitPrice  > 20
AND UnitsInStock > 30;

--Seleccionar a los clientes de EUU o Canada
SELECT 
CustomerID, 
CompanyName,
City,
Country
FROM Customers
WHERE Country = 'usa'
OR	Country =  'canada';


--Seleccionar los clientes de Brasil Rio de Janeiro y que tengan region
SELECT *
FROM Customers
Where Country = 'brazil' 
AND city = 'Rio de Janeiro'
AND Region IS NOT NULL;

--OPERADOR IN 
--Seleccionar todos los clientes de EEUU, Alemania y Francia
SELECT *
FROM Customers
WHERE Country IN ('USA', 'Germany', 'France')
ORDER BY Country DESC;

--Seleccionar todos los clientes que no sean de alemania, Mexico y Argentina
SELECT * 
FROM Customers
WHERE Country NOT IN ('Germany', 'Mexico', 'Argentina');


--SELECCIONAR LOS NOMBRES DE 3 CATEGORIAS ESPECIFICAS
SELECT  CategoryName
FROM Categories
WHERE CategoryID IN (1, 4, 8);

--SELECCIONAR LOS PEDIDOS DE 3 EMPLEADOS EN ESPECIFICO
SELECT e.EmployeeID,  
CONCAT (e.FirstName, e.LastName) AS Fullname,
o.OrderDate
FROM Orders AS o 
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.EmployeeID IN (5, 6, 7)
ORDER BY 2 DESC;

--ORDENADOR BETWEEN

--Seleccionar todos los productos que su precio este entre 10 y 30


SELECT ProductName, UnitPrice AS [precio]
FROM Products
WHERE UnitPrice BETWEEN 10 AND 30
ORDER BY [precio] DESC;

--Seleccionar todas las ordenes de 1995 a 1997
SELECT * 
FROM Orders
WHERE DATEPART (year, OrderDate) BETWEEN 1995 AND 1997;


--Seleccionar todos los productos que no esten en un precio entre 10 y 20 

SELECT * 
FROM Products
WHERE UnitPrice NOT BETWEEN 10 AND 20;

--OPERADOR LIKE
--WILDCARDS (%, _, [], [^])

--Seleccionar todos los clientes en donde su nombre empiece con a 
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%';

SELECT *
FROM Customers
WHERE CompanyName LIKE 'an%';

--Seleccionar todos los clientes de una ciudad que comienza con L, seguido de cualquier caracter, despúes ND y que termine con 2 caracteres cuales quiera
SELECT *
FROM Customers
WHERE City LIKE 'L_nd__';

--Seleccionar todos los clientes que su nombre termine con  a 
SELECT *
FROM Customers
WHERE CompanyName LIKE  '%a';