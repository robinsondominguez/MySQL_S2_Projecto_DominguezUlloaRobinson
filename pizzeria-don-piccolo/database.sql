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

-- Creacion de la Tabla de Pizzas

create table Pizza(
    Id_Pizza INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Pizza Varchar(80),
    Tamaño_Pizza Enum('Grande', 'Mediano', 'Pequeño'),  -- Solo 3 opciones disponibles (Tampoco que quieras comer un tamaño elefante verdad?)
    Tipo_Pizza Enum('Vegetariana', 'Especial', 'Clasica') -- Solo 3 opciones para todo tipo de Clientes
);

create table Ingrediente(
    Id_Ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    Identificador_Ingrediente INT, -- El numero en lo cual se identificara el ingrediente EJEM: 1 - Peperoni, 2 - Aguacate, 3 - Lengua de Vaca
    Nombre_Ingrediente Varchar(80) NOT NULL, -- Este Atributo es Complementario para el Atributo anterior, para poder poner el nombre.
    Stock_Ingrediente INT, -- EL que define cuantos hay de este tipo de ingrediente.
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

-- Creacion tabla Zona 

create table Zona(
    Id_Zona INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Zona Varchar(80) NOT NULL,
    Distancia_Aproximada Double NOT NULL
);

-- Creacion de la tabla de Pedidos

create table Pedidos(
    Id_Pedidos INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Hora DATETIME, -- Obtiene la Fecha y hora del pedido
    Metodo_Pago Enum('Efectivo', 'Tarjeta', 'App'), -- Solo 3 opciones disponibles para realizar el pago
    Estado Enum('Pendiente', 'En Preparacion', 'Entregado', 'Cancelado'), -- Solo 3 opciones disponibles Que puede tener la pizza, para que no pongan (En crecimiento)
    Id_Cliente INT NOT NULL, -- El cliente que haya realizado el pedido
    Id_Zona INT, -- Zona de entrega que se asigno
    Total_Pedido Double NOT NULL, -- Total del pedido de la pizza con la zona destinada
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(id_Cliente), -- Relacion con la tabla Cliente
    FOREIGN KEY (Id_Zona) REFERENCES Zona(Id_Zona) -- Relacion Con la tabla Zona
);

-- Creacion de la tabla de los repartidores

create table Repartidor(
    Id_Repartidor INT PRIMARY KEY AUTO_INCREMENT,
    Id_Persona INT NOT NULL, -- La persona que hizo el pedido
    Estado_Repartidor Enum('Disponible', 'No Disponible') NOT NULL default 'Disponible', -- Unicamente 2 opciones disponibles del estado del conductor, predeterminamente estara en Disponible.
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona) -- Relacion con la tabla Persona
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

-----------------------------------------------------------------------------------------------------------------------------------------

-- Insertacion de Data

-- Personas
INSERT INTO Persona (Nombre, Telefono, Direccion, Correo) VALUES
('Juan Perez', '555-1234', 'Calle Falsa 123', 'juan.perez@email.com'),
('Maria Lopez', '555-5678', 'Av. Siempre Viva 742', 'maria.lopez@email.com'),
('Carlos Gomez', '555-9012', 'Calle Luna 45', 'carlos.gomez@email.com'),
('Ana Torres', '555-3456', 'Av. Sol 98', 'ana.torres@email.com'),
('Luis Ramirez', '555-7890', 'Calle Estrella 12', 'luis.ramirez@email.com'),
('Sofia Martinez', '555-2345', 'Av. Mar 77', 'sofia.martinez@email.com'),
('Pedro Castillo', '555-6789', 'Calle Rio 55', 'pedro.castillo@email.com'),
('Laura Fernandez', '555-0123', 'Av. Nube 33', 'laura.fernandez@email.com');

-- Clientes
INSERT INTO Cliente (Id_Persona) VALUES
(1), (2), (3), (4);

-- Repartidores
INSERT INTO Repartidor (Id_Persona, Estado_Repartidor) VALUES
(5, 'Disponible'),
(6, 'Disponible'),
(7, 'No Disponible'),
(8, 'Disponible');

-- Ingredientes
INSERT INTO Ingrediente (Identificador_Ingrediente, Nombre_Ingrediente, Stock_Ingrediente, Costo) VALUES
(1, 'Queso', 50, 5.0),
(2, 'Jamón', 40, 6.0),
(3, 'Pepperoni', 30, 7.0),
(4, 'Champiñones', 25, 4.0),
(5, 'Piña', 20, 3.5),
(6, 'Aceitunas', 35, 4.5),
(7, 'Cebolla', 40, 3.0),
(8, 'Pimiento', 30, 3.5),
(9, 'Otros', 40, 10.0);

-- Pizzas
INSERT INTO Pizza (Nombre_Pizza, Tamaño_Pizza, Tipo_Pizza) VALUES
('Margarita', 'Mediano', 'Clasica'),
('Hawaiana', 'Grande', 'Especial'),
('Vegetariana', 'Mediano', 'Vegetariana'),
('Pepperoni', 'Grande', 'Especial'),
('Cuatro Quesos', 'Pequeño', 'Especial');

-- Margarita
INSERT INTO detalle_pizza (Id_Pizza, Id_Ingrediente) VALUES
(1,1),(1,7);

-- Hawaiana
INSERT INTO detalle_pizza (Id_Pizza, Id_Ingrediente) VALUES
(2,1),(2,2),(2,5);

-- Vegetariana
INSERT INTO detalle_pizza (Id_Pizza, Id_Ingrediente) VALUES
(3,1),(3,4),(3,6),(3,7),(3,8);

-- Pepperoni
INSERT INTO detalle_pizza (Id_Pizza, Id_Ingrediente) VALUES
(4,1),(4,3);

-- Cuatro Quesos
INSERT INTO detalle_pizza (Id_Pizza, Id_Ingrediente) VALUES
(5,1),(5,5),(5,6),(5,4); -- supondremos que 9,10,11 son otros quesos

-- Zonas 
INSERT INTO Zona (Nombre_Zona, Distancia_Aproximada) VALUES
('Centro', 2.5),
('Norte', 5.0),
('Sur', 7.2),
('Este', 4.8),
('Oeste', 6.3);

-- Pedidos
INSERT INTO Pedidos (Fecha_Hora, Metodo_Pago, Estado, Id_Cliente, Id_Zona, Total_Pedido) VALUES
('2025-12-03 12:00:00','Efectivo','Pendiente',1,1,15.0),
('2025-12-03 12:15:00','Tarjeta','En Preparacion',2,2,22.0),
('2025-12-03 12:30:00','App','Entregado',3,3,18.5),
('2025-12-03 12:45:00','Efectivo','Pendiente',4,4,25.0),
('2025-12-03 13:00:00','Tarjeta','Cancelado',1,5,20.0);

-- Domicilios
INSERT INTO Domicilios (Hora_Salida, Hora_Entrega, Costo_Envio, Id_Repartidor, Id_Pedido, Id_Cliente) VALUES
('2025-12-03 12:05:00','2025-12-03 12:30:00',3.5,1,1,1),
('2025-12-03 12:20:00','2025-12-03 12:50:00',4.0,2,2,2),
('2025-12-03 12:35:00','2025-12-03 13:00:00',3.0,4,3,3),
('2025-12-03 12:50:00','2025-12-03 13:20:00',4.5,1,4,4),
('2025-12-03 13:05:00','2025-12-03 13:30:00',5.0,2,5,1);
