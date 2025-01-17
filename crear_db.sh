#!/bin/bash

# Nombre del proyecto de GCP
PROJECT_ID="tu-proyecto-gcp"  # Reemplaza con tu ID de proyecto

# Nombre de la instancia de Cloud SQL
INSTANCE_NAME="demosql" # Reemplaza con el nombre de tu instancia

# Usuario de la base de datos
DB_USER="root" # Reemplaza con tu usuario

# Contraseña del usuario de la base de datos
DB_PASSWORD="Entel12345" # Reemplaza con tu contraseña

# Nombre de la base de datos
DATABASE_NAME="pedidos_db"

# Conectarse a la instancia de Cloud SQL
gcloud sql connect $INSTANCE_NAME --user=$DB_USER --project=$PROJECT_ID


# Crear la base de datos
mysql -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;"

# Usar la base de datos
mysql -e "USE $DATABASE_NAME;"

# Crear la tabla de pedidos
mysql -e "CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE,
    cliente VARCHAR(255)
);"

# Crear la tabla de detalles de pedidos
mysql -e "CREATE TABLE IF NOT EXISTS detalles_pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    producto VARCHAR(255),
    cantidad INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);"


# Insertar datos en la tabla de pedidos
mysql -e "INSERT INTO pedidos (fecha_pedido, cliente) VALUES
    ('2023-10-26', 'Cliente 1'),
    ('2023-10-27', 'Cliente 2'),
    ('2023-10-28', 'Cliente 1');"


# Insertar datos en la tabla de detalles de pedidos
mysql -e "INSERT INTO detalles_pedidos (id_pedido, producto, cantidad, precio) VALUES
    (1, 'Producto A', 2, 10.50),
    (1, 'Producto B', 1, 5.00),
    (2, 'Producto C', 3, 15.00),
    (3, 'Producto A', 1, 10.50),
    (3, 'Producto D', 2, 20.00);"

echo "Base de datos '$DATABASE_NAME' creada y poblada con datos."


# [OPCIONAL] Mostrar los datos de las tablas
# mysql -e "SELECT * FROM pedidos;"
# mysql -e "SELECT * FROM detalles_pedidos;"
