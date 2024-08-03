from flask import Flask, request, jsonify
from flask_cors import CORS
from Conexion import MyDatabase

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


@app.route('/api/books', methods=['GET'])
def get_books():
    books = [
        {'id': 1, 'title': 'Book 1', 'image_url': 'https://i.pinimg.com/originals/c4/55/b2/c455b28336521304afeb4b352a099e4a.jpg'},
        {'id': 2, 'title': 'Book 2', 'image_url': 'https://i1.wp.com/geekdad.com/wp-content/uploads/2013/07/hpnc6.jpg?ssl=1'},
        {'id': 3, 'title': 'Book 3', 'image_url': 'https://images.cdn2.buscalibre.com/fit-in/360x360/e3/bc/e3bcd85377567759874a0664f894a67b.jpg'}
    ]
    return jsonify(books)
if __name__ == "__main__":
    app.run(debug=True)
