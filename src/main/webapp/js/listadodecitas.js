$(document).ready(function () {
    listarcitas();
    $("#eliminar-registro-venta").click(function () {
        pkd = $("#idpk").val();
        $.ajax({
            data: {listar: 'anularventa', pkd: pkd},
            url: 'jsp/insercionventas.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                listarcitas();
            }
        });
    });




});





