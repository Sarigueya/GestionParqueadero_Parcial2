# ParkControl — Sistema de Gestión de Parqueadero

Aplicación web desarrollada con **Spring Boot** para la gestión de entradas y salidas de vehículos en un parqueadero. Permite el control por roles diferenciados: Administrador, Acomodador y Cliente.

---

## Tecnologías utilizadas

- Java 21
- Spring Boot 4.0.6
- Spring Security
- Spring Data JPA / Hibernate
- MySQL
- JSP + JSTL
- Bootstrap Icons
- Swagger / OpenAPI 3 (SpringDoc)
- Maven

---

## Estructura del proyecto

```
estacionamiento/
├── src/main/java/edu/usco/estacionamiento/
│   ├── configuracion/      # Configuración de recursos estáticos
│   ├── controlador/        # Controladores MVC por rol
│   ├── modelo/             # Entidades JPA
│   ├── seguridad/          # Spring Security
│   └── servicio/           # Lógica de negocio
├── src/main/resources/
│   ├── application.properties
│   └── data.sql            # Datos iniciales automáticos
├── src/main/webapp/
│   ├── static/css/         # Hojas de estilo por rol
│   └── WEB-INF/views/      # Vistas JSP
└── pom.xml
```

---

## Requisitos previos

- Java 21+
- Maven 3.8+
- MySQL 8+
- IDE: Eclipse

---

## Configuración de la base de datos

### 1. Crear la base de datos

```sql
CREATE DATABASE parkapp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. Configurar credenciales

Edita el archivo `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/parkapp_db
spring.datasource.username=root
spring.datasource.password=TU_CONTRASEÑA
```

### 3. Tablas y datos iniciales

Las tablas se crean automáticamente al iniciar la aplicación gracias a `ddl-auto=update`.

Los datos iniciales se insertan solos desde `data.sql`. Si prefieres hacerlo manualmente, ejecuta este script en MySQL:

```sql
USE parkapp_db;

-- Roles
INSERT IGNORE INTO rol (nombre) VALUES ('ADMIN'), ('ACOMODADOR'), ('CLIENTE');

-- Categorías de vehículos
INSERT IGNORE INTO categoria_vehiculo (nombre) VALUES ('Carro'), ('Moto'), ('Camión'), ('Bicicleta');

-- Usuarios
INSERT IGNORE INTO persona (username, password, rol_id)
VALUES ('admin', '1234', (SELECT id FROM rol WHERE nombre = 'ADMIN'));

INSERT IGNORE INTO persona (username, password, rol_id)
VALUES ('acomodador1', '1234', (SELECT id FROM rol WHERE nombre = 'ACOMODADOR'));

INSERT IGNORE INTO persona (username, password, rol_id)
VALUES ('cliente1', '1234', (SELECT id FROM rol WHERE nombre = 'CLIENTE'));
```

---

## Usuarios del sistema

| Usuario | Contraseña | Rol | Permisos |
|---|---|---|---|
| `admin` | `1234` | ADMIN | Crear, editar, eliminar y ver vehículos |
| `acomodador1` | `1234` | ACOMODADOR | Ver vehículos y actualizar ubicaciones |
| `cliente1` | `1234` | CLIENTE | Solo visualizar registros |

> ⚠️ Las contraseñas están en texto plano porque se usa `NoOpPasswordEncoder` para desarrollo. En producción se debe migrar a `BCryptPasswordEncoder`.

---

La aplicación queda disponible en:
```
http://localhost:8080
```

---

## Documentación de la API (Swagger)

Una vez iniciada la aplicación, la documentación de todos los endpoints está disponible en:

```
http://localhost:8080/swagger-ui/index.html
```

---

## Roles y vistas

| Rol | Ruta principal | Acceso |
|---|---|---|
| ADMIN | `/admin/vehiculos` | Panel completo con CRUD |
| ACOMODADOR | `/acomodador/vehiculos` | Tarjetas con opción de cambiar espacio |
| CLIENTE | `/cliente/vehiculos` | Tabla de solo lectura |

---
