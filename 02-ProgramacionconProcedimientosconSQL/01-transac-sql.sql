USE NORTHWND;

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

--TODO: CICLO WHILE 
DECLARE @contador INT;
DECLARE @contador2 INT;
SET @contador  = 1;
SET @contador2 = 3; 

WHILE  @contador <= 5
BEGIN 
  WHILE   @contador2 <=5
  BEGIN
  PRINT CONCAT(@contador, '-' , @contador2);
  SET @contador2 = @contador2 + 1
  END;
  SET @contador2 = 1
    SET @contador = @contador + 1;
END
GO


--IMPRIMIR LOS NUMEROS DEL 1 AL 10
DECLARE @i INT; 
SET @i = 10;

WHILE @i>=1
BEGIN 
PRINT @i
SET @i =  @i -1;
END;

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

