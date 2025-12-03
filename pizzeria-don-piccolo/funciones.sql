--Creacion de Funciones

--Funcion Para Calcular El Total de un Pedido

Delimiter //

Create Function TotalPedido (V_Precio_Base INT)
Read SQL Data
Deterministic
returns Double

begin

DECLARE V_Costo_Envio INT NOT NULL;
DECLARE V_Subtotal_Pizza INT NOT NULL;
DECLARE V_Total_Precio INT NOT NULL; 

-- Obtener Precio Base de la pizza
Select Precio_Base into V_Precio_Base From Gestion_Pizza;

-- Obtener Costo Envio del Domicilio
Select Costo_Envio into V_Costo_Envio From Gestion_Domicilios;

-- Creando Procedimiento Matimatico (Suma)
Set V_Subtotal_Pizza = (V_Costo_Envio + V_Precio_Base);

-- Añadiendo El IVA
Set V_Total_Precio = (V_Subtotal_Pizza * 1.19);

returns V_Total_Precio

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