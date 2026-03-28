Una subconsulta es una consulta anidada dentro de otra consulta que permite resolver problemas en varios niveles de informacion.

Dependiendo de donde se coloque y que retorne, cambia su comportamiento

**Clasificacion**

1. Subconsultas escalares
2. Subconsultas con IN, ANY, ALL.
3. Subconsultas relacionadas
4. Subconsultas en select
5. Subconsultas en FROM (se le llaman tablas derivadas)

##Escalares
Devuleve un unico valor, es por ello que se puede utilizar con operadores =,<,Ejemplo
'''sql
'''SELECT * 
FROM perdidos
WHERE total = (SELECT
MAX (total) FROM perdidos);

Orden de ejecucionj 
1. Se ejecuta la subconsulta
2. Devuelve los 1500
3. La consulta principal ocupa ese valor 

##  Subconsultas de una columna (   IN, ANY, ALL)


**IINSTRUCCION ANY**
>Compara un valor de una **Lista**. La condicion se cumple si al menos uno se cumple.


'''sql
valor > ANY  (subconsulta)

Es como decir
"Mayor que al menos uno de los valores"
Devuelve varios pero una columna 

