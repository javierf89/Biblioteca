
document.addEventListener("DOMContentLoaded", function () {

    fetch('http://localhost:5000/enviar_token', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'error') {
            // Redireccionar a la página de no autorizado si la respuesta es un error
            window.location.href = '../index.html';
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
});