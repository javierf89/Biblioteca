function get_libros() {
    let titulo = document.getElementById("titulo").value;
    let fechaPublicacion = document.getElementById("fechaPublicacion").value;
    let idioma = document.getElementById("idioma").value;
    let isbn = document.getElementById("isbn").value;
    let numEdicion = document.getElementById("numEdicion").value;
    let numPaginas = document.getElementById("numPaginas").value;
    let url = document.getElementById("url").value;
    let editorial = document.getElementById("editorial").value;
    let precio = document.getElementById("precio").value;
    let proveedor = document.getElementById("codigoProveedor").value;

    let input = document.getElementById("imagen");
    let imageData = '';

    if (input.files && input.files[0]) {
        const file = input.files[0];
        const reader = new FileReader();
    
        reader.onload = (e) => {
            // Obtener el resultado Base64 con el prefijo
            imageData = e.target.result;
    
            // Eliminar el prefijo de tipo de contenido (data:image/jpeg;base64,)
            const imagen_s = imageData.replace(/^data:image\/(png|jpg|jpeg);base64,/, '');

            
            let datos = {
                titulo: titulo,
                fechaPublicacion: fechaPublicacion,
                idioma: idioma,
                isbn: isbn,
                numEdicion: numEdicion,
                numPaginas: numPaginas,
                url: url,
                precio: precio,
                editorial: editorial,
                imageData: imagen_s,
                proveedor:proveedor
            };

           
            fetch('http://localhost:5000/agregar_libros', {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(datos)
            })
            .then(response => response.json()) 
            .then(data => {
                console.log("Éxito", data);
            })
            .catch((error) => {
                console.log("Error", error);
            });
        };

        reader.readAsDataURL(file); // 
    } else {
        alert('Por favor, selecciona una imagen.');
    }
}

