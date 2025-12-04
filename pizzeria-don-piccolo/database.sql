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
);

-- Creacion de la tabla de los detalle de la pizza.

create table detalle_pizza (
    Id_Pizza INT, -- Id de la tabla de la pizza
    Id_Ingrediente INT, -- Id de la tabla de Ingrediente
    PRIMARY KEY (Id_Pizza, Id_Ingrediente), -- La llave primaria compuesta, esta permite que no se presente la misma tipa con el mismo Ingrediente.
    FOREIGN KEY (Id_Pizza) REFERENCES Pizza(Id_Pizza), -- Relacion A la tabla Pizza
    FOREIGN KEY (Id_Ingrediente) REFERENCES Ingrediente(Id_Ingrediente) -- Relacion A la tabla Ingrediente
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

-- Creacion tabla Zona 

create table Zona(
    Id_Zona INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Zona Varchar(80) NOT NULL,
    Distancia_Aproximada Double NOT NULL
);