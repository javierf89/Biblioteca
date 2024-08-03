from flask import Flask, request, jsonify
from flask_cors import CORS
from Conexion import MyDatabase
import base64
from io import BytesIO

app = Flask(__name__)
CORS(app) 
db = MyDatabase()

@app.route("/submitSignUp", methods=["POST"])
def submitSignUp():
    data = request.json
    primerNombre = data.get('primerNombre')
    segundoNombre = data.get('segundoNombre')
    primerApellido = data.get('primerApellido')
    segundoApellido = data.get('segundoApellido')
    fechaNacimiento = data.get('fechaNacimiento')
    telefono = data.get('telefono')
    email = data.get('email')
    contraseña = data.get('contraseña')

    conexion = db.open_connection()
    if conexion is None:
        return jsonify({"status": "error", "message": "No se pudo conectar a la base de datos"}), 500
    
    cursor = conexion.cursor()
    query = """
    INSERT INTO persona (nombre1,nombre2,apellido1,apellido2,correoElectronico,fechaNacimiento)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.execute(query, (primerNombre, segundoNombre, primerApellido, segundoApellido,email,fechaNacimiento))
    conexion.commit()
    cursor.close()
    db.close_connection(conexion)

    return jsonify({"status": "success"}), 200


@app.route('/libros_disponibles', methods=['GET'])
def libros_disponibles():
    conexion = db.open_connection()
    query = """SELECT titulo, imagen FROM Libros_Disponibles"""

    try:
        cursor = conexion.cursor()
        cursor.execute(query)
        resultados = cursor.fetchall()
        cursor.close()
        conexion.close() 

        # Convertir imagen binaria a base64
        libros = []
        for fila in resultados:
            titulo = fila[0]
            imagen_binaria = fila[1]

            if imagen_binaria:
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
            else:
                imagen_base64 = None

            libros.append({
                "titulo": titulo,
                "imagen": imagen_base64
            })

        return jsonify(libros), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400



if __name__ == "__main__":
    app.run(debug=True)
