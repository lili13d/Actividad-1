DROP DATABASE IF EXISTS Actividad_7;
CREATE DATABASE Actividad_7;

USE Actividad_7;

CREATE TABLE CLIENTE (
    id_cliente SERIAL PRIMARY KEY,
    num_factura INT NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(15),
    correo_electronico VARCHAR(100),
    sexo VARCHAR(10) NOT NULL,
    estado_civil VARCHAR(10) NOT NULL,
    CONSTRAINT sexo_valido CHECK (sexo IN ('femenino', 'masculino', 'otro')),
    CONSTRAINT estado_civil_valido CHECK (estado_civil IN ('casado', 'divorciado', 'soltero', 'viudo')) );
    
    
CREATE TABLE FACTURA (
    num_factura SERIAL PRIMARY KEY,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
    detalle_productos VARCHAR(255),
    fecha_factura DATE NOT NULL);

CREATE VIEW CLIENTE_VISTA AS
SELECT nombres, direccion, telefono, correo_electronico
FROM CLIENTE C
JOIN FACTURA F ON C.num_factura = F.num_factura
WHERE fecha_factura BETWEEN '2022-01-01' AND '2022-06-30'
GROUP BY nombres, direccion, telefono, correo_electronico
HAVING SUM(precio * cantidad) > 25;

CREATE VIEW FACTURA_VISTA AS
SELECT detalle_productos, COUNT(*) AS frecuencia, sUM(precio * cantidad) AS precio_acumulado
FROM FACTURA
WHERE fecha_factura BETWEEN '2022-06-01' AND '2022-06-30'
GROUP BY detalle_productos
ORDER BY frecuencia DESC, precio_acumulado ASC
LIMIT 3;
