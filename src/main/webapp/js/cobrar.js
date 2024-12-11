$(document).ready(function () {
    cargarfacnumero();
    listarcitasfin();
    rellenarcliente();
    rellenararticulo();
    rellenaranimal();
    rellenarsintomas();
    rellenarmedicamentos();
    mostrardetalles();
    cargarmetodo();
    cargarbanco();
    $("#eliminar-registro-venta").click(function () {
        idpk = $("#idpk").val();
        $.ajax({
            data: {listar: 'anularventa', idpk: idpk},
            url: 'jsp/insercionventas.jsp',
            type: 'post',
            beforeSend: function () {
                //$("#resultado").html("Procesando, espere por favor...");
            },
            success: function (response) {
                listarcitas();
            }
        });
    });


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
        var idconsulta = $("#idconsulta").val();
        $.ajax({
            data: {listar: 'cancelarventa', idconsulta: idconsulta},
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
            var idconsulta = $("#idconsulta").val();
            total = $("#txtTotalCompra").val();
            var condicion = $("#condicion").val();
            var numerofac = $("#numerofac").val();
            $.ajax({
                data: {listar: 'finalizarventa', total: total, idconsulta: idconsulta, numerofac:numerofac ,condicion:condicion},
                url: 'jsp/insercionventas.jsp',
                type: 'post',
                beforeSend: function () {
                    //$("#resultado").html("Procesando, espere por favor...");
                },
                success: function (response) {
                    location.href = 'cobrar.jsp';
                }
            });
        }
        ;
    });
    
    
   $('#metodoPagoModal').on('show.bs.modal', function () {
    // Set the montoPago input value to the text of lbltotal, trimmed to remove any spaces
    $('#montoPago').val($('#lbltotal').text().trim());
});

    
    $("#btn-finalizarz").click(function () {
    // Mostrar el modal para confirmar el pago
    $('#metodoPagoModal').modal('show');
    
    $("#btnConfirmarPago").click(function () {
        // Obtener los valores del método de pago
        const metodoPago = $("#metodo").val();
        let bancoPago = $("#banco").val();
        
        // Ocultar mensaje de error previo
        $("#mensajeAlertaz").hide();
        
        // Validar método de pago
        if (!metodoPago || metodoPago === '') {
            mostrarError('Debe seleccionar un método de pago');
            return false;
        }
        
        // Si es transferencia (2), validar banco
        if (metodoPago === '2' && (!bancoPago || bancoPago === '0' || bancoPago === '')) {
            mostrarError('Debe seleccionar un banco para transferencias');
            return false;
        }
        
        if (metodoPago === '1' || !bancoPago) {
            bancoPago = null;
        }
        
        $('#metodoPagoModal').modal('hide');
        
        if (validarFormularios()) {
            const idconsulta = $("#idconsulta").val();
            const total = $("#txtTotalCompra").val();
            const condicion = $("#condicion").val();
            const numerofac = $("#numerofac").val();
            
            $.ajax({
                data: {
                    listar: 'finalizarventas',
                    total: total,
                    idconsulta: idconsulta,
                    numerofac: numerofac,
                    condicion: condicion,
                    metodoPago: metodoPago,
                    bancoPago: metodoPago === '2' ? bancoPago : '0'
                },
                url: 'jsp/insercionventas.jsp',
                type: 'post',
                success: function (response) {
                    console.log("Respuesta del servidor:", response); // Para debug
                    
                    // Limpiar la respuesta de espacios en blanco y saltos de línea
                    const cleanResponse = response.trim().replace(/[\n\r]/g, '');
                    
                    if (cleanResponse.includes('alert alert-success')) {
                        location.href = 'citasfinalizadas.jsp';
                    } else if (cleanResponse.includes('alert alert-danger')) {
                        // Extraer el mensaje de error de la respuesta
                        const tempDiv = document.createElement('div');
                        tempDiv.innerHTML = cleanResponse;
                        const errorText = tempDiv.textContent || tempDiv.innerText;
                        alert(errorText);
                    } else {
                        alert('Hubo un error al procesar la consulta');
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error AJAX:", error);
                    console.error("Estado:", status);
                    console.error("Respuesta:", xhr.responseText);
                    
                    alert('Error al procesar la consulta: ' + error);
                }
            });
        }
    });
});

// Función auxiliar para mostrar errores
function mostrarError(mensaje) {
    $("#mensajeAlertaz").html(mensaje).show();
}


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
    // Obtener el ID del cliente directamente
    var idclientes = $("#idclientes").val();
    
    // Validar que haya un cliente seleccionado
    if(!idclientes) {
        $("#animal").html('<option value="">Seleccione un cliente primero</option>');
        return;
    }
    
    // Hacer la petición AJAX simplificada
    $.post("jsp/buscaranimal.jsp", {
        idclientes: idclientes,
        listar: 'buscaranimal'
    })
    .done(function(data) {
        $("#animal").html(data);
    })
    .fail(function() {
        $("#animal").html('<option value="">Error al cargar los animales</option>');
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
    // Hacer la petición AJAX simplificada
    $.post("jsp/buscarsintomas.jsp", {
        listar: 'buscarsintomas'
    })
    .done(function(data) {
        $("#sintomas").html(data);
    })
    .fail(function() {
        $("#sintomas").html('<option value="">Error al cargar los síntomas</option>');
    });
}

function rellenarmedicamentos() {
    // Hacer la petición AJAX simplificada
    $.post("jsp/buscarmedicamentos.jsp", {
        listar: 'buscarmedicamentos'
    })
    .done(function(data) {
        $("#medicamentos").html(data);
    })
    .fail(function() {
        $("#medicamentos").html('<option value="">Error al cargar los medicamentos</option>');
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
    var idconsulta = $("#idconsulta").val();
    $.ajax({
        data: {listar: 'listars', idconsulta: idconsulta},
        url: 'jsp/insercionventas.jsp',
        type: 'post',
        beforeSend: function () {
            //$("#resultado").html("Procesando, espere por favor...");
        },
        success: function (response) {
            $("#resultados").html(response);
            mostrartotales();
        }
    });
}


function mostrartotales() {
    var idconsulta = $("#idconsulta").val();
    $.ajax({
        data: {listar: 'mostrartotales', idconsulta: idconsulta},
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


// Evento para redirigir a la página de consulta con el ID seleccionado
document.addEventListener('DOMContentLoaded', function () {
    var atenderCitaButton = document.getElementById('atender-cita');
    if (atenderCitaButton) {
        atenderCitaButton.addEventListener('click', function () {
            var idpk = document.getElementById('idpk').value;
            if (idpk) {
                // Redirige a consulta.jsp con el parámetro idpk
                window.location.href = 'consulta.jsp?idpk=' + encodeURIComponent(idpk);
            }
        });
    }
});

// Evento para redirigir a la página de consulta con el ID seleccionado
document.addEventListener('DOMContentLoaded', function () {
    var atenderCitaButton = document.getElementById('cobrar-cita');
    if (atenderCitaButton) {
        atenderCitaButton.addEventListener('click', function () {
            var idpk = document.getElementById('idpk').value;
            if (idpk) {
                // Redirige a consulta.jsp con el parámetro idpk
                window.location.href = 'cobrarfin.jsp?idpk=' + encodeURIComponent(idpk);
            }
        });
    }
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

function listarcitasfin() {
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

function cargarfacnumero() {
        $.ajax({
            url: 'jsp/buscarnumerofac.jsp',
            type: 'post',
            success: function (response) {
                // Actualiza el valor del input con el último ven_numero
                $("#numerofac").val(response.trim());
            },
            error: function (xhr, status, error) {
                console.error("Error al cargar el número de factura: " + status + " - " + error);
            }
        });
    }
    
    function cargarmetodo() {
    $.ajax({
        url: 'jsp/metodonombre.jsp', // Ruta a tu archivo JSP que maneja la obtención de departamentos
        type: 'post',
        success: function (response) {
            $("#metodo").html(response);
        }
    });
}

function cargarbanco() {
    $.ajax({
        url: 'jsp/banconombre.jsp', // Ruta a tu archivo JSP que maneja la obtención de departamentos
        type: 'post',
        success: function (response) {
            $("#banco").html(response);
        }
    });
}