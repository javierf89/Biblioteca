import mysql.connector

class MyDatabase():
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

    def insert_db(self, estrella, libro_id, usuario_id):
        my_connection = self.open_connection()
        if my_connection:
            try:
                cursor = my_connection.cursor()
                query = "INSERT INTO valoracion(estrella, libro_id, usuario_id) VALUES (%s, %s, %s)"
                data = (estrella, libro_id, usuario_id)
                cursor.execute(query, data)
                my_connection.commit()
                print("exitoso")
            except mysql.connector.Error as err:
                print(f"Error: {err}")
            finally:
                my_connection.close()


if __name__ == "__main__":
    db = MyDatabase()
    estrella = 6  
    libro_id = 1
    usuario_id = 1
    db.insert_db(estrella, libro_id, usuario_id)
