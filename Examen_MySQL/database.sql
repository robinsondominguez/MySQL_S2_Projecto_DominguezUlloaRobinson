Create database Examen_piccolo;
Use Examen_piccolo;

Drop database Examen_piccolo;


create table Persona(
    Id_Persona INT PRIMARY KEY AUTO_INCREMENT,
    Nombre Varchar(80) NOT NULL
);

create table Cliente(
    Id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Id_Persona INT NOT NULL,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona) 
);

create table Pedidos(
    Id_Pedidos INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Pedido DATETIME,
    Metodo_Pago Enum('Efectivo', 'Tarjeta', 'App'),
    Estado Enum('Pendiente', 'En Preparacion', 'Entregado', 'Cancelado'),
    Id_Cliente INT,
    Total_Pedido Double
);

create table Pizza(
    Id_Pizza INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Pizza Varchar(80),
    Precio_Base Double,
    Tamaño_Pizza Enum('Grande', 'Mediano', 'Pequeño'),
    Tipo_Pizza Enum('Vegetariana', 'Especial', 'Clasica')
);

create table detalle_pizza (
    Id_Pizza INT,
    Id_Ingrediente INT,
    PRIMARY KEY (Id_Pizza, Id_Ingrediente),
    FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza)
);

create table detalle_Pedido (
    Id_Detalle INT PRIMARY KEY AUTO_INCREMENT,
    Id_Pedido INT NOT NULL,
    Id_Pizza INT NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    FOREIGN KEY (Id_Pedido) REFERENCES Pedidos(Id_Pedidos),
    FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza)
);

-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////7

INSERT INTO Cliente (Id_Persona) VALUES
(1),(2),(3),(4),(5);

-- Personas
INSERT INTO Persona (Nombre) VALUES
('Juan Perez'),     
('Maria Lopez'),   
('Carlos Gomez'), 
('Ana Torres'),     
('Luis Ramirez'); 

INSERT INTO Pedidos (Fecha_Pedido, Metodo_Pago, Estado, Id_Cliente, Total_Pedido) VALUES
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 25000),
('2024-12-05 21:00:00', 'App', 'Pendiente', 1, 25000),
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 25000),
('2024-12-05 21:00:00', 'App', 'Pendiente', 1, 25000),
('2024-11-28 14:00:00', 'Efectivo', 'Pendiente', 1, 25000),
('2024-12-29 15:00:00', 'Tarjeta', 'En Preparacion', 2, 27000),
('2024-11-30 16:30:00', 'App', 'Pendiente', 3, 23000),
('2024-12-01 17:15:00', 'Efectivo', 'Entregado', 4, 30000),
('2024-12-02 18:00:00', 'Tarjeta', 'Cancelado', 5, 28000),
('2024-12-03 19:00:00', 'Efectivo', 'Pendiente', 1, 25000),
('2024-12-04 20:00:00', 'Tarjeta', 'Pendiente', 3, 25000);

INSERT INTO Pizza (Nombre_Pizza, Precio_Base, Tamaño_Pizza, Tipo_Pizza) VALUES
('Hawaiana', 25000, 'Grande', 'Clasica'),
('Pepperoni', 27000, 'Mediano', 'Especial'),
('Vegetariana', 23000, 'Grande', 'Vegetariana'),
('Mexicana', 30000, 'Pequeño', 'Especial'),
('Cuatro Quesos', 28000, 'Grande', 'Clasica');