#Stored Procedure

##Fundamentos

1.- ¿Qué es un Stored Procedure?
    Es un bloque de código SQL duardado dentor de la base de datos (**un objeto de la BD**) 
    que puede ejecutarse cuando se necesite 

    Es similar a una funcion o método en prpgramacion:
     
     Ventajas:
     1. Reutilización de código
     2. Mejor Rendimiento
     3. Se puede tener mayor seguridad (Evita la Inyección de SQL)
     4. Centralización de la lógica del Negocio
     5. Menos tráfico entre la aplicación y el servidor
     
     ''''''sql
CREATE PROC ups_objeto_accion
[Parametros]
AS 
BEGIN
 ---Body
 END;

 '''

 2.- Parametros en Stored Procedure
 Los parametros permiten enviar datos a los sp



#STORED PRODCEDURES CON INSERT, UPDATE, Y DELATE

-Create (Insert)
-Read(Select)
-Update (Update)
-Delate (Delate)

/*========================================*/

