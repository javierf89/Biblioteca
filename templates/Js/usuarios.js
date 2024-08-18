document.addEventListener("DOMContentLoaded" ,() =>{
    let token = localStorage.getItem('token');
    fetch('http://localhost:5000/usuario' ,{
        method:"POST",
        headers:{
            'Content-Type': 'application/json'
        },
        body : JSON.stringify({ token: token })  
    }
    )
    .then(response => response.json())
    .then(data => {
        

        let primerNombre = data.primerNombre;
        let segundoNombre = data.segundoNombre;
        let primerApellido = data.primerApellido;
        let segundoApellido = data.segundoApellido;
        let telefono =  data.telefono;
        let fechaNacimiento= data.fechaNacimiento;
        let nombreCompleto = primerNombre  + " " +  primerApellido;
        
        document.getElementById('primerNombre').value = primerNombre;
        document.getElementById('segundoNombre').value = segundoNombre;
        document.getElementById('primerApellido').value = primerApellido;
        document.getElementById('segundoApellido').value = segundoApellido;
        document.getElementById('telefono').value = telefono;
        document.getElementById('fechaNacimiento').value = fechaNacimiento;
        document.getElementById('nombreCompleto').innerText = nombreCompleto;

     
    })
    const inicioSesion = document.getElementById('inicio_sesion');
    if (token) {
        inicioSesion.querySelector('span').innerText = 'Cerrar Sesión';  
        inicioSesion.addEventListener('click', () => {
            localStorage.removeItem('token'); 
            window.location.reload();  
        });
    } else {
        inicioSesion.querySelector('span').innerText = 'Iniciar Sesión'; 
        inicioSesion.addEventListener('click', () => {
            window.location.href = '../html/login.html';  
        });
    }
})