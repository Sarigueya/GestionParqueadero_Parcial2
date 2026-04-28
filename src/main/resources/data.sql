-- ============================================================
-- Datos iniciales del sistema ParkApp
-- Ejecutado automáticamente por Spring Boot al arrancar
-- ============================================================

-- Roles
INSERT IGNORE INTO rol (nombre) VALUES ('ADMIN');
INSERT IGNORE INTO rol (nombre) VALUES ('ACOMODADOR');
INSERT IGNORE INTO rol (nombre) VALUES ('CLIENTE');

-- Categorías de vehículos
INSERT IGNORE INTO categoria_vehiculo (nombre) VALUES ('Carro');
INSERT IGNORE INTO categoria_vehiculo (nombre) VALUES ('Moto');
INSERT IGNORE INTO categoria_vehiculo (nombre) VALUES ('Camión');
INSERT IGNORE INTO categoria_vehiculo (nombre) VALUES ('Bicicleta');

-- Usuarios (contraseña en texto plano para desarrollo)
INSERT IGNORE INTO persona (username, password, rol_id)
    VALUES ('admin', '1234', (SELECT id FROM rol WHERE nombre = 'ADMIN'));

INSERT IGNORE INTO persona (username, password, rol_id)
    VALUES ('acomodador1', '1234', (SELECT id FROM rol WHERE nombre = 'ACOMODADOR'));

INSERT IGNORE INTO persona (username, password, rol_id)
    VALUES ('cliente1', '1234', (SELECT id FROM rol WHERE nombre = 'CLIENTE'));
