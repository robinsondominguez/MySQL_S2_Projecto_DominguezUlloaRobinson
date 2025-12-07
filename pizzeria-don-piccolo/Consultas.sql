-- Clientes con pedidos de dos fechas

Select distinct c.Id_Cliente, p.Nombre, p.Telefono, p.Correo From Cliente c
Join Persona p ON c.Id_Persona = p.Id_Persona
Join Pedidos pe ON c.Id_Cliente = pe.Id_Cliente
WHERE pe.Fecha_Hora BETWEEN '2024-01-01' AND '2024-12-31';

-- Cantidad de Pizzas vendidas

Select p.Id_Pizza, p.Nombre_Pizza, SUM(dp.Cantidad) AS Total_Vendido From Detalle_Pedido dp
Join Pizza p ON dp.Id_Pizza = p.Id_Pizza
GROUP BY p.Id_Pizza, p.Nombre_Pizza
ORDER BY Total_Vendido DESC;

-- Pedidos por Repartidor

Select r.Id_Repartidor, pe.Nombre AS Nombre_Repartidor, COUNT(d.Id_Pedido) AS Total_Pedidos
From Repartidor r
Join Persona pe ON r.Id_Persona = pe.Id_Persona
Left Join Domicilios d ON r.Id_Repartidor = d.Id_Repartidor
GROUP BY r.Id_Repartidor, pe.Nombre
ORDER BY Total_Pedidos DESC;

-- Promedio de entrega por zona

Select  p.id_zona, AVG(TIMESTAMPDIFF(MINUTE, d.hora_salida, d.hora_entrega)) AS promedio_minutos
From domicilio d
JOin pedidos p ON d.id_pedido = p.id_pedido
GROUP BY p.id_zona;

-- Clientes que se gastaron de mas

Select c.Id_Cliente, SUM(p.Total_Pedido) AS TotalGastado
From Pedidos p
Join Cliente c ON p.Id_Cliente = c.Id_Cliente
GROUP BY c.Id_Cliente
HAVING SUM(p.Total_Pedido) > 28000;

-- Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
Select * From pizzas Where nombre LIKE 'NombreRamdom'; -- Dentro de los '' Coloquen el nombre.

-- Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).

Select c.Id_Cliente,  per.Nombre, COUNT(p.Id_Pedidos) AS Cant_Pedidos
From Pedidos p
Join Cliente c ON p.Id_Cliente = c.Id_Cliente
Join Persona per ON c.Id_Persona = per.Id_Persona
Where MONTH(p.Fecha_Hora) = 11
GROUP BY c.Id_Cliente, per.Nombre
HAVING COUNT(p.Id_Pedidos) > 5;

-- Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).

Select * From (Select c.Id_Cliente, per.Nombre, COUNT(p.Id_Pedidos) AS Mas_Pedidos From Pedidos p Join Cliente c ON p.Id_Cliente = c.Id_Cliente
    Join Persona per ON c.Id_Persona = per.Id_Persona
    Where MONTH(p.Fecha_Hora) = 11
GROUP BY c.Id_Cliente, per.Nombre) AS sub Where sub.Cant_Pedidos > 5;