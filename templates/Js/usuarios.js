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
        
        document.getElementById('primerNombre').value = primerNombre;
        document.getElementById('segundoNombre').value = segundoNombre;
        document.getElementById('primerApellido').value = primerApellido;
        document.getElementById('segundoApellido').value = segundoApellido;
        document.getElementById('telefono').value = telefono;
        document.getElementById('fechaNacimiento').value = fechaNacimiento;


    })
})