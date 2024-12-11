$(document).ready(function () {
    cargarApertura();
    $("#botondep").on('click', function () {
        $("#monto").val($("#monto").val().toUpperCase().trim());
        $("#fecharegistro").val($("#fecharegistro").val());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
            $.ajax({
                data: datosformularios,
                url: 'jsp/caja.jsp',
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Llama a listadoclientesajax() después de la operación exitosa
                    // Restablece los campos del formulario
                    $("#listar").val("cargar");
                    $("#pk").val("");
                    $("#monto").val("");
                }
            });
        } else {
            // alert 
        }
    });
$("#botondeps").on('click', function () {
        $("#monto").val($("#monto").val().toUpperCase().trim());
        $("#fecharegistro").val($("#fecharegistro").val());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
            $.ajax({
                data: datosformularios,
                url: 'jsp/caja.jsp',
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Llama a listadoclientesajax() después de la operación exitosa
                    // Restablece los campos del formulario
                    $("#listar").val("cerrar");
                    $("#pk").val("");
                    $("#monto").val("");
                }
            });
        } else {
            // alert 
        }
    });
});









function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

function validarFormulario() {
    var monto = $("#monto").val().trim();
    var fecharegistro = $("#fecharegistro").val(); // Obtiene el valor seleccionado del departamento

    if (monto === "") {
        mostrarAlerta("Por favor, complete el monto .", "alert-danger");
        return false;
    } else {
        if (fecharegistro === "") {
            mostrarAlerta("Por favor, complete la fecha", "alert-danger");
            return false;
        } else {
            return true;
        }
    }
}

function cargarApertura() {
    $.ajax({
        url: 'jsp/buscarapertura.jsp',
        type: 'post',
        success: function (response) {
            // Actualiza el valor del botón con la respuesta
            $("#idaperturas").val(response.trim());
        },
        error: function (xhr, status, error) {
            console.error("Error al cargar apertura: " + status + " - " + error);
        }
    });
}