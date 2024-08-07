
var modal = document.getElementById("myModal");


var btn = document.getElementById("modalTrigger");

var span = document.getElementsByClassName("close")[0];


btn.onclick = function() {
    fetch("../HTML/userDate.html")
        .then(response => response.text())
        .then(data => {
            document.getElementById("modalContent").innerHTML = data;
            modal.style.display = "block";

            
         
            })
        .catch(error => console.error('Error al cargar el archivo:', error));
}

span.onclick = function() {
    modal.style.display = "none";
}

// Cuando el usuario hace clic en cualquier lugar fuera del modal, cerrarlo
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}