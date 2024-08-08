from flask import Flask, request, jsonify, redirect, url_for,render_template
from flask_cors import CORS
from Conexion import MyDatabase
import base64
from io import BytesIO
import uuid
import mysql.connector
from mysql.connector import Error
from functools import wraps

app = Flask(__name__,template_folder='../templates')
CORS(app) 
db = MyDatabase()

@app.route("/submitSignUp", methods=["POST"])
def submitSignUp():
    def generate_unique_id():
        return str(uuid.uuid4())
    # Genera un token
    token = generate_unique_id()
    #obteniendo datos
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

   

    query1="""SELECT id FROM persona Where nombre1=%s AND nombre2=%s AND apellido1=%s AND apellido2=%s AND correoElectronico=%s AND fechaNacimiento=%s """
    cursor.execute(query1,(primerNombre, segundoNombre, primerApellido, segundoApellido,email,fechaNacimiento))
  
    RESULTADO_id=cursor.fetchone()
    

    if RESULTADO_id:
            id = RESULTADO_id[0]
            query2 = """
            INSERT INTO usuario (persona_id, estadoCuenta_id, contraseña, token)
            VALUES (%s, %s, %s, %s)
            """
            cursor.execute(query2, (id, "1", contraseña, token))
            conexion.commit()
  

    cursor.close()
    db.close_connection(conexion)
    return jsonify({"status": "exito"}), 200


@app.route('/libros_disponibles', methods=['GET'])
def libros_disponibles():
    conexion = db.open_connection()
    query = """SELECT titulo,imagen,Nombre_Autor,Apellido_Autor,isbn,precio  FROM Libros_Disponibles"""

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
            Nombre_Autor = fila[2]
            Apellido_Autor = fila[3]
            isbn =fila[4]
            precio=fila[5]

            Nombre= Nombre_Autor + " "+ Apellido_Autor;

            if imagen_binaria:
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
            else:
                imagen_base64 = None

            libros.append({
                "titulo": titulo,
                "imagen": imagen_base64,
                "NombreAutor":Nombre,
                "isbn":isbn,
                "precio":precio
            })

        return jsonify(libros), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400




