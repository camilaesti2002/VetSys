$(document).ready(function () {
    listadousuariosajax();
    cargarpersonal();


    $("#botondep").on('click', function () {
        $("#nombre").val($("#nombre").val().toUpperCase().trim());
        $("#clave").val($("#clave").val().toUpperCase().trim());
       
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
        $.ajax({
            data: datosformularios,
            url: 'jsp/usuarios.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                    listadousuariosajax();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#clave").val("");
                $("#rol").val("0");
                $("#estado").val("0");
                $("#personales").val("0");
                    
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
        window.open('reporteusuarios.jsp', '_blank');
    });
}); 

    $("#eliminartodo").on('click', function () {
        pkdel = $("#pkdel").val();
        $.ajax({
            data: {listar: 'eliminar', pkdel: pkdel},
            url: 'jsp/usuarios.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                listadousuariosajax();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#clave").val("");
                $("#rol").val("0");
                $("#estado").val("0");
                $("#personales").val("0");
            }
        });
    });
});

function listadousuariosajax() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/usuarios.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenadosusuarios(id, nom, ape, ruc, tel, ciu) {
    $("#listar").val("modificar");
    $("#nombre").val(nom);
    $("#clave").val(ape);
    $("#rol").val(ruc);
    $("#estado").val(tel);
    $("#personales").val(ciu);
    $("#pk").val(id);
}



function cargarpersonal() {
    $.ajax({
        url: 'jsp/pernombre.jsp',
        type: 'post',
        success: function (response) {
            $("#personales").html(response);
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
    var clave = $("#clave").val().trim();
    var rol = $("#rol").val().trim();
    var estado = $("#estado").val().trim();
    var personales = $("#personales").val(); // Obtiene el valor seleccionado del departamento
    if (nombre === "") {
        mostrarAlerta("Por favor, complete el nombre.", "alert-danger");
        return false;
    } else {
        if (clave === "") {
            mostrarAlerta("Por favor, complete la clave.", "alert-danger");
            return false;
        } else {
            if (rol === "0") {
                mostrarAlerta("Por favor, complete el rol.", "alert-danger");
                return false;
            } else {
                if (estado === "0") {
                    mostrarAlerta("Por favor, complete el estado.", "alert-danger");
                    return false;
                } else {
                    if (personales === "0") {
                        mostrarAlerta("Por favor, seleccione un personal", "alert-danger");
                        return false;
                    } else {
                        return true;
                    }
                }
            }
        }
    }
}






