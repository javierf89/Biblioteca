import mysql.connector

# Configuración de conexión
config = {
    'host': 'monorail.proxy.rlwy.net',
    'user': 'root',
    'password': 'WzoXRssPsMZYCWZoeNzgUSfMjrbylYDg',
    'database': 'railway',
    'port': 36539
}

# Conectar a la base de datos
conn = mysql.connector.connect(**config)
cursor = conn.cursor()

# Obtener las vistas en la base de datos
cursor.execute("SHOW FULL TABLES WHERE Table_type = 'VIEW'")
views = cursor.fetchall()

# Abrir el archivo para guardar el DML con codificación UTF-8
with open('views_dml_script.sql', 'w', encoding='utf-8') as file:
    for view_name, table_type in views:
        # Obtener los datos de la vista
        cursor.execute(f"SELECT * FROM {view_name}")
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]

        # Escribir los DML al archivo para cada vista
        for row in rows:
            values = ', '.join(f"'{value}'" if value is not None else 'NULL' for value in row)
            sql = f"INSERT INTO {view_name} ({', '.join(columns)}) VALUES ({values});\n"
            file.write(sql)

        file.write("\n")  # Añadir una línea en blanco entre vistas

# Cerrar la conexión
cursor.close()
conn.close()

print("DML para vistas exportado exitosamente a views_dml_script.sql")
