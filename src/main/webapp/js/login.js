$(document).ready(function () {
    $("#ValidarInicio").click(function () {
        // Convertir el valor del campo user a mayúsculas y eliminar espacios en blanco al principio y al final
        $("#user").val($("#user").val().toUpperCase().trim());
        $("#pswrd").val($("#pswrd").val().toUpperCase().trim());
        
        // Validar el formulario antes de enviar
        if (validarFormulario()) {
            // Serializar los datos del formulario
            var dataform = $("#form").serialize();

            // Enviar los datos mediante una petición AJAX
            $.ajax({
                data: dataform,
                url: 'jsp/login.jsp',
                type: 'post',
                beforeSend: function () {
                    // Código opcional antes de enviar la petición
                    // $("#resultado").html("Procesando, espere por favor...");
                },
                success: function (response) {
                    // Verificar respuesta del servidor
                    if (response.trim() === "DATOS CORRECTOS") {
                        // Redirigir al dashboard después del inicio de sesión exitoso
                        window.location.href = 'dashboard.jsp';
                    } else {
                        // Mostrar mensaje de error con SweetAlert
                        mostrarAlerta("DATOS INCORRECTOS", "error");
                    }
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText); // Log del error en la consola
                    mostrarAlerta("Ha ocurrido un error al procesar la solicitud.", "error");
                }
            });
        }
    });
});

function validarFormulario() {
    var usuario = $("#user").val().trim();
    var contra = $("#pswrd").val();
    if (usuario === "") {
        mostrarAlerta("Por favor, complete el nombre.", "warning");
        return false;
    } else if (contra === "") {
        mostrarAlerta("Por favor, complete la contraseña.", "warning");
        return false;
    } else {
        return true;
    }
}

function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(5000, function () {
        $("#mensajeAlerta").html("");
    });
}

