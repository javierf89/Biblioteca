from flask import Flask, request, jsonify
from flask_cors import CORS
from Conexion import MyDatabase
import base64
from io import BytesIO
import uuid

app = Flask(__name__)
CORS(app)
db = MyDatabase()




if __name__ == "__main__":
    app.run(debug=True)
