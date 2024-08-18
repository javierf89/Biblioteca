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


with open('ddl_script.sql', 'w') as file:
    for (table_name,) in tables:
       
        cursor.execute(f"SHOW CREATE TABLE {table_name}")
        create_table_stmt = cursor.fetchone()[1]
       
        file.write(f"-- DDL for table {table_name}\n")
        file.write(create_table_stmt + ";\n\n")


cursor.close()
conn.close()

print("DDL exportado exitosamente a ddl_script.sql")
