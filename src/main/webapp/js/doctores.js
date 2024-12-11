$(document).ready(function () {
    listadodoctores();


    $("#botondep").on('click', function () {
        $("#nombre").val($("#nombre").val().toUpperCase().trim());
        $("#telefono").val($("#telefono").val().toUpperCase().trim());
        $("#correo").val($("#correo").val().toUpperCase().trim());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
        $.ajax({
            data: datosformularios,
            url: 'jsp/doctores.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                    listadodoctores();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#telefono").val("");
                $("#correo").val("");
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
        window.open('reportedoctores.jsp', '_blank');
    });
}); 


    $("#eliminartodo").on('click', function () {
        pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/doctores.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                listadodoctores();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#telefono").val("");
                $("#correo").val("");
            }
        });
    });
});

function listadodoctores() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/doctores.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenadosclien(id, nom, ape, ruc) {
    $("#listar").val("modificar");
    $("#nombre").val(nom);
    $("#telefono").val(ape);
    $("#correo").val(ruc);
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
    var telefono = $("#telefono").val().trim();
    var correo = $("#correo").val().trim();
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (nombre === "") {
        mostrarAlerta("Por favor, complete el nombre.", "alert-danger");
        return false;
    } else if (telefono === "") {
        mostrarAlerta("Por favor, complete el telefono.", "alert-danger");
        return false;
    } else if (correo === "") {
        mostrarAlerta("Por favor, complete el correo.", "alert-danger");
        return false;
    } else if (!emailRegex.test(correo)) {
        mostrarAlerta("Por favor, ingrese un correo electrónico válido.", "alert-danger");
        return false;
    } else {
        return true;
    }
}


