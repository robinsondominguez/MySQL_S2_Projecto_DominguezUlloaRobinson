-- Consulta de pedidos entregados en un rango de dos fechas

Select distinct c.Id_Cliente, p.Nombre From Cliente c
Join Persona p ON c.Id_Persona = p.Id_Persona
Join Pedidos pe ON c.Id_Cliente = pe.Id_Cliente
WHERE pe.Fecha_Pedido BETWEEN '2024-11-28' AND '2024-12-04';

-- Consulta de clientes frecuentes
Select * From (Select c.Id_Cliente, per.Nombre, COUNT(p.Id_Pedidos) AS Mas_Pedidos From Pedidos p Join Cliente c ON p.Id_Cliente = c.Id_Cliente
    Join Persona per ON c.Id_Persona = per.Id_Persona
    Where MONTH(p.Fecha_Pedido) = 12
GROUP BY c.Id_Cliente, per.Nombre) AS sub Where sub.Mas_Pedidos < 5;


-- Consulta de resumen de pedidos por método de pago

Select (p.Metodo_Pago, p.Total_Pedido COUNT(p.Id_Pedido) AS Cantidad_Pedidos from Pedidos p
Join Pedidos p ON p.Id_Pedido = p.Id_Pedido
Where Metodo_Pago = 'Efectivo'
GROUP BY p.Id_Pedido, p.Total_Pedido) AS Met_pago Where Met_pago = 'Efectivo';