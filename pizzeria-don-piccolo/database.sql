-- Creacion y Uso De la Base de Datos SI Este no existe
create database if not exists pizzeria_don_piccolo;
Use pizzeria_don_piccolo;

-- Comando para Dropear la base de datos (Drop = Eliminar)
drop database pizzeria_don_piccolo;

-- Creacion De la Tabla de Personas

create table Persona(
    Id_Persona INT PRIMARY KEY AUTO_INCREMENT,
    Nombre Varchar(80) NOT NULL,
    Telefono Varchar(80) NOT NULL,
    Direccion Varchar(80) NOT NULL,
    Correo Varchar(80) NOT NULL
);

-- Creacion de La tabla de Cliente, Como sus relaciones con la tabla cliente, Persona Y La relacion foranea

create table Cliente(
    Id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Id_Persona INT NOT NULL,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona) 
);

-- Creacion tabla Zona 

create table Zona(
    Id_Zona INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Zona Varchar(80) NOT NULL,
    Distancia_Aproximada Double NOT NULL
);


-- Creacion de la Tabla de Pizzas

create table Pizza(
    Id_Pizza INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Pizza Varchar(80),
    Precio_Base Double,
    Tamaño_Pizza Enum('Grande', 'Mediano', 'Pequeño'),  -- Solo 3 opciones disponibles (Tampoco que quieras comer un tamaño elefante verdad?)
    Tipo_Pizza Enum('Vegetariana', 'Especial', 'Clasica') -- Solo 3 opciones para todo tipo de Clientes
);

create table Ingrediente(
    Id_Ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    Identificador_Ingrediente INT, -- El numero en lo cual se identificara el ingrediente EJEM: 1 - Peperoni, 2 - Aguacate, 3 - Lengua de Vaca
    Nombre_Ingrediente Varchar(80) NOT NULL, -- Este Atributo es Complementario para el Atributo anterior, para poder poner el nombre.
    Stock_Ingrediente INT, -- EL que define cuantos hay de este tipo de ingrediente.
    Alert_Stock INT,
    Costo Double NOT NULL
);

-- Creacion de la tabla de los detalle de la pizza.

create table detalle_pizza (
    Id_Pizza INT, -- Id de la tabla de la pizza
    Id_Ingrediente INT, -- Id de la tabla de Ingrediente
    PRIMARY KEY (Id_Pizza, Id_Ingrediente), -- La llave primaria compuesta, esta permite que no se presente la misma tipa con el mismo Ingrediente.
    FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza), -- Relacion A la tabla Pizza
    FOREIGN KEY (Id_Ingrediente) REFERENCES Ingrediente(Id_Ingrediente) -- Relacion A la tabla Ingrediente
);

-- Creacion de la tabla de los repartidores

create table Repartidor(
    Id_Repartidor INT PRIMARY KEY AUTO_INCREMENT,
    Id_Persona INT NOT NULL, -- La persona que hizo el pedido
    Estado_Repartidor Enum('Disponible', 'No Disponible') NOT NULL default 'Disponible', -- Unicamente 2 opciones disponibles del estado del conductor, predeterminamente estara en Disponible.
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona) -- Relacion con la tabla Persona
);

-- Creacion de la tabla de Pedidos

create table Pedidos(
    Id_Pedidos INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Hora DATETIME, -- Obtiene la Fecha y hora del pedido
    Metodo_Pago Enum('Efectivo', 'Tarjeta', 'App'), -- Solo 3 opciones disponibles para realizar el pago
    Estado Enum('Pendiente', 'En Preparacion', 'Entregado', 'Cancelado'), -- Solo 3 opciones disponibles Que puede tener la pizza, para que no pongan (En crecimiento)
    Id_Cliente INT NOT NULL, -- El cliente que haya realizado el pedido
    Id_Repartidor INT, -- Referencia a la tabla Repartidor
    Id_Zona INT, -- Zona de entrega que se asigno
    Total_Pedido Double NOT NULL, -- Total del pedido de la pizza con la zona destinada
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(id_Cliente), -- Relacion con la tabla Cliente
    FOREIGN KEY (Id_Zona) REFERENCES Zona(Id_Zona), -- Relacion Con la tabla Zona
    FOREIGN KEY (Id_Repartidor) REFERENCES Repartidor(Id_Repartidor) -- Relacion a la tabla Repartidor
);

create table detalle_Pedido (
    Id_Detalle INT PRIMARY KEY AUTO_INCREMENT,
    Id_Pedido INT NOT NULL,
    Id_Pizza INT NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    Precio_Unitario DOUBLE NOT NULL Default 0,
    FOREIGN KEY (Id_Pedido) REFERENCES Pedidos(Id_Pedidos),
    FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza)
);

-- Creacion de la tabla Domicilios

create table Domicilios(
    Id_Domicilios INT PRIMARY KEY AUTO_INCREMENT,
    Hora_Salida DATETIME, -- Obtiene la hora de salida
    Hora_Entrega DATETIME, -- Obtiene la hora de Entrega
    Costo_Envio Double NOT NULL, -- Obtiene el Costo del Envio
    Id_Repartidor INT, -- El id del repartidor asignado
    Id_Pedido INT, -- El id del pedido Realizado
    Id_Cliente INT, -- El id del cliente Que pidio el Domicilio
    -- Las relaciones con su respectiva tabla
    FOREIGN KEY (Id_Repartidor) REFERENCES Repartidor(Id_Repartidor),
    FOREIGN KEY (Id_Pedido) REFERENCES Pedidos(Id_Pedidos),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

create table historial_precios (
    Id_Historial INT AUTO_INCREMENT PRIMARY KEY,
    Id_Pizza INT NOT NULL,
    Precio_Anterior DOUBLE NOT NULL,
    Precio_Nuevo DOUBLE NOT NULL,
    Fecha_Cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza)
);


