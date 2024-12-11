$(document).ready(function () {
    listadoAgendamientos();
    cargarcliente();
    cargardoctores();
    cargarPaciente();

    $("#botondep").on('click', function () {
        if (validarFormulario()) {
            var datosFormulario = $("#form").serialize();
            $.ajax({
                data: datosFormulario,
                url: 'jsp/agendamientos.jsp',
                type: 'post',
                success: function (response) {
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    listadoAgendamientos();
                    $("#fecha").val("");
                    $("#hora").val("");
                    $("#idclientes").val("0");
                    $("#iddoctores").val("0");
                    $("#idpaciente").val("0");
                    $("#pk").val("");
                }
            });
        } else {
            mostrarAlerta("Por favor, complete todos los campos.", "alert-danger");
        }
    });

    $("#eliminartodo").on('click', function () {
        var pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/agendamientos.jsp',
            type: 'post',
            success: function (response) {
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                listadoAgendamientos();
                $("#fecha").val("");
                $("#hora").val("");
                $("#idclientes").val("0");
                $("#iddoctores").val("0");
                $("#idpaciente").val("0");
                $("#pk").val("");
            }
        });
    });
});

function listadoAgendamientos() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/agendamientos.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

function validarFormulario() {
    var fecha = $("#fecha").val().trim();
    var hora = $("#hora").val().trim();
    var idclientes = $("#idclientes").val();
    var iddoctores = $("#iddoctores").val();
    var idpaciente = $("#idpaciente").val();

    if (fecha === "") {
        mostrarAlerta("Por favor, complete la fecha.", "alert-danger");
        return false;
    } else if (hora === "") {
        mostrarAlerta("Por favor, complete la hora.", "alert-danger");
        return false;
    } else if (idclientes === "0") {
        mostrarAlerta("Por favor, seleccione un cliente.", "alert-danger");
        return false;
    } else if (iddoctores === "0") {
        mostrarAlerta("Por favor, seleccione un doctor.", "alert-danger");
        return false;
    } else if (idpaciente === "0") {
        mostrarAlerta("Por favor, seleccione un paciente.", "alert-danger");
        return false;
    }

    return true;
}

function rellenadatos(pk, fecha, hora, clientes, doctores, paciente) {
    $("#pk").val(pk);
    $("#fecha").val(fecha);
    $("#hora").val(hora);
    $("#idclientes").val(clientes);
    $("#iddoctores").val(doctores);
    $("#idpaciente").val(paciente);
}

function cargarcliente() {
    $.ajax({
        url: 'jsp/cliinombre.jsp',
        type: 'post',
        success: function (response) {
            $("#idclientes").html(response);
        }
    });
}

function cargardoctores() {
    $.ajax({
        url: 'jsp/doctnombre.jsp',
        type: 'post',
        success: function (response) {
            $("#iddoctores").html(response);
        }
    });
}

function cargarPaciente() {
    $.ajax({
        url: 'jsp/pacnombre.jsp',
        type: 'post',
        success: function (response) {
            $("#idpaciente").html(response);
        }
    });
}
