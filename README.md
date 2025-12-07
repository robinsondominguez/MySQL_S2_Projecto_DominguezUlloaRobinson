## Proyecto MySQL
### Estudiante: Robinson Dominguez Ulloa
### Grupo: S2
## Profesor: **David Dominguez**


--------------------------------------------------------------------

# Objetivo del proyecto
El objtetivo del proyecto es entregar a la empreza Pizzeria-don-Piccolo, un base de datos para organizar, atender y Mejorar la eficacia con la que este hace los pedidos, La **Razon** para que esta empreza pidiera esto es por que lo hacia todo manualmente, por obvias razones esto les generaba varios retrazos en todos los sentidos, y cansados de esto y necesitan estar existiendo para el futuro, la empreza decidio optar por un base de datos, MySQL fue el codigo que utilizaron, por ser sencillo y facil de mantener.


--------------------------------------------------------------------

## Requisitos
Los requisitos que necesitaban la empreza pizzera son los siguiente:

- Registrar clientes, vendedores y repartidores.
- Registrar pizzas y sus ingredientes, controlando el stock automáticamente.
- Gestionar pedidos, domicilios y pagos.
- Consultar información relevante para la toma de decisiones.

Todos estos requisitos se tuvieron que establecer en la base de datos en el tipo codigo MySQL.

--------------------------------------------------------------------

## Modelo Logico de la base de datos.



--------------------------------------------------------------------

## Explicación del Modelo Lógico:
El modelo lógico representa cómo se organizan los datos y las relaciones entre ellos en la base de datos:

- Cada Persona puede ser un cliente, un vendedor o un repartidor.
- Los Clientes hacen pedidos, y los Vendedores los registran.
- Cada Pedido puede incluir varias Pizzas a través de Detalle_Pedido, donde se calcula el subtotal e IVA.
- Las Pizzas están compuestas por Ingredientes, controlando automáticamente el stock.
- Los Domicilios registran la entrega de pedidos por repartidor, calculando distancia y costo de envío.
- Se mantiene un Historial de Precios para auditar cambios de precio de las pizzas.
- El modelo lógico garantiza integridad de datos, consistencia de relaciones y facilita consultas y reportes.

--------------------------------------------------------------------

## Tablas y Relaciones
Persona: almacena información básica de cualquier persona en el sistema.
Cliente y Vendedor: heredan de Persona.
Zona: almacena zonas geográficas y el precio por metro.
Repartidor: hereda de Persona, con zona y estado.
Pizza: nombre, tamaño, tipo y precio base.
Ingrediente: nombre, stock, precio, unidad de medida y nivel mínimo.
Pizza_Ingredientes: relación entre pizzas y sus ingredientes.
Pedido: registro completo de pedidos.
Detalle_Pedido: qué pizzas y cuántas se pidieron por pedido.
Domicilio: hora de salida, entrega, distancia y costo de envío.
Historial_Precios: registra cambios en los precios de pizzas.

--------------------------------------------------------------------

## Funciones:

- Funcion Para Calcular las Ganancias Neta Diarias,
- Total de ventas,
- Total de costos de ingredientes usados en pizzas vendidas;

Procedimientos:
- Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.

### Consultas:

Consultar pedidos entre fechas.
Listar pizzas más vendidas.
Consultar pedidos por repartidor.
Calcular promedio de entrega por zona.
Buscar clientes que gastaron más de cierto monto.
Buscar pizzas por coincidencia parcial de nombre.
Identificar clientes frecuentes (más de 5 pedidos en el mes).

--------------------------------------------------------------------

## Uso del Sistema

Crear la base de datos y tablas.
Insertar los datos iniciales (clientes, repartidores, pizzas, ingredientes, pedidos).
Los triggers automatizan cálculos y control de stock.
Ejecutar consultas o procedimientos para reportes.
Actualizar precios de pizzas; el historial se registra automáticamente.
