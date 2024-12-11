$(document).ready(function () {
    listadoServicios(); // Función para cargar inicialmente el listado de servicios

    $("#botondep").on('click', function () {
        $("#descripcion").val($("#descripcion").val().toUpperCase().trim());
        $("#precio").val($("#precio").val().trim());
        $("#iva").val($("#iva").val().trim());

        if (validarFormulario()) {
            var datosFormulario = $("#form").serialize();
            $.ajax({
                data: datosFormulario,
                url: 'jsp/servicios.jsp', // URL del archivo JSP para manejar los servicios
                type: 'post',
                success: function (response) {
                    // Muestra el mensaje de confirmación
                    $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                    // Vuelve a cargar el listado de servicios después de la operación exitosa
                    listadoServicios();
                    // Restablece los campos del formulario
                    $("#listar").val("cargar");
                    $("#pk").val("");
                    $("#descripcion").val("");
                    $("#precio").val("");
                    $("#iva").val("");
                }
            });
        } else {
            // Mostrar alerta de validación
        }
    });

    $("#eliminartodo").on('click', function () {
        var pkdel = $("#pkdel").val();
        $.ajax({
            data: { listar: 'eliminar', pkdel: pkdel },
            url: 'jsp/servicios.jsp', // URL del archivo JSP para manejar los servicios
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Vuelve a cargar el listado de servicios después de la operación exitosa
                listadoServicios();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#descripcion").val("");
                $("#precio").val("");
                $("#iva").val("");
            }
        });
    });
});

// Función para cargar el listado de servicios utilizando AJAX
function listadoServicios() {
    $.ajax({
        data: { listar: 'listar' }, // Parámetro específico para listar servicios en el archivo JSP correspondiente
        url: 'jsp/servicios.jsp', // URL del archivo JSP para manejar los servicios
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response); // Actualiza el cuerpo de la tabla con los datos recibidos
        }
    });
}

// Función para prellenar los campos del formulario de servicios para modificar
function rellenarServicios(id, desc, precio, iva) {
    $("#listar").val("modificar");
    $("#descripcion").val(desc);
    $("#precio").val(precio);
    $("#iva").val(iva);
    $("#pk").val(id);
}

// Función para mostrar alertas
function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

// Función para validar el formulario de servicios
function validarFormulario() {
    var descripcion = $("#descripcion").val().trim();
    var precio = $("#precio").val().trim();
    var iva = $("#iva").val().trim();

    if (descripcion === "") {
        mostrarAlerta("Por favor, complete la descripcion del servicio.", "alert-danger");
        return false;
    } else if (precio === "" || isNaN(precio)) {
        mostrarAlerta("Por favor, ingrese un precio válido.", "alert-danger");
        return false;
    } else if (iva === "" || isNaN(iva)) {
        mostrarAlerta("Ingrese un Iva valido");
        return false;
    } else {
        return true;
    }
}


