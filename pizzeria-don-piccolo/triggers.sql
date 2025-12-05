-- Primer Trigger
Delimiter //

Create Trigger StockUpdate
AFTER INSERT ON detalle_Pedido
FOR EACH ROW
BEGIN
    Update Ingrediente i
    Join detalle_pizza dp ON i.Id_Ingrediente = dp.Id_Ingrediente
    Set i.Stock_Ingrediente = i.Stock_Ingrediente - NEW.Cantidad
    Where dp.Id_Pizza = NEW.Id_Pizza;
END //

DELIMITER ;

INSERT INTO detalle_Pedido (Id_Pedido, Id_Pizza, Cantidad)
VALUES (1, 2, 2);

-- Segundo Trigger

DELIMITER //
CREATE TRIGGER UpdateEstado
AFTER UPDATE ON Domicilios
FOR EACH ROW
BEGIN
    -- Si el pedido pasó a "Entregado"
    IF OLD.Hora_Entrega IS NULL AND NEW.Hora_Entrega IS NOT NULL THEN
        UPDATE Repartidor
        SET Estado_Repartidor = 'Disponible'
        WHERE Id_Repartidor = NEW.Id_Repartidor;
    END IF;
END//
DELIMITER ;

UPDATE Domicilios
SET Hora_Entrega = NOW()
WHERE Id_Domicilios = 3;
-- Tercer Trigger