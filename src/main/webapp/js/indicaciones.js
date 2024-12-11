$(document).ready(function () {
    listadoIndicacionesAjax();

    $("#botondep").on('click', function () {
        $("#descripcion").val($("#descripcion").val().toUpperCase().trim());

        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
            $.ajax({
                data: datosformularios,
                url: 'jsp/indicaciones.jsp',
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Llama a listadoIndicacionesAjax() después de la operación exitosa
                    listadoIndicacionesAjax();
                    // Restablece los campos del formulario
                    $("#listar").val("cargar");
                    $("#pk").val("");
                    $("#descripcion").val("");
                }
            });
        } else {
            // alert
        }
    });

    $("#eliminartodo").on('click', function () {
        pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/indicaciones.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoIndicacionesAjax() después de la operación exitosa
                listadoIndicacionesAjax();
            }
        });
    });
});

function listadoIndicacionesAjax() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/indicaciones.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenarIndicaciones(id, descripcion) {
    $("#listar").val("modificar");
    $("#descripcion").val(descripcion);
    $("#pk").val(id);
}

function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

function validarFormulario() {
    var descripcion = $("#descripcion").val().trim();

    if (descripcion === "") {
        mostrarAlerta("Por favor, complete la descripción.", "alert-danger");
        return false;
    } else {
        return true;
    }
}


