document.addEventListener("DOMContentLoaded", () => {
    if (!sessionStorage.getItem('reloaded')) {
        sessionStorage.setItem('reloaded', 'true');
       
        location.reload();
    } else {
        
        sessionStorage.removeItem('reloaded');
    }
    fetch('http://localhost:5000/libros_comprados')
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


                const autor = document.createElement('span');
                autor.className = 'libros-autor';
                autor.innerText = `Nombre Proveedor: ${libro.nombreProveedor}`;

                const precio = document.createElement('span');
                precio.className = 'libros-precio';
                precio.innerText = `Precio : ${libro.precio}`;


                const nombreEditorial = document.createElement('span');
                nombreEditorial.className = 'nombreEditorial';
                nombreEditorial.innerText = `Nombre editorial : ${libro.nombreEditorial}`;
                



                libroElement.appendChild(title);
                libroElement.appendChild(img);
                libroElement.appendChild(autor);
                libroElement.appendChild(precio);
                libroElement.appendChild(nombreEditorial);
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