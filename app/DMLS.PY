import mysql.connector

config = {
    'host': 'monorail.proxy.rlwy.net',
    'user': 'root',
    'password': 'WzoXRssPsMZYCWZoeNzgUSfMjrbylYDg',
    'database': 'railway',
    'port': 36539
}

conn = mysql.connector.connect(**config)
cursor = conn.cursor()


cursor.execute("SHOW TABLES")
tables = cursor.fetchall()


with open('dml_script.sql', 'w', encoding='utf-8') as file:
    for (table_name,) in tables:
 
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]

        for row in rows:
            values = ', '.join(f"'{value}'" if value is not None else 'NULL' for value in row)
            sql = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({values});\n"
            file.write(sql)

        file.write("\n")  


cursor.close()
conn.close()

print("DML exportado exitosamente a dml_script.sql")
