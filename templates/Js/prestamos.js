document.addEventListener("DOMContentLoaded", () => {

    
    if (!sessionStorage.getItem('reloaded')) {
        sessionStorage.setItem('reloaded', 'true');
       
        location.reload();
    } else {
       
        sessionStorage.removeItem('reloaded');
    }
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
                img.src = libro.imagen ? `data:image/jpeg;base64,${libro.imagen}` : 'default_image_url';
                img.alt = libro.titulo;
                img.style.width = '100px';
                img.style.height = 'auto';
                img.style.marginTop = '0px';
                img.style.marginBottom = '50px';

                const button = document.createElement('button');
                button.className = 'libros-button';
                button.innerText = 'Prestar';

                button.addEventListener('click', () => {
                    const datos = {
                        isbn: libro.isbn,
                        token: localStorage.getItem('token')
                    };

                    fetch('http://localhost:5000/prestar', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(datos)
                    })
                    .then(response => response.json())
                    .then(data => {
                        window.location.href = data.url;
                    })
                    .catch(error => {
                        console.error('Error al prestar el libro:', error);
                        alert('Hubo un problema al procesar el préstamo.');
                    });
                });

                libroElement.appendChild(title);
                libroElement.appendChild(img);
                libroElement.appendChild(button);

                container.appendChild(libroElement);
            });
        })
        .catch(error => console.error('Error al cargar los libros:', error));
});
