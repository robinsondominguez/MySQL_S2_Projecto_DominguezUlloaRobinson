--Creacion de Funciones

--Funcion Para Calcular El Total de un Pedido

Delimiter //

Create Function CalcularPedido (V_Id_Pedido INT)
returns Double
Reads SQL Data
Deterministic
begin

DECLARE V_Precio_Base Double default 0;
DECLARE V_Costo_Envio Double default 0;
DECLARE V_Total Double;
DECLARE IVA Double default 0.19;


-- Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).

Select p.Total_Pedido, IfNull (d.Costo_Envio, 0) Into V_Precio_Base, V_Costo_Envio from Pedidos p
Left Join Domicilios d ON p.Id_Pedidos = d.Id_Pedido Where p.Id_Pedidos = V_Id_Pedido;

Set V_Total = (V_Precio_Base + V_Costo_Envio) * (1 + IVA);


Return V_Total;
End //

Delimiter ;

--Funcion Para Calcular las Ganancias Neta Diarias

Delimiter //

Create Function GananciasNeta (BusquedaFecha DATE)
returns Double
Reads SQL Data
Deterministic

begin

DECLARE V_Id_Ventas Double;
DECLARE V_Costo_Ingredientes Double;

-- Total de ventas

Select IfNull(SUM(dp.Cantidad * dp.Precio_Unitario), 0) Into V_Ventas from Pedidos p Join Detalle_Pedido dp ON p.Id_Pedidos = dp.Id_Pedido WHERE DATE(p.Fecha_Hora) = BusquedaFecha;

-- Total de costos de ingredientes usados en pizzas vendidas
Select IfNull(SUM(dp.Cantidad * i.Costo), 0) Into V_Costo_Ingredientes From Pedidos p
Join Detalle_Pedido dp ON p.Id_Pedidos = dp.Id_Pedido
Join detalle_pizza dpi ON dp.Id_Pizza = dpi.Id_Pizza
Join Ingrediente i ON dpi.Id_Ingrediente = i.Id_Ingrediente
Where DATE(p.Fecha_Hora) = BusquedaFecha;

Return V_Id_Ventas - V_Costo_Ingredientes;

End //

Delimiter ;

-- Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.