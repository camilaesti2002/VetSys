$(document).ready(function () {
    listadohorariosajax();
    cargardoctores();

    $("#botondep").on('click', function () {
        $("#hora").val($("#hora").val().toUpperCase());
        $("#horafin").val($("#horafin").val().toUpperCase());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
            $.ajax({
                data: datosformularios,
                url: 'jsp/horarios.jsp',
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Llama a listadohorariosajax() después de la operación exitosa
                    listadohorariosajax();
                    // Restablece los campos del formulario
                    $("#listar").val("cargar");
                    $("#pk").val("");
                    $("#dias").val("0");
                    $("#hora").val("");
                    $("#horafin").val("");                    
                    $("#doctor").val("0");
                }
            });
        } else {
            // alert 
        }
    });
$("#imprimirtodo").on('click', function () {
    var pkimp = $("#pkimp").val(); // Obtén el valor del input hidden
    
    // Envía el pkimp al servidor usando POST
    $.post('guardarPkimp.jsp', { pkimp: pkimp }, function() {
        // Luego de guardar, abre la URL sin pasar el pkimp en la URL
        window.open('reportehorarios.jsp', '_blank');
    });
}); 
    $("#eliminartodo").on('click', function () {
        pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/horarios.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadohorariosajax() después de la operación exitosa
                listadohorariosajax();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#dias").val("0");
                $("#hora").val("");
                $("#horafin").val("");
                $("#doctor").val("0");
            }
        });
    });
});

function listadohorariosajax() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/horarios.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenadoshorarios(id, dias, hora, horafin, doctor) {
    $("#listar").val("modificar");
    $("#dias").val(dias);
    $("#hora").val(hora);
    $("#horafin").val(horafin);
    $("#doctor").val(doctor);
    $("#pk").val(id);
    $("#horainput").val(hora);
    $("#horafininput").val(horafin);
}

function validarFormulario() {
    var dias = $("#dias").val();
    var hora = $("#hora").val();
    var horafin = $("#horafin").val();
    var doctor = $("#doctor").val(); // Obtiene el valor seleccionado del doctor

    if (dias === "0") {
        mostrarAlerta("Por favor, complete el día.", "alert-danger");
        return false;
    } else if (hora === "") {
        mostrarAlerta("Por favor, complete la hora.", "alert-danger");
        return false;
    } else if (horafin === "") {
        mostrarAlerta("Por favor, complete la hora de fin.", "alert-danger");
        return false;
    } else if (doctor === "0") {
        mostrarAlerta("Por favor, seleccione un doctor.", "alert-danger");
        return false;
    } else {
        return true;
    }
}

function cargardoctores() {
    $.ajax({
        url: 'jsp/docnombre.jsp',
        type: 'post',
        success: function (response) {
            $("#doctor").html(response);
        }
    });
}

function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}