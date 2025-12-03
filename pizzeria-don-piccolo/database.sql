create database if not exists pizzeria_don_piccolo;
Use pizzeria_don_piccolo;

create table Gestion_Clientes(
    Id_Gestion_Clientes INT PRIMARY KEY NOT NULL,
    Nombre Varchar(80) NOT NULL,
    Telefono Varchar(80) NOT NULL,
    Direccion Varchar(80) NOT NULL,
    Correo Varchar(80) NOT NULL
);

create table Gestion_Pizza(
    Id_Gestion_Pizza INT PRIMARY KEY NOT NULL,
    Nombre_Pizza Varchar(80),
    Tamaño_Pizza Enum('Grande', 'Mediano', 'Pequeño'),
    Precio_Base INT NOT NULL,
    Tipo_Pizza Enum('Vegetariana', 'Especial', 'Clasica')
);

create table Ingredientes(
    Id_Ingredientes INT PRIMARY KEY NOT NULL,
    Tipo_Ingredientes Varchar(80) NOT NULL,
    Costo_Ingredientes INT NOT NULL,
    FOREIGN KEY (Id_Gestion_Pizza) REFERENCES (Id_Gestion_Pizza)
);

create table Gestion_Pedido(
    Id_Gestion_Pedidos INT PRIMARY KEY NOT NULL,
    Fecha_Hora DATETIME,
    Pizzas_Solicitadas INT,
    Metodo_Pago Enum('Efectivo', 'Tarjeta', 'App'),
    Estado Enum('Pendiente', 'En Preparacion', 'Entregado', 'Cancelado'),
    Total_Pedido Double NOT NULL
);

create table Gestion_Repartidores(
    Id_Gestion_Repartidores INT PRIMARY KEY NOT NULL,
    Nombre Varchar(80) NOT NULL,
    Zona_Asignada Varchar(80) NOT NULL,
    Estado_Repartidor Enum('Disponible', 'No Disponible') NOT NULL
);

create table Gestion_Domicilios(
    Id_Gestion_Domicilios INT PRIMARY KEY NOT NULL,
    Hora_Salida DATETIME,
    Hora_Entrega DATETIME,
    Distancia_Aproximada INT NOT NULL,
    Costo_Envio Double NOT NULL
    FOREIGN KEY (Id_Gestion_Repartidores) REFERENCES (Id_Gestion_Repartidores)
);

