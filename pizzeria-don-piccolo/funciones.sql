--Creacion de Funciones

--Funcion Para Calcular El Total de un Pedido

Delimiter //

Create Function TotalPedido (V_Precio_Base INT)
Read SQL Data
Deterministic
returns Double

begin

Declare Id_Total_Pedido INT NOT NULL;
Declare V_Costo_Envio INT;
Declare V_IVA INT;

Select Costo_Envio into V_Costo_Envio From Gestion_Domicilios where Id_Gestion_Domicilios = Id_Total_Pedido;

Set SUM(V_Costo_Envio * 1.19)

