document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.querySelector(".v23_54 button");

    loginForm.addEventListener("click", function (event) {
        event.preventDefault(); // Prevenir el envío del formulario por defecto

        let email = document.getElementById('email').value;
        let contraseña = document.getElementById('contraseña').value;

        console.log('Email:', email);
        console.log('Contraseña:', contraseña);

        let datos = {
            email: email,
            contraseña: contraseña
        }

        fetch('http://localhost:5000/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(datos)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === "success") {
                let token = data.datos.token;  // Accede al token dentro de data.datos
                let pagina = data.datos.pagina;  // Accede a la página dentro de data.datos
                localStorage.setItem('token', token);
                window.location.href = pagina;
            }else {
                // Mostrar mensaje de error en caso de fallo
                alert('Error al iniciar sesión: ' + datos.message);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    });

    fetch('/enviar_token', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
    })
    .catch(error => {
        console.error('Error:', error);
    });

   
    
});
