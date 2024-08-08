import mysql.connector

class MyDatabase:
    def __init__(self):
        self.connection_params = {
            'host': "monorail.proxy.rlwy.net",
            'user': "root",
            'passwd': "WzoXRssPsMZYCWZoeNzgUSfMjrbylYDg",
            'database': "railway",
            'port': 36539
        }

    def open_connection(self):
        try:
            connection = mysql.connector.connect(**self.connection_params)
            print("Conexión exitosa a la base de datos")
            return connection
        except mysql.connector.Error as err:
            print(f"No se pudo conectar a la base de datos: {err}")
            return None

    def close_connection(self, connection):
        if connection.is_connected():
            connection.close()
            print("Conexión a la base de datos cerrada")
