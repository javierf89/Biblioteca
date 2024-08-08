function getValores() {
    let primerNombre = document.getElementById('primerNombre').value.trim();
    let segundoNombre = document.getElementById('segundoNombre').value.trim();
    let primerApellido = document.getElementById('primerApellido').value.trim();
    let segundoApellido = document.getElementById('segundoApellido').value.trim();
    let fechaNacimiento = document.getElementById('fechaNacimiento').value.trim();
    let telefono = document.getElementById('telefono').value.trim();
    let email = document.getElementById('email').value.trim();
    let contraseña = document.getElementById('contraseña').value.trim();
    let contraseña1 = document.getElementById('contraseña1').value.trim();

    // Validar campos
    if (!primerNombre || !primerApellido || !email || !contraseña || !contraseña1) {
        alert('Por favor, complete todos los campos obligatorios.');
        return;
    }

    if (contraseña !== contraseña1) {
        alert('Las contraseñas no coinciden.');
        return;
    }

    let datos = {
        primerNombre: primerNombre,
        segundoNombre: segundoNombre,
        primerApellido: primerApellido,
        segundoApellido: segundoApellido,
        fechaNacimiento: fechaNacimiento,
        telefono: telefono,
        email: email,
        contraseña: contraseña
    };

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
        alert('Bienvenido ' + primerNombre);
        
      
        
        window.location.href = '../index.html';
    })
    .catch((error) => {
        console.error('Error:', error);
        alert('Hubo un problema al procesar su solicitud. Por favor, intente nuevamente.');
    });
}
