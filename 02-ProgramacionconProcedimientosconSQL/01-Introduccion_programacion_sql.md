
#Fundamentos Programables 
1.- ¿Qué es la parte programable de  T- transack SQL Server?
R: Es la parte de SQL Server que permite crear objetos programables como procedimientos almacenados, funciones, triggers, etc. Estos objetos permiten encapsular lógica de negocio y reutilizar código, facilitando el mantenimiento y la eficiencia en la gestión de datos.
Es to do lo que permite: 
-Usar variables
-Control de flujo (IF, WHILE, etc.)
-Crear procedimientos almacenados (store Procedures)
-Manejar errores (TRY...CATCH)
-Crear funciones definidas por el usuario (UDF)
-Usar transacciones (BEGIN TRANSACTION, COMMIT, ROLLBACK)
-Crear triggers (disparadores)

NOTA: Es convertir SQL en un lenguaje casi como C/ java pero dentro del engine

2.- Variables 
Una variable almacena un valor temporal que puede ser utilizado y modificado durante 
la ejecución de un bloque de código. En T-SQL,
 las variables se declaran utilizando la palabra clave DECLARE

 '''SQL
 /*================VARIABLES======================*/
DECLARE @Edad INT 
SET @Edad = 42

SELECT @Edad AS Edad

PRINT CONCAT ('La edad es: ', @Edad)

/*==================Ejercicios con variables====================*/
/*1.- Declarar una variable precio
2.- Asignarle el valor de 150
Calcular el IVA del 16%
4.- Mostrar el total*/
DECLARE @Precio MONEY = 150 --Se le asigna un valor inicial
--SET @Precio = 150
DECLARE @Total MONEY
SET @Total = @Precio * 1.16
SELECT @Total AS [Total] 

'''

3.- IF / ELSE
Permite ejecutar codigo segun una condicion 
'''SQL 
/*==================IF / ELSE====================*/
/* */
DECLARE @edad2 INT
SET @edad2 = 18
IF @edad2 >= 18
BEGIN
PRINT 'Es mayor de Edad'
PRINT 'Felicidades'
END
ELSE PRINT 'Es menor de edad'+

'''
/*==================IF / ELSE====================*/
/* */
DECLARE @edad2 INT
SET @edad2 = 18
IF @edad2 >= 18
BEGIN
PRINT 'Es mayor de Edad'
PRINT 'Felicidades'
END
ELSE PRINT 'Es menor de edad'
'''

'''
/*==================EJERCICIO IF / ELSE====================*/
/*1.- Crear una variable calificacion 
2.- Evaluar si es mayor a 70 imprimir "Aprovado, sino "Reprobado"
*/
DECLARE @Calificacion INT
SET @Calificacion = 85

IF @Calificacion > 70
BEGIN
PRINT 'Aprobado'
END
ELSE
BEGIN
PRINT 'Reprobado'
END
'''


4.- WHILE 
'''sql
'''


##Procedimientos Almacenados (Stored Procedures)

5.- ¿Qué es un Stored Procedure?
Es un bloque de código guardado en la base de datos que se puede ejecutar 
cuando se necesita

'''sql
CREATE PROC ups_objeto_accion
[Parametros]
AS 
BEGIN
 ---Body
 END;


---Actualizar 
CREATE OR ALTER PROCEDURE ups_objeto_accion
[Parametros]
AS 
BEGIN
 ---Body
 END;

 --ELIMINAR 
 DROP ups_objeto_accion
[Parametros]
AS 
BEGIN
 ---Body
 END;


'''
sql
/*==================STORED PROCEDURES====================*/
CREATE PROCEDURE ups_mensaje_Saludar
AS 
BEGIN 
PRINT 'Hola, bienvenido a Transact-SQL'
END;
GO

EXECUTE ups_mensaje_Saludar;
GO

EXEC ups_mensaje_Saludar;
GO


--Elimina un store
DROP PROC ups_mensaje_Saludar;

/*==================STORED EJERCICIOS====================*/
--Crear un store procedire que imprima la fecha actual

CREATE PROCEDURE ups_fecha_actual
AS 
BEGIN 
PRINT 'La fecha actual es: ' + CAST(GETDATE() AS VARCHAR(30));
END;
GO

EXECUTE ups_fecha_actual;
GO

--Crear un store procedire que imprima el nombre de la base de datos actual
 CREATE PROCEDURE usp_nombredb_mostrar
 AS 
 BEGIN
 SELECT DB_NAME () AS [Nombre_DB];
 END;

 EXEC usp_nombredb_mostrar;
 '''