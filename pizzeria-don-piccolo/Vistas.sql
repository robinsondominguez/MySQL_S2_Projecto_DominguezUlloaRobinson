-- Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado)

Create view ResumenCliente AS Select c.Id_Cliente,per.Nombre AS Nombre_Cliente, COUNT(p.Id_Pedidos) AS Cantidad_Pedidos, SUM(p.Total_Pedido) AS Total_Gastado From Pedidos p
Join Cliente c ON p.Id_Cliente = c.Id_Cliente
Join Persona per ON c.Id_Persona = per.Id_Persona
GROUP BY c.Id_Cliente, per.Nombre;

SELECT * FROM ResumenCliente;

-- Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).

Create view VistaDesempenoRepartidores AS
Select r.Id_Repartidor, per.Nombre AS Repartidor, COUNT(d.Id_Domicilios) AS Total_Entregas, AVG(TIMESTAMPDIFF(MINUTE, d.Hora_Salida, d.Hora_Entrega)) AS Tiempo_Promedio_Minutos, z.Nombre_Zona AS Zona
From Domicilios d
Join Repartidor r ON d.Id_Repartidor = r.Id_Repartidor
Join Persona per ON r.Id_Persona = per.Id_Persona
Join Pedidos p ON d.Id_Pedido = p.Id_Pedidos
Join Zona z ON p.Id_Zona = z.Id_Zona
GROUP BY r.Id_Repartidor, per.Nombre, z.Nombre_Zona;

Select * from VistaDesempenoRepartidores;

-- Vista de stock de ingredientes por debajo del mínimo permitido.

Create view StockBajo AS 
Select * From Ingrediente Where Stock_Ingrediente <= Alert_Stock;

Select * from StockBajo;
Select * from Ingrediente;
Update Ingrediente Set Stock_Ingrediente = 20 Where Identificador_Ingrediente = 1
Limit 1;