-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE bdVentasSP;
GO

--USO DE BASE DE DATOS
USE bdVentasSP;
GO

-- CREACIÓN DE LA TABLA PRODUCTO DESDE NORTHWND

SELECT 
    ProductID,
    ProductName,
    UnitPrice,
    UnitsInStock
INTO Producto
FROM NORTHWND.dbo.Products;
GO

ALTER TABLE Producto
ADD CONSTRAINT pk_producto PRIMARY KEY (ProductID);
GO


-- CREACIÓN DE LA TABLA CLIENTE DESDE NORTHWND

SELECT
    CustomerID,
    CompanyName,
    Country,
    City
INTO Cliente
FROM NORTHWND.dbo.Customers;
GO

ALTER TABLE Cliente
ADD CONSTRAINT pk_cliente PRIMARY KEY (CustomerID);
GO


-- CREACIÓN DE LA TABLA VENTA

CREATE TABLE Venta(
    idVenta INT IDENTITY(1,1) PRIMARY KEY,
    fechaVenta DATE NOT NULL,
    cliente_id NCHAR(5) NOT NULL,

    CONSTRAINT fk_ventas_clientes
    FOREIGN KEY (cliente_id)
    REFERENCES Cliente(CustomerID)
);
GO


-- CREACIÓN DE LA TABLA DETALLEVENTA
CREATE TABLE DetalleVenta(
    idVenta INT NOT NULL,
    idProducto INT NOT NULL,
    PrecioVenta MONEY NOT NULL,
    Cantidad INT NOT NULL,

    CONSTRAINT pk_detalle PRIMARY KEY(idVenta, idProducto),

    CONSTRAINT fk_detalle_producto
    FOREIGN KEY (idProducto)
    REFERENCES Producto(ProductID),

    CONSTRAINT fk_detalle_venta
    FOREIGN KEY (idVenta)
    REFERENCES Venta(idVenta)
);
GO


-- STORE PROCEDURE: REGISTRAR VENTA
CREATE OR ALTER PROC ups_registro_Venta
    @idCliente NCHAR(5),
    @idProducto INT,
    @cantidad INT
AS
BEGIN
    -- Evita mensajes automáticos innecesarios
    SET NOCOUNT ON;

    BEGIN TRY
        -- Inicia la transacción
        BEGIN TRAN;

        -- Declaración de variables
        DECLARE @idVenta INT;
        DECLARE @stock INT;
        DECLARE @precio MONEY;

        ------------------------1. VALIDAR QUE LA CANTIDAD SEA MAYOR A CERO----------------------------
        IF @cantidad <= 0
        BEGIN
            PRINT 'La cantidad debe ser mayor a cero.';
            ROLLBACK;
            RETURN;
        END

        -------------------2. VERIFICAR SI EL CLIENTE EXISTE-----------------------------
        IF NOT EXISTS (
            SELECT 1
            FROM Cliente
            WHERE CustomerID = @idCliente
        )
        BEGIN
            PRINT 'Cliente no encontrado.';
            ROLLBACK;
            RETURN;
        END

        ------------------------ 3. VERIFICAR SI EL PRODUCTO EXISTE--------------------------------
        IF NOT EXISTS (
            SELECT 1
            FROM Producto
            WHERE ProductID = @idProducto
        )
        BEGIN
            PRINT 'Producto no encontrado.';
            ROLLBACK;
            RETURN;
        END

        ------------------------4. OBTENER EL PRECIO ACTUAL Y EL STOCK DEL PRODUCTO-----------------------------------
        SELECT 
            @precio = UnitPrice,
            @stock = UnitsInStock
        FROM Producto
        WHERE ProductID = @idProducto;

        -------------------------5. VALIDAR EXISTENCIA SUFICIENTE----------------------------------
        IF @stock < @cantidad
        BEGIN
            PRINT 'Stock insuficiente para la venta.';
            ROLLBACK;
            RETURN;
        END

        ----------------------- 6. INSERTAR LA VENTA------------------------------------
        --    Incluye la fecha actual y el clientE
        INSERT INTO Venta(fechaVenta, cliente_id)
        VALUES (GETDATE(), @idCliente);

        ----------------------------7. OBTENER EL ID DE LA VENTA GENERADA------------------------------
        SET @idVenta = SCOPE_IDENTITY();

        ---------------------------8. INSERTAR EL DETALLE DE VENTA--------------------------------
        --    Solo se registra un producto
        INSERT INTO DetalleVenta(idVenta, idProducto, PrecioVenta, Cantidad)
        VALUES 
        (@idVenta, @idProducto, @precio, @cantidad);

        ----------------------------9. ACTUALIZAR LA EXISTENCIA DEL PRODUCTO-------------------------------
        SET UnitsInStock = UnitsInStock - @cantidad
        WHERE ProductID = @idProducto;

        ------------------------------10. CONFIRMAR LA TRANSACCIÓN----------------------------- 
        COMMIT;

        PRINT 'Venta registrada correctamente.';
    END TRY

    BEGIN CATCH
     
        -- SI HAY ERROR, SE CANCELA TODO
        
        IF @@TRANCOUNT > 0
            ROLLBACK;

        PRINT 'Error detectado: ' + ERROR_MESSAGE();
    END CATCH
END;
GO


-- PRUEBAS DE EJECUCIÓN

-- 1. Venta correcta
EXEC ups_registro_Venta @idCliente = 'ALFKI', @idProducto = 2, @cantidad = 3;

-- 2. Producto inexistente
EXEC ups_registro_Venta @idCliente = 'ALFKI', @idProducto = 9999, @cantidad = 3;

-- 3. Stock insuficiente
EXEC ups_registro_Venta @idCliente = 'ALFKI', @idProducto = 2, @cantidad = 9999;

-- 4. Cliente inexistente
EXEC ups_registro_Venta @idCliente = 'ZZZZZ', @idProducto = 2, @cantidad = 3;

-- 5. Cantidad inválida
EXEC ups_registro_Venta @idCliente = 'ALFKI', @idProducto = 2, @cantidad = 0;
GO

-- CONSULTAS PARA REVISAR RESULTADOS

SELECT * FROM Producto;
SELECT * FROM Cliente;
SELECT * FROM Venta;
SELECT * FROM DetalleVenta;
GO


-- TRIGGER: EVITAR CAMBIO DE PRECIOVENTA

CREATE OR ALTER TRIGGER trg_NoCambiarPrecioVenta
ON DetalleVenta
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Si en el UPDATE se intentó modificar la columna PrecioVenta
    IF UPDATE(PrecioVenta)
    BEGIN
        -- la tabla deleted (valor anterior) con inserted (valor nuevo)
        IF EXISTS (
            SELECT 1
            FROM inserted i
            INNER JOIN deleted d
                ON i.idVenta = d.idVenta
               AND i.idProducto = d.idProducto
            WHERE ISNULL(i.PrecioVenta, 0) <> ISNULL(d.PrecioVenta, 0)
        )
        BEGIN
            RAISERROR('No se permite cambiar el precio de venta en la tabla DetalleVenta.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END
END;
GO

SELECT *
FROM DetalleVenta
WHERE idVenta = 1
  AND idProducto = 2;
  GO