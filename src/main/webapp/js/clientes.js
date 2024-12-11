$(document).ready(function () {
    listadoclientesajax();
    cargarciudad();


    $("#botondep").on('click', function () {
        $("#nombre").val($("#nombre").val().toUpperCase().trim());
        $("#apellido").val($("#apellido").val().toUpperCase().trim());
        $("#ruc").val($("#ruc").val().toUpperCase().trim());
        $("#telefono").val($("#telefono").val().toUpperCase().trim());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
        $.ajax({
            data: datosformularios,
            url: 'jsp/clientes.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                listadoclientesajax();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#apellido").val("");
                $("#ruc").val("");
                $("#telefono").val("");
                $("#ciudad").val("0");
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
        window.open('reporteclientes.jsp', '_blank');
    });
}); 

    $("#eliminartodo").on('click', function () {
        pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/clientes.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                listadoclientesajax();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#apellido").val("");
                $("#ruc").val("");
                $("#telefono").val("");
                $("#ciudad").val("0");
            }
        });
    });
});


function listadoclientesajax() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/clientes.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenadosclien(id, nom, ape, ruc, tel, ciu) {
    $("#listar").val("modificar");
    $("#nombre").val(nom);
    $("#apellido").val(ape);
    $("#ruc").val(ruc);
    $("#telefono").val(tel);
    $("#ciudad").val(ciu);
    $("#pk").val(id);
}

function cargarciudad() {
    $.ajax({
        url: 'jsp/ciunombre.jsp',
        type: 'post',
        success: function (response) {
            $("#ciudad").html(response);
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
    var nombre = $("#nombre").val().trim();
    var apellido = $("#apellido").val().trim();
    var ruc = $("#ruc").val().trim();
    var telefono = $("#telefono").val().trim();
    var ciudad = $("#ciudad").val(); // Obtiene el valor seleccionado del departamento

    if (nombre === "") {
        mostrarAlerta("Por favor, complete el nombre.", "alert-danger");
        return false;
    } else {
        if (apellido === "") {
            mostrarAlerta("Por favor, complete el apellido.", "alert-danger");
            return false;
        } else {
            if (ruc === "") {
                mostrarAlerta("Por favor, complete el C.I.", "alert-danger");
                return false;
            } else {
                if (telefono === "") {
                    mostrarAlerta("Por favor, complete el telefono.", "alert-danger");
                    return false;
                } else {
                    if (ciudad === "0") {
                        mostrarAlerta("Por favor, seleccione una ciudad", "alert-danger");
                        return false;
                    } else {
                        return true;
                    }
                }
            }
        }
    }
}