-----------------------------------------------------------------------------------------------------------------------------------------

-- Insertacion de Data


-- Personas
INSERT INTO Persona (Nombre, Telefono, Direccion, Correo) VALUES
('Juan Perez', '3001234567', 'Calle 10 #20-30', 'juan.perez@example.com'),     
('Maria Lopez', '3002345678', 'Calle 11 #21-31', 'maria.lopez@example.com'),   
('Carlos Gomez', '3003456789', 'Calle 12 #22-32', 'carlos.gomez@example.com'), 
('Ana Torres', '3004567890', 'Calle 13 #23-33', 'ana.torres@example.com'),     
('Luis Ramirez', '3005678901', 'Calle 14 #24-34', 'luis.ramirez@example.com'), 

-- Repartidores

('Sofia Martinez', '3101112233', 'Calle 15 #25-35', 'sofia.martinez@example.com'), 
('Pedro Castillo', '3102223344', 'Calle 16 #26-36', 'pedro.castillo@example.com'), 
('Laura Fernandez', '3103334455', 'Calle 17 #27-37', 'laura.fernandez@example.com'), 
('Daniel Ruiz', '3104445566', 'Calle 18 #28-38', 'daniel.ruiz@example.com'),       
('Carolina Silva', '3105556677', 'Calle 19 #29-39', 'carolina.silva@example.com');


-- Clientes
INSERT INTO Cliente (Id_Persona) VALUES
(1),(2),(3),(4),(5);

-- Repartidores
INSERT INTO Repartidor (Id_Persona, Estado_Repartidor) VALUES
(6, 'Disponible'),
(7, 'Disponible'),
(8, 'No Disponible'),
(9, 'No Disponible'),
(10, 'Disponible');

-- Ingredientes
INSERT INTO Ingrediente (Identificador_Ingrediente, Nombre_Ingrediente, Stock_Ingrediente, Alert_Stock, Costo) VALUES
(1, 'Pepperoni', 50, 25, 6000),
(2, 'Queso Mozzarella', 40, 15, 5000),
(3, 'Champiñones', 30, 20, 4000),
(4, 'Tocineta', 25, 10, 7000),
(5, 'Piña', 20, 5, 3000);

-- Pizzas
INSERT INTO Pizza (Nombre_Pizza, Precio_Base, Tamaño_Pizza, Tipo_Pizza) VALUES
('Hawaiana', 25000, 'Grande', 'Clasica'),
('Pepperoni', 27000, 'Mediano', 'Especial'),
('Vegetariana', 23000, 'Grande', 'Vegetariana'),
('Mexicana', 30000, 'Pequeño', 'Especial'),
('Cuatro Quesos', 28000, 'Grande', 'Clasica');

-- detalle Pizza

INSERT INTO detalle_pizza (Id_Pizza, Id_Ingrediente) VALUES
(1,5),
(1,2),
(2,1),
(2,2),
(3,3),
(3,2),
(4,4),
(4,1),
(5,2),
(5,4);

-- Zonas 
INSERT INTO Zona (Nombre_Zona, Distancia_Aproximada) VALUES
('Norte', 5.2),
('Sur', 8.7),
('Centro', 2.1);

-- Pedidos
INSERT INTO Pedidos (Fecha_Hora, Metodo_Pago, Estado, Id_Cliente, Id_Zona, Total_Pedido) VALUES
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 3, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 2, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 1, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 3, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 2, 25000),
('2024-12-05 21:00:00', 'App', 'Pendiente', 1, 2, 25000),
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 3, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 2, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 1, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 3, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 2, 25000),
('2024-12-05 21:00:00', 'App', 'Pendiente', 1, 2, 25000),
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 3, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 2, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 1, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 3, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 2, 25000),
('2024-12-05 21:00:00', 'App', 'Pendiente', 1, 2, 25000),
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 3, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 2, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 1, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 3, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 2, 25000),
('2024-12-05 21:00:00', 'App', 'Pendiente', 1, 2, 25000);

-- Detalle_Pedido

INSERT INTO Detalle_Pedido (Id_Pedido, Id_Pizza, Cantidad, Precio_Unitario) VALUES
(1, 1, 2, 25000), 
(1, 3, 1, 20000),
(2, 2, 1, 28000),
(3, 4, 3, 15000),
(4, 5, 2, 22000),
(5, 1, 1, 25000);

-- Domicilios
INSERT INTO Domicilios (Hora_Salida, Hora_Entrega, Costo_Envio, Id_Repartidor, Id_Pedido, Id_Cliente) VALUES
('2024-11-28 14:10:00', '2024-11-21 14:40:00', 5000, 1, 1, 1),
('2024-11-29 15:20:00', '2024-11-22 15:50:00', 4500, 2, 2, 2),
('2024-11-30 16:45:00', '2024-11-23 17:20:00', 6500, 3, 3, 3),
('2024-11-30 17:25:00', '2024-11-24 17:55:00', 6000, 4, 4, 4),
('2024-11-30 18:15:00', '2024-11-25 18:45:00', 5500, 2, 5, 5),
('2024-11-30 18:15:00', '2024-11-25 18:45:00', 5500, 2, 1, 1),
('2024-11-30 18:15:00', '2024-11-25 18:45:00', 5500, 3, 3, 1),
('2024-11-30 18:15:00', '2024-11-25 18:45:00', 5500, 2, 4, 2);