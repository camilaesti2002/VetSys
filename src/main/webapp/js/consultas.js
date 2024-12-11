$(document).ready(function () {
    listarcitas();
    buscarpendiente();
    rellenarcliente();
    rellenararticulo();
    rellenaranimal();
    rellenarsintomas();
    rellenarmedicamentos();
    mostrardetalles();

    $("#cliente").change(function () {
        var idCliente = $(this).val().split(',')[0];
        console.log("Cliente seleccionado: ", idCliente); // Agrega esta línea para verificar el idCliente
        cargarAnimales(idCliente);
    });
    $("#eliminarregistrodetalle").click(function () {
        var pk = $("#idpk").val();
        $.ajax({
            data: {listar: 'eliminardetalle', pk: pk},
            url: 'jsp/insercionventas.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                rellenararticulo();
                rellenarcliente();
                rellenaranimal();
                rellenarsintomas();
                rellenarmedicamentos();
                mostrardetalles();

            }
        });
    });

    $("#AgregaProductoVentas").click(function () {
        if (validarFormulario()) {
            var datosform = $("#form").serialize();
            $.ajax({
                data: datosform,
                url: 'jsp/insercionventas.jsp',
                type: 'post',
                beforeSend: function () {
                    //$("#resultado").html("Procesando, espere por favor...");
                },
                success: function (response) {
                    $("#respuesta").html(response);
                    mostrardetalles();
                    rellenaranimal();
                    rellenarsintomas();
                    rellenarmedicamentos();
                    mostrardetalles();
                }
            });
        }
    });

    $("#btn-cancelar").click(function () {
        $.ajax({
            data: {listar: 'cancelarventa'},
            url: 'jsp/insercionventas.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                location.href = 'listadodecitas.jsp';
            }
        });
    });

    $("#btn-finalizar").click(function () {
        if (validarFormularios()) {
            total = $("#txtTotalCompra").val();
            $.ajax({
                data: {listar: 'finalizarventa', total: total},
                url: 'jsp/insercionventas.jsp',
                type: 'post',
                beforeSend: function () {
                    //$("#resultado").html("Procesando, espere por favor...");
                },
                success: function (response) {
                    location.href = 'listadodecitas.jsp';
                }
            });
        }
        ;
    });


});


function rellenarcliente() {
    $.ajax({
        data: {listar: 'buscarcliente'},
        url: 'jsp/buscarcliente.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#cliente").html(response);
        }
    });
}

function rellenaranimal() {
    $.ajax({
        data: {listar: 'buscaranimal'},
        url: 'jsp/buscarcliente.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#animal").html(response);
        }
    });
}

function rellenararticulo() {
    $.ajax({
        data: {listar: 'buscarpropiedad'},
        url: 'jsp/buscarcliente.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#idproducto").html(response);
        }
    });
}

function rellenarsintomas() {
    $.ajax({
        data: {listar: 'buscarsintomas'},
        url: 'jsp/buscarcliente.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#sintomas").html(response);
        }
    });
}

function rellenarmedicamentos() {
    $.ajax({
        data: {listar: 'buscarmedicamentos'},
        url: 'jsp/buscarcliente.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#medicamentos").html(response);
        }
    });
}

function dividiralumno(a) {
    datos = a.split(',');
    $("#codalumno").val(datos[0]);
    $("#documento").val(datos[1]);
}

function dividirproducto(a) {
    datos = a.split(',');
    $("#codproducto").val(datos[0]);
}


function mostrardetalles() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/insercionventas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#carrito tbody").html(response);
            mostrartotales();
        }
    });
}


function mostrartotales() {
    $.ajax({
        data: {listar: 'mostrartotales'},
        url: 'jsp/insercionventas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#lbltotal").html(response);
            $("#txtTotalCompra").val(response);
        }
    });
}

function validarFormulario() {
    var proveedor = $("#cliente").val();
    var ciudad = $("#idproducto").val();
    if (proveedor === "0") {
        mostrarAlerta("Por favor, seleccione un cliente", "alert-danger");
        return false;
    } else {
        if (ciudad === "0") {
            mostrarAlerta("Por favor, seleccione un doctor", "alert-danger");
            return false;
        } else {
            return true;
        }
    }
}



function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(3000, function () {
        $("#mensajeAlerta").html("");
    });
}
function mostrarAlertas(mensaje, tipo) {
    $("#mensajeAlertas").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlertas").fadeOut(3000, function () {
        $("#mensajeAlertas").html("");
    });
}

