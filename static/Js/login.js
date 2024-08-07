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
                // Redirigir al usuario a la página deseada después del inicio de sesión exitoso
                let token = data.token;
                localStorage.setItem('token',token);
                window.location.href = '../index.html';
            } else {
                // Mostrar mensaje de error en caso de fallo
                alert('Error al iniciar sesión: ' + data.message);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    });
});
