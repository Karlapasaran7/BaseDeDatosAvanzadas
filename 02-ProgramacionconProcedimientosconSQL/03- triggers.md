# TRIGGERS (Disparadores)


## ¿Qué es un trigger? 
--Es un bloque de código SQL  que se ejecuta automaticamente cuando ocurre un evento en una tabla

1. Eventos

- Insert
- UPDATE
- DELATE

No se ejecutan manualmente, se ejecutan o activas solos

## SIRVEN PARA:
1. Validaciones
2. Auditoria (guardar historial)
3. Reglas de negocio
4. Automatización

## Tipos de triggers en sql server
- AFTER TRIGGER

se ejecuta despúes del evento

- INSTEAD OF

Este reemplaza la operación original

## SINTAXIS BÁSICA

'''SQL
CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER INSERT
AS
BEGIN
    --codigo
END;
'''
