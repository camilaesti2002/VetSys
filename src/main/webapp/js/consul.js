$(document).ready(function () {
    listarcitasfin();

});
function listarcitasfin() {
    $.ajax({
        data: {listar: 'listarventass'},
        url: 'jsp/insercionventas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#resultadosventas").html(response);
        }
    });
}

// Evento para redirigir a la página de consulta con el ID seleccionado
document.addEventListener('DOMContentLoaded', function () {
    var atenderCitaButton = document.getElementById('cobrar-cita');
    if (atenderCitaButton) {
        atenderCitaButton.addEventListener('click', function () {
            var idpk = document.getElementById('idpk').value;
            if (idpk) {
                // Redirige a consulta.jsp con el parámetro idpk
                window.location.href = 'cobrarfin.jsp?idpk=' + encodeURIComponent(idpk);
            }
        });
    }
});