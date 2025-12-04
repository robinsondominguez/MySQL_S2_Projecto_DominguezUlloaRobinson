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

Create Function GananciasNeta (Ganancias INT)
Read SQL Data
Deterministic
returns Double

begin

DECLARE Id_Ventas INT NOT NULL;
DECLARE V_Costo_Ingredientes INT;

Select Costo_Envio into V_Costo_Envio From Gestion_Domicilios where Id_Gestion_Domicilios = Id_Total_Pedido;

Set SUM(V_Costo_Envio * 1.19)

End //

Delimiter ;

-- Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.