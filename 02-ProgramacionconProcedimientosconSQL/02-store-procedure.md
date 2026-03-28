CREATE DATABASE bdstored;
GO
USE bdstored;
GO

CREATE OR ALTER PROC spu_persona_saludar 
    @nombre VARCHAR (50) --Parametro de antrada
    AS
    BEGIN
    PRINT 'HOLA' + @nombre;
    END;
    GO

    EXEC spu_persona_saludar 'Arcadio';
    EXEC spu_persona_saludar 'Roberta';
    EXEC spu_persona_saludar 'Monico';
    EXEC spu_persona_saludar 'Luisa';
    GO

 SELECT CustomerID, CompanyName, City, Country
 INTO customers
 FROM 
 NORTHWND.dbo.Customers;
 GO 

 SELECT * FROM customers;

 --Realizar un Stored que reciba un parametro de un cliente en particular y lo muestre
 CREATE OR ALTER PROC  spu_cliente_consultarporid
 @Id CHAR (5)
 AS 
 BEGIN
     SELECT 
     CustomerID AS [NUMERO], 
     CompanyName AS [CLIENTE],
     City AS [CIUDAD],
     Country AS [PAIS]
     FROM customers
     WHERE CustomerID = TRIM (@Id);
 END;

 EXEC spu_cliente_consultarporid 'ANTONT';
 GO

 /*SELECT * FROM customers
 WHERE EXISTS (SELECT 1
 FROM customers
 WHERE CustomerID = 'ANTONT')*/

 DECLARE @valor int 
 SET @valor = (SELECT 1
 FROM customers
 WHERE CustomerID = 'ANTONT') ---TODO ESTO NO IMPRIME SIN IF
 IF @valor = 1
 BEGIN 
     PRINT 'Existe'
 END
 ELSE
 BEGIN 
     PRINT 'No Existe'
 END
 GO

 ----------------------PROCESO POR ID 2 ------------------------
 CREATE OR ALTER PROC  spu_cliente_consultarporid2
 @Id CHAR (10)
 AS 
 BEGIN

 IF LEN (@Id) > 5 
 BEGIN
 RAISERROR ('EL ID DEL CLIENTE DEBE DE SER MENOR OVIGUAL A 5', 16,1);
 --;THROW 50001, 'El númerode cliente debe ser menor o igual a 5', 1;
 RETURN
 END;

 IF EXISTS (SELECT 1 FROM customers WHERE CustomerID = @Id)
 BEGIN
  SELECT 
  CustomerID AS [NUMERO], 
     CompanyName AS [CLIENTE],
     City AS [CIUDAD],
     Country AS [PAIS]
     FROM customers
     WHERE CustomerID = TRIM (@Id);
 END
 ELSE
 BEGIN 
     PRINT 'No Existe'
 END
 END;


 EXEC spu_cliente_consultarporid2 @Id = 'ANTON';
 EXEC spu_cliente_consultarporid2  'NATAL';


 ----FORMA DE IMPRIMIR 2---------
 DECLARE @Id2 AS CHAR (10)= (SELECT CustomerID FROM customers WHERE CustomerID = 'ANTON');
 EXEC spu_cliente_consultarporid2 @Id2;

   ----FORMA DE IMPRIMIR 3---------
 DECLARE @id3 CHAR (10);
 SELECT @id3 = (SELECT CustomerID FROM customers WHERE CustomerID = 'ANTON');
 EXEC spu_cliente_consultarporid2 @Id3;


3. Parametros OUTPUT 
Parametro de salida

4. Lógica de SP
Puedes usar: 
-IF
-IF / ELSE
-WHILE
-VARIABLES
-CASE


6.- MANEJO DE ERRORES

SINTAXIS
 begin try
   --codigo que muede generar error 
 end try
 begin CATH
 