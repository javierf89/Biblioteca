document.addEventListener("DOMContentLoaded", () => {
    fetch('http://localhost:5000/libros_disponibles')
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
                    img.src = 'default_image_url'; // Puedes usar una imagen predeterminada si no hay imagen
                }
                img.alt = libro.titulo;
                img.style.width = '100px'; 
                img.style.height = 'auto';
                img.style.marginTop = '0px';
                img.style.marginBottom= '50px';

                const button = document.createElement('button');
                button.className = 'libros-button';
                button.innerText = 'Prestar';
              
                button.addEventListener('click', () => {
                    localStorage.setItem('prestamo', libro.isbn);
                    alert(`ISBN guardado en localStorage: ${libro.isbn}`);
                    window.location.href="no esta"

                });
                libroElement.appendChild(title);
                libroElement.appendChild(img);
                libroElement.appendChild(button);

                container.appendChild(libroElement);
            });
        })
        .catch(error => console.error('Error al cargar los libros:', error));
});