let precio  = 0 ;
let total = 0;
document.addEventListener("DOMContentLoaded", () => {
   
    let token = localStorage.getItem('token');
    let isbn = localStorage.getItem('venta');
    fetch('http://localhost:5000/factura', {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ token: token, isbn: isbn })
    })
    .then(response => response.json())
    .then(data => {
        let primerNombre = data.primerNombre;
        let segundoNombre = data.segundoNombre;
        let primerApellido = data.primerApellido;
        let segundoApellido = data.segundoApellido;
        let telefono = data.telefono;
        let nombreLibro = data.titulo;
        let isbn = data.isbn;
        precio = data.precio;
        total = data.preciototal;
        let membresiaTipo = data.membresia;

        document.getElementById('primerNombre').value = primerNombre;
        document.getElementById('segundoNombre').value = segundoNombre;
        document.getElementById('primerApellido').value = primerApellido;
        document.getElementById('segundoApellido').value = segundoApellido;
        document.getElementById('telefono').value = telefono;
        document.getElementById('nombreLibro').value = nombreLibro;
        document.getElementById('isbn').value = isbn;
        document.getElementById('precioUnitario').value = precio + " Dolares";
        document.getElementById('cantidadLibro').value = "1";
        document.getElementById('total').value = total + " Dolares";

        let radios = document.getElementsByName('opcionesMembresia');
        radios.forEach(radio => {
            if (radio.value === getMembresiaValue(membresiaTipo)) {
                radio.checked = true;
            }
        });
    });

    function getMembresiaValue(tipo) {
        switch (tipo) {
            case 'PL': return 'Platinum';
            case 'PR': return 'Premium';
            case 'BA': return 'Basica';
            default: return '';
        }
    }
});

function getValores() {
    let token = localStorage.getItem('token');
    let isbn = localStorage.getItem('venta');
    let correo = document.getElementById('correo').value.trim();
    let contraseña = document.getElementById('contraseña').value.trim();
    
    if (!correo || !contraseña) {
        alert('Por favor, complete todos los campos.');
        return; 
    }
    const opciones = document.getElementsByName('opcionesPago');
    let seleccionada = null;

    for (let opcion of opciones) {
        if (opcion.checked) {
            seleccionada = opcion.value;
            break;
        }
    }
    /*
    if (seleccionada === "paypal") {
        window.location.href = "https://www.paypal.com/ncp/payment/7KVTDXL786E7G";
    }
    else {
        alert("No has seleccionado ninguna opción.");
    }
    */
    let datos = {
        correo: correo,
        contraseña: contraseña,
        isbn:isbn,
        token:token,
        precio: precio,
        total:total,
        forma_pago:seleccionada
    };

    fetch('http://localhost:5000/hacer_factura', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(datos)
    })
    .then(response => response.json())
    .then(data => {
        console.log('Éxito:', data);
        alert('Factura generada con éxito.');
        localStorage.removeItem('venta');
        window.location.href = 'https://www.paypal.com/ncp/payment/7KVTDXL786E7G'; 
    })
    .catch((error) => {
        console.error('Error:', error);
        alert('Hubo un problema al procesar su solicitud. Por favor, intente nuevamente.');
    });
    
}
