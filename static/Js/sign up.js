
function getValores() {
    let primerNombre = document.getElementById('primerNombre').value;
    let segundoNombre = document.getElementById('segundoNombre').value;
    let primerApellido = document.getElementById('primerApellido').value;
    let segundoApellido = document.getElementById('segundoApellido').value;
    let fechaNacimiento = document.getElementById('fechaNacimiento').value;
    let telefono = document.getElementById('telefono').value;
    let email = document.getElementById('email').value;
    let contraseña = document.getElementById('contraseña').value;

    console.log('Primer Nombre:', primerNombre);
    console.log('Segundo Nombre:', segundoNombre);
    console.log('Primer Apellido:', primerApellido);
    console.log('Segundo Apellido:', segundoApellido);
    console.log('Fecha de Nacimiento:', fechaNacimiento);
    console.log('Teléfono:', telefono);
    console.log('Email:', email);
    console.log('Contraseña:', contraseña);

    let datos = {
        primerNombre:primerNombre,
        segundoNombre:segundoNombre,
        primerApellido:primerApellido,
        segundoApellido:segundoApellido,
        fechaNacimiento:fechaNacimiento,
        telefono:telefono,
        email:email,
        contraseña:contraseña
    }

    fetch('http://localhost:5000/submitSignUp', {
        method: 'POST', 
        headers: {
            'Content-Type': 'application/json' 
        },
        body: JSON.stringify(datos) 
    })
    .then(response => response.json()) 
    .then(data => {
        console.log('Éxito:', data); 
    })
    .catch((error) => {
        console.error('Error:', error); 
    });
}

