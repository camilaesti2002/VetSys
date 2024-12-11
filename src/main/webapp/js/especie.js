$(document).ready(function () {
    listadoespecie(); // Función para cargar inicialmente el listado de síntomas

    $("#botondep").on('click', function () {
        $("#nombre").val($("#nombre").val().toUpperCase().trim());
       
        if (validarFormulario()) {
            var datosFormulario = $("#form").serialize();
            $.ajax({
                data: datosFormulario,
                url: 'jsp/especie.jsp', // URL del archivo JSP para manejar los síntomas
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Vuelve a cargar el listado de síntomas después de la operación exitosa
                    listadoespecie();
                    // Restablece los campos del formulario
                    $("#listar").val("cargar");
                    $("#pk").val("");
                    $("#nombre").val("");
                    
                }
            });
        } else {
            // Mostrar alerta de validación
        }
    });
$("#imprimirtodo").on('click', function () {
    var pkimp = $("#pkimp").val(); // Obtén el valor del input hidden
    
    // Envía el pkimp al servidor usando POST
    $.post('guardarPkimp.jsp', { pkimp: pkimp }, function() {
        // Luego de guardar, abre la URL sin pasar el pkimp en la URL
        window.open('reportespecie.jsp', '_blank');
    });
}); 

    $("#eliminartodo").on('click', function () {
        var pkdel = $("#pkdel").val();
        $.ajax({
            data: { listar: 'eliminar', pkdel: pkdel },
            url: 'jsp/especie.jsp', // URL del archivo JSP para manejar los síntomas
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Vuelve a cargar el listado de síntomas después de la operación exitosa
                listadoespecie();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
               
            }
        });
    });
   
});

// Función para cargar el listado de síntomas utilizando AJAX
function listadoespecie() {
    $.ajax({
        data: { listar: 'listar' }, // Parámetro específico para listar síntomas en el archivo JSP correspondiente
        url: 'jsp/especie.jsp', // URL del archivo JSP para manejar los síntomas
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response); // Actualiza el cuerpo de la tabla con los datos recibidos
        }
    });
}

// Función para prellenar los campos del formulario de síntomas para modificar
function rellenarespecie(id, nom) {
    $("#listar").val("modificar");
    $("#nombre").val(nom);
   
    $("#pk").val(id);
}

// Función para mostrar alertas
function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

// Función para validar el formulario de síntomas
function validarFormulario() {
    var nombre = $("#nombre").val().trim();
   

    if (nombre === "") {
        mostrarAlerta("Por favor, complete el nombre de la especie.", "alert-danger");
        return false;
    } else {
        return true;
    }
}