@app.route("/agregar_libros", methods=["POST"])
def agregar_libros():
    data = request.json
    titulo = data.get('titulo')
    fechaPublicacion = data.get('fechaPublicacion')
    idioma = data.get('idioma')
    isbn = data.get('isbn')
    numEdicion = data.get('numEdicion')
    numPaginas = data.get('numPaginas')
    url = data.get('url')
    editorial_id = data.get('editorial')
    imagen_base64 = data.get('imageData')
    proveedor = data.get('proveedor')
    precio = data.get('precio')
    idautor = data.get('idautor')
    precioVenta = data.get('precioVenta')
    tipo = data.get('tipo')
    observacion = data.get('observacion')

    imagen_binario = None
    if imagen_base64:
        imagen_binario = base64.b64decode(imagen_base64)

    conexion = db.open_connection()
    cursor = conexion.cursor()

    try:
        query = """INSERT INTO libro(titulo,fecha_publicacion,idioma,isbn,numEdicion,numPaginas,url,editorial_id,biblioteca_id,imagen) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
        cursor.execute(query, (titulo, fechaPublicacion, idioma, isbn, numEdicion, numPaginas, url, editorial_id, "1", imagen_binario))
        conexion.commit()
        
        query1 = """SELECT id FROM libro WHERE titulo LIKE %s AND isbn = %s"""
        cursor.execute(query1, ("%" + titulo + "%", isbn))
        resultado = cursor.fetchall()  # Leer todos los resultados

        if resultado:
            libro_id = resultado[0][0]

            query2 = """INSERT INTO libroComprado(precio, libro_id) VALUES(%s, %s)"""
            cursor.execute(query2, (precio, libro_id))
            conexion.commit()
            
            query3 = """SELECT id FROM libroComprado WHERE libro_id = %s"""
            cursor.execute(query3, (libro_id,))
            resultado1 = cursor.fetchall()  # Leer todos los resultados

            if resultado1:
                libro_comprado_id = resultado1[0][0]

                query4 = """INSERT INTO Libro_Comprado_has_Proveedor(libro_comprado_id,proveedor_id) VALUES(%s,%s)"""
                cursor.execute(query4, (libro_comprado_id, proveedor))
                conexion.commit()

                query5 = """INSERT INTO Libro_has_Autor(libro_id,autor_id) VALUES(%s,%s)"""
                cursor.execute(query5, (libro_id, idautor))
                conexion.commit()

                query6 = """INSERT INTO formatoLibro(tipo,observacion,precio) VALUES(%s,%s,%s)"""
                cursor.execute(query6, (tipo, observacion, precioVenta))
                conexion.commit()
                
                query7 = """SELECT id FROM formatoLibro WHERE tipo=%s AND observacion=%s AND precio=%s"""
                cursor.execute(query7, (tipo, observacion, precioVenta))
                resultado2 = cursor.fetchall()  # Leer todos los resultados

                if resultado2:
                    id_formatoLibro = resultado2[0][0]

                    query8 = """INSERT INTO Formato_Libro_has_Libro(formatoLibro_id,libro_id) VALUES (%s,%s)"""
                    cursor.execute(query8, (id_formatoLibro, libro_id))
                    conexion.commit()

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        conexion.rollback()
        return jsonify({"status": "error", "message": str(err)}), 500

    finally:
        cursor.close()
        conexion.close()

    return jsonify({"status": "success"}), 200

@app.route('/libros_donados' , methods=['GET'])
def libros_donados():
    conexion = db.open_connection()
    query = """SELECT Titulo_Libro,imagen,Nombre_Usuario,Apellido_Usuario FROM Libros_Donados"""

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
            Nombre1 = fila[2]
            Apellido1 = fila[3]
            Nombre = Nombre1 + " " + Apellido1

            if imagen_binaria:
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
            else:
                imagen_base64 = None

            libros.append({
                "titulo": titulo,
                "imagen": imagen_base64,
                "nombre":Nombre
            })

        return jsonify(libros), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    


@app.route('/prestamos_activos' , methods=['GET'])
def prestamos_activos():
    conexion = db.open_connection()
    query = """SELECT titulo,imagen,nombre1,apellido1,fechaPrestamo,fechaRegreso From Prestamos_Activos"""

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
            nombre1= fila[2]
            apellido1=fila[3]
            fechaPrestamo= fila[4]
            fechaRegreso= fila[5]

            nombre= nombre1 + " " + apellido1

            if imagen_binaria:
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
            else:
                imagen_base64 = None

            libros.append({
                "titulo": titulo,
                "imagen": imagen_base64,
                "nombre": nombre,
                "fechaRegreso":fechaRegreso,
                "fechaPrestamo":fechaPrestamo

            })

        return jsonify(libros), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    

@app.route('/libro_vendidos' , methods=['GET'])
def libro_venvidos():
    conexion = db.open_connection()
    query = """
    SELECT libro.titulo,libro.imagen,persona.nombre1,persona.apellido1 ,detalleFactura.precioUnitario,detalleFactura.factura_id
    From libro 
    INNER JOIN libroVendido ON libroVendido.libro_id=libro.id 
    INNER JOIN usuario ON libroVendido.usuario_id=usuario.id 
    INNER JOIN persona ON persona.id=usuario.persona_id
    INNER JOIN detalleFactura ON detalleFactura.libroVendido_id =libroVendido.id
    
    """

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
            nombre1= fila[2]
            apellido1 = fila[3]
            precio=fila[4]
            factura=fila[5]
            nombre = nombre1 + " " +apellido1

            if imagen_binaria:
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
            else:
                imagen_base64 = None

            libros.append({
                "titulo": titulo,
                "imagen": imagen_base64,
                "nombre": nombre,
                "precio": precio,
                "factura":factura
            })

        return jsonify(libros), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    

@app.route('/libros_comprados' , methods=['GET'])
def libro_comprados():
    conexion = db.open_connection()
    query = """
    SELECT libro.titulo,libro.imagen,libroComprado.precio,editorial.nombre,persona.nombre1,persona.apellido1 
    From libro 
    INNER JOIN libroComprado ON libroComprado.libro_id=libro.id
    INNER JOIN Libro_Comprado_has_Proveedor ON Libro_Comprado_has_Proveedor.libro_comprado_id = libroComprado.id
    RIGHT JOIN proveedor ON proveedor.id= Libro_Comprado_has_Proveedor.proveedor_id
    INNER JOIN persona ON persona.id = proveedor.persona_id
    INNER JOIN Editorial_has_Proveedor ON Editorial_has_Proveedor.proveedor_id = proveedor.id
    LEFT JOIN editorial ON editorial.id=Editorial_has_Proveedor.editorial_id
    """

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
            precio = fila[2]
            nombreEditorial=fila[3]
            nombre=fila[4]
            apellido=fila[5]

            nombreProveedor = nombre + " " + apellido 
            if imagen_binaria:
                imagen_base64 = base64.b64encode(imagen_binaria).decode('utf-8')
            else:
                imagen_base64 = None

            libros.append({
                "titulo": titulo,
                "imagen": imagen_base64,
                "precio": precio,
                "nombreEditorial":nombreEditorial,
                "nombreProveedor":nombreProveedor
            })

        return jsonify(libros), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
@app.route('/userdate', methods=['POST'])
def userdate():
    data = request.json
    token = data.get('token')

    conexion = db.open_connection()
    cursor = conexion.cursor()

    query = """SELECT persona.correoElectronico, persona.Nombre1, persona.apellido1 
               FROM usuario 
               INNER JOIN persona ON usuario.persona_id = persona.id 
               WHERE token = %s"""
    
    cursor.execute(query, (token,))  
    resultados = cursor.fetchone()

    if resultados:
        correoElectronico = resultados[0]
        Nombre = resultados[1]
        Apellido = resultados[2]
        datos = {
            "correoElectronico": correoElectronico,
            "Nombre": Nombre,
            "Apellido": Apellido
        }
        return jsonify(datos)
    else:
        return jsonify({"status": "error", "message": "No se encontraron datos para el token proporcionado."}), 404

   

@app.route("/login", methods=["POST"])
def login():
    data = request.json
    email = data.get('email')
    contraseña = data.get('contraseña')

    conexion = db.open_connection()
    if conexion is None:
        return jsonify({"status": "error", "message": "No se pudo conectar a la base de datos"}), 500

    cursor = conexion.cursor()
    query = """
    SELECT persona.correoElectronico, usuario.contraseña, usuario.token,usuario.rol 
    FROM persona 
    INNER JOIN usuario ON usuario.persona_id=persona.id 
    WHERE correoElectronico = %s AND contraseña = %s
    """
    cursor.execute(query, (email, contraseña))
    user = cursor.fetchone()
    cursor.close()
    db.close_connection(conexion)
   
    if user:
        token = user[2] #el token esta en la tercera linea de la consulta
        rol=user[3]
        if rol == 2:
            pagina = "../html/libros.html"
        else:
            pagina = "../index.html"

        dato = {
            "token": token,
            "pagina": pagina
        }
        return jsonify({"status": "success", "datos": dato}), 200
    else:
        return jsonify({"status": "error", "message": "Credenciales inválidas"}), 401
    


def administrador(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token.startswith('Bearer '):
            return jsonify({"status": "error", "message": "Token no proporcionado"}), 401
        token = token.split(' ')[1]
        
        conexion = db.open_connection()
        cursor = conexion.cursor()
        query="""SELECT rol 
        FROM usuario 
        WHERE token=%s
        """
        cursor.execute(query,(token,))

        resultado=cursor.fetchone()
        cursor.close()
        db.close_connection(conexion)

        if resultado:
            rol=resultado[0]
            if rol==2:
                return f(*args, **kwargs)
            else:
                return jsonify({"status": "error", "message": "no autorizado"}), 401
    return decorated_function

@app.route('/enviar_token', methods=['GET'])
@administrador
def enviar_token():
    return jsonify({"status": "success", "message": "Acceso concedido"}), 200


    





if __name__ == "__main__":
    app.run(debug=True)