function validarFormularios() {
    var total = $("#txtTotalCompra").val().trim();

    if (total === "") {
        mostrarAlertas("Por favor, agregue una venta", "alert-danger");
        return false;
    } else if (parseFloat(total) === 0) {
        mostrarAlertas("El total de la compra no puede ser cero", "alert-danger");
        return false;
    } else {
        return true;
    }
}

function buscarpendiente() {
    // Obtener el ID de la cita del modal
    var idCita = $("#idpk").val();

    $.ajax({
        data: { listar: 'buscarcliente', idconsulta: idCita },
        url: 'jsp/buscarpendiente.jsp',
        type: 'post',
        dataType: 'json',
        beforeSend: function () {
            console.log("Antes de la solicitud AJAX");
        },
        success: function (response) {
            console.log("Respuesta AJAX recibida:", response);
            
            // Comprobar si hay un error en la respuesta
            if (response.error) {
                console.error("Error en la respuesta:", response.error);
                return; // Detener si hay un error
            }

            // Comprobar si se recibieron los datos correctos
            if (response.clienteNombre && response.clienteDocumento) {
                setTimeout(function () {
                    // Rellenar y deshabilitar el select de cliente
                    $("#cliente").empty(); // Limpia el select primero
                    $("#cliente").append('<option value="0">Seleccione un cliente</option>');
                    $("#cliente").append('<option value="' + response.clienteDocumento + '">' + response.clienteNombre + '</option>');
                    $("#cliente").val(response.clienteDocumento);
                    $("#cliente").prop('disabled', true);

                    // Actualizar el campo de documento
                    $("#documento").val(response.clienteDocumento);
                    $("#documento").prop('disabled', true);

                    // Actualizar y deshabilitar el campo de fecha de registro
                    $("#fecharegistro").val(response.Fecha);
                    $("#fecharegistro").prop('disabled', true);

                    // Extraer y formatear la hora (HH:mm)
                    var horaFormateada = response.Hora ? response.Hora.substring(0, 5) : '';
                    $("#hora").val(horaFormateada);
                    $("#hora").prop('disabled', true);

                    // Actualizar y deshabilitar el campo de precio (total)
                    $("#precio").val(response.Total);
                    $("#precio").prop('disabled', true);

                    // Actualizar y deshabilitar el select de producto (usando el nombre del doctor como id de producto)
                    $("#idproducto").empty(); // Limpia el select primero
                    $("#idproducto").append('<option value="0">Seleccione un producto</option>');
                    $("#idproducto").append('<option value="' + response.doctorNombre + '">' + response.doctorNombre + '</option>');
                    $("#idproducto").val(response.doctorNombre);
                    $("#idproducto").prop('disabled', true);

                    console.log("Campos y select actualizados.");
                }, 500); // Retraso de 500 ms
            } else {
                // Si no hay pendientes, habilitar todos los campos/selects
                $("#cliente").prop('disabled', false);
                $("#documento").prop('disabled', false);
                $("#fecharegistro").prop('disabled', false);
                $("#hora").prop('disabled', false);
                $("#precio").prop('disabled', false);
                $("#idproducto").prop('disabled', false);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error en la solicitud AJAX:", error);
            // En caso de error, asegurarse de que los campos y selects no estén deshabilitados
            $("#cliente").prop('disabled', false);
            $("#documento").prop('disabled', false);
            $("#fecharegistro").prop('disabled', false);
            $("#hora").prop('disabled', false);
            $("#precio").prop('disabled', false);
            $("#idproducto").prop('disabled', false);
        }
    });
}

// Evento para redirigir a la página de consulta con el ID seleccionado
$(document).on('click', '#atender-cita', function() {
    // Obtener el ID del input en el modal
    var idCita = $("#idpk").val();
    
    // Redirigir a consulta.jsp con el ID como parámetro
    window.location.href = 'consulta.jsp?idconsulta=' + idCita;
});

function renelladoscitas(id, cli, ruc, tel, ciu) {
    console.log("renelladoscitas llamada con:", id, cli, ruc, tel, ciu);
    $("#listar").val("modificar");
    $("#cliente").val(cli);
    $("#fecharegistro").val(ruc);
    $("#idproducto").val(tel);
    $("#hora").val(ciu);
    $("#pk").val(id);
}

function listarcitas() {
    $.ajax({
        data: {listar: 'listarventas'},
        url: 'jsp/insercionventas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#resultadosventas").html(response);
        }
    });
}