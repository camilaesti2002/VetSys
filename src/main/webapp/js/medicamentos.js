$(document).ready(function () {
    listadomedicamentos();


    $("#botondep").on('click', function () {
        $("#nombre").val($("#nombre").val().toUpperCase().trim());
        $("#vencimiento").val($("#vencimiento").val());
        $("#lote").val($("#lote").val().toUpperCase().trim());
        $("#codigodebarras").val($("#codigodebarras").val().toUpperCase().trim());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
            $.ajax({
                data: datosformularios,
                url: 'jsp/medicamentos.jsp',
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Llama a listadoclientesajax() después de la operación exitosa
                    listadomedicamentos();
                    // Restablece los campos del formulario
                    $("#listar").val("cargar");
                    $("#pk").val("");
                    $("#nombre").val("");
                    $("#vencimiento").val("");
                    $("#lote").val("");
                    $("#codigodebarras").val("");
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
        window.open('reportemedicamentos.jsp', '_blank');
    });
}); 
    $("#eliminartodo").on('click', function () {
        pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/pacientes.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                listadomedicamentos();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#raza").val("");
                $("#edad").val("");
                $("#sexo").val("0");
                $("#peso").val("");
                $("#clientes").val("0");
            }
        });
    });
});

function listadomedicamentos() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/medicamentos.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenadosmedicamentos(id, nom, raza, edad, sex, pes) {
    $("#listar").val("modificar");
    $("#nombre").val(nom);
    $("#vencimiento").val(raza);
    $("#lote").val(edad);
    $("#codigodebarras").val(sex);
    $("#pk").val(id);
}





function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

function validarFormulario() {
    var nombre = $("#nombre").val().trim();
    var raza = $("#vencimiento").val().trim();
    var edad = $("#lote").val().trim();
    var peso = $("#codigodebarras").val().trim();

    if (nombre === "") {
        mostrarAlerta("Por favor, complete el nombre.", "alert-danger");
        return false;
    } else {
        if (raza === "") {
            mostrarAlerta("Por favor, complete la fecha.", "alert-danger");
            return false;
        } else {
            if (edad === "") {
                mostrarAlerta("Por favor, complete el lote.", "alert-danger");
                return false;
            } else {
                if (peso === "") {
                    mostrarAlerta("Por favor, complete el codigo de barras", "alert-danger");
                    return false;
                } else {
                    return true;
                }
            }
        }
    }
}
