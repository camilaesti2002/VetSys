$(document).ready(function () {
    listarcitas();
    $("#eliminar-registro-venta").click(function () {
        var ipkd = $("#idpk").val();
        // Realizar la solicitud AJAX si el motivo es válido
        $.ajax({
            data: {listar: 'anularventa', idpk: ipkd},  // Cambia ipkd por idpk
            url: 'jsp/insercionventas.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                 $('#exampleModalss').modal('hide');

                listarcitas();
            }
        });
    });
    
    $("#imprimirtodo").on('click', function () {
        var pkimps = $("#pkimps").val();
        var totalEnLetras = $("#totalEnLetras").val();

        // Mostrar en consola para verificar
        console.log("Valor de totalEnLetras en boton imprimirtodo:", totalEnLetras);

        // Verifica si 'totalEnLetras' tiene un valor
        if (totalEnLetras === "") {
            alert("El campo total en letras está vacío");
            return;
        }

        // Envía el pkimps y totalEnLetras al servidor usando POST
        $.post('guardarPkimps.jsp', {pkimps: pkimps, totalEnLetras: totalEnLetras}, function () {
            window.open('reporteconsulta.jsp', '_blank');
        });
    });
    
});
function listarcitas() {
    $.ajax({
        data: {listar: 'listarventa'},
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