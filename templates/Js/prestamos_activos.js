document.addEventListener("DOMContentLoaded", () => {
    if (!sessionStorage.getItem('reloaded')) {
        sessionStorage.setItem('reloaded', 'true');
       
        location.reload();
    } else {
     
        sessionStorage.removeItem('reloaded');
    }
    

    fetch('http://localhost:5000/prestamos_activos')
        .then(response => response.json())
        .then(libros => {
            const container = document.getElementById('libros');

            libros.forEach(libro => {
                const libroElement = document.createElement('div');
                libroElement.className = 'libros';

                const title = document.createElement('span');
                title.className = 'libros-title';
                title.innerText = libro.titulo;

                const img = document.createElement('img');
                if (libro.imagen) {
                    img.src = `data:image/jpeg;base64,${libro.imagen}`;
                } else {
                    img.src = 'default_image_url'; // Cambia 'default_image_url' por la URL de la imagen predeterminada
                }
                img.alt = libro.titulo;
                img.style.width = '100px'; 
                img.style.height = 'auto';


                const infoContainer = document.createElement('div');
                infoContainer.className = 'libros-info';
                const fechaPrestamo = document.createElement('span');
                fechaPrestamo.className = 'fecha-prestamo';
                fechaPrestamo.innerText = `FechaPrestamos: ${libro.fechaPrestamo}`;

                const fechaRegreso = document.createElement('span');
                fechaRegreso.className = 'fecha-regreso';
                fechaRegreso.innerText = `FechaRegreso: ${libro.fechaRegreso}`;
            
                // nombre
                const autor = document.createElement('span');
                autor.className = 'libros-autor';
                autor.innerText = `Nombre: ${libro.nombre}`;



                libroElement.appendChild(title);
                libroElement.appendChild(img);
                libroElement.appendChild(infoContainer);
                infoContainer.appendChild(autor);
                infoContainer.appendChild(fechaPrestamo);
                infoContainer.appendChild(fechaRegreso);
                container.appendChild(libroElement);
            });
        })
        .catch(error => console.error('Error al cargar los libros:', error));
});



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