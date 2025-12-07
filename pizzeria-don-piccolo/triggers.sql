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
Select * from Ingrediente;

-- Segundo Trigger

Delimiter //
Create Trigger UpdateEstado
AFTER UPDATE ON Domicilios
FOR EACH ROW
BEGIN
    IF OLD.Hora_Entrega IS NULL AND NEW.Hora_Entrega IS NOT NULL THEN
        UPDATE Repartidor
        SET Estado_Repartidor = 'Disponible'
        WHERE Id_Repartidor = NEW.Id_Repartidor;
    END IF;
END//
DELIMITER ;

Update Domicilios
SET Hora_Entrega = NOW()
WHERE Id_Domicilios = 3;
-- Tercer Trigger

DELIMITER //

Delimiter //

Create Trigger RegistrozPizzas
BEFORE UPDATE ON Pizza
FOR EACH ROW
BEGIN

    IF OLD.Precio_Base <> NEW.Precio_Base THEN
        INSERT INTO historial_precios (Id_Pizza, Viejo_Precio, Nuevo_Precio, Fecha_Cambio)
        VALUES (OLD.Id_Pizza, OLD.Precio_Base, NEW.Precio_Base, NOW());
    END IF;
END //

DELIMITER ;

Select * from Pizza;
UPDATE Pizza 
SET Precio_Base = 21500 
WHERE Id_Pizza = 3;
SELECT * FROM historial_precios;


Select * From ( Select c.Id_Cliente, per.Nombre, COUNT(p.Id_Pedidos) AS Mas_Pedidos From Pedidos p 
Join Cliente c ON p.Id_Cliente = c.Id_ClienteJoin Persona per ON c.Id_Persona = per.Id_Persona
Where MONTH(p.Fecha_Hora) = 12 GROUP BY c.Id_Cliente, per.Nombre) AS HistorialPedidos
Where HistorialPedidos.Mas_Pedidos > 5;