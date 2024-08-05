document.addEventListener("DOMContentLoaded", () => {
    fetch('http://localhost:5000/libros_donados')
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

                libroElement.appendChild(title);
                libroElement.appendChild(img);

                container.appendChild(libroElement);
            });
        })
        .catch(error => console.error('Error al cargar los libros:', error));
});
