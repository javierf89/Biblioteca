import uuid

def generate_unique_id():
    return str(uuid.uuid4())

# Generar una clave única para un usuario
token = generate_unique_id()
print(token)