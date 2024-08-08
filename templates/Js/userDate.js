document.addEventListener("DOMContentLoaded", () => {
    let token = localStorage.getItem('token');

    fetch('http://localhost:5000/userdate', {  
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ token: token })  
    })
    .then(response => response.json())
    .then(data => {
        if (data.correoElectronico) {
            console.log('Datos del usuario:', data);
            
            document.getElementById('correoElectronico').textContent = data.correoElectronico;
            document.getElementById('nombre').textContent = data.Nombre + " " + data.Apellido;
            
        } else {
            console.error('No se encontraron datos para el token proporcionado.');
            alert('No se encontraron datos para el token proporcionado.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Hubo un problema al procesar su solicitud. Por favor, intente nuevamente.');
    });

    const incio_sesion = document.getElementById('incio_sesion');
    const Registrarse = document.getElementById('Registrarse');

    if (token) {
        incio_sesion.textContent = 'Cerrar sesión';  
        incio_sesion.addEventListener('click', () => {
            localStorage.removeItem('token'); 
            window.location.reload();  
        });
    } else {
        incio_sesion.textContent = 'Iniciar sesión'; 
        incio_sesion.addEventListener('click', () => {
            window.location.href = '../html/login.html';  
        });
    }

    Registrarse.addEventListener('click', () => {
        window.location.href = '../html/signUp.html';  
    });
});
