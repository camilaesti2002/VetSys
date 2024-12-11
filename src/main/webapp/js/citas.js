$(document).ready(function () {
    cargarcliente();  // Llenar lista de clientes
    rellenararticulo();  // Llenar lista de doctores
    $('#dias').on('change', function () {
    actualizarValores();
    actualizarFechasSegunDia();
});

$('#hora').on('blur', function () {
    actualizarValores();
});

function actualizarFechasSegunDia() {
    var selectedDay = $('#dias').val(); // Obtener el día seleccionado
    var dateInput = $('#fecharegistro')[0]; // Obtener el input de fecha

    // Si el día no es válido, no aplicar ninguna restricción
    if (selectedDay === '0') {
        dateInput.removeAttribute('min'); // Si no se seleccionó un día, eliminar restricción
        dateInput.removeAttribute('step'); // Eliminar también el atributo step (si lo hay)
        return;
    }

    // Definir los días de la semana válidos para cada día seleccionado
    var validDays = {
        'Lunes': 1,
        'Martes': 2,
        'Miércoles': 3,
        'Jueves': 4,
        'Viernes': 5,
        'Sábado': 6,
        'Domingo': 0
    };

    var selectedDayIndex = validDays[selectedDay]; // Obtener el índice del día seleccionado
    if (selectedDayIndex === undefined) {
        return; // Si no es un día válido, no hacer nada
    }

    // Establecer la fecha mínima para la entrada de fecha
    var today = new Date();
    var minDate = getNextDayOfWeek(today, selectedDayIndex);
    dateInput.setAttribute('min', minDate.toISOString().split('T')[0]); // Formato YYYY-MM-DD
    
    // Establecer la restricción de días de la semana
    dateInput.setAttribute('step', '7'); // Solo permite seleccionar una fecha que sea el mismo día de la semana

    // Validar si la fecha seleccionada coincide con el día de la semana
    var dateValue = dateInput.value; // Obtener el valor actual de la fecha
    if (dateValue) {
        var selectedDate = new Date(dateValue);
        var dayOfWeek = selectedDate.getDay(); // Obtener el día de la semana de la fecha seleccionada

        // Si el día de la semana seleccionado no coincide con el día seleccionado en el select, limpiar el campo
        if (dayOfWeek !== selectedDayIndex) {
            dateInput.value = ''; // Limpiar la fecha si no coincide
        }
    }
}

// Función para obtener el próximo día específico de la semana (lunes, martes, etc.)
function getNextDayOfWeek(startDate, dayOfWeek) {
    var resultDate = new Date(startDate); // Copiar la fecha actual
    resultDate.setDate(startDate.getDate() + (dayOfWeek - startDate.getDay() + 7) % 7); // Calcular la próxima fecha de ese día
    return resultDate;
}
function actualizarValores() {
    // Obtener los valores actuales
    var dia = $('#dias').val() || 'Sin seleccionar';
    var hora = $('#hora').val() || 'Sin seleccionar';
    
    // Mostrar los valores en el alert
    
    // Llamar a la función para cargar los médicos disponibles
    loadAvailableDoctors();
}
    $("#AgregaProductoVentas").click(function () {
    if (validarFormulario()) {
        var datosform = $("#form").serialize();

        // Agregar el parámetro 'listar=cargar' a la solicitud para la redirección condicional
        datosform += '&listar=cargar';

        $.ajax({
            data: datosform,
            url: 'jsp/insercioncitas.jsp',
            type: 'post',
            success: function (response) {
                $("#respuesta").html(response);

                // Verificar si la respuesta incluye un mensaje que indique éxito
                if (response.includes("Consulta registrada exitosamente")) {
                    // Si es exitosa y la condición del servidor es verdadera, redirigir
                    setTimeout(function() {
                        location.href = 'listadodecitas.jsp';
                    }, 3000); // 3000 milisegundos = 3 segundos
                }
            }
        });
    }
});


    // Escucha el cambio en el doctor
    $(document).on("change", "#idproducto", function () {
        var seleccion = $(this).val();
        dividirproducto(seleccion);
    });

    // Escucha los cambios de día y hora para cargar doctores disponibles
    $('#dias, #time').on('change', function() {
        loadAvailableDoctors();
    });

    function loadAvailableDoctors() {
    const selectedDay = $('#dias').val(); // Obtener el día seleccionado
    const selectedTime = $('#hora').val(); // Obtener la hora seleccionada

    // Limpiar y mostrar un mensaje mientras se cargan los doctores
    $('#idproducto').html('<option value="0">Cargando doctores...</option>');

    // Validar que se hayan seleccionado tanto día como hora
    if (selectedDay === '0' || !selectedTime) {
        $('#idproducto').html('<option value="0">Seleccione un día y hora válidos</option>');
        return;
    }

    // Llamada AJAX
    $.ajax({
        url: 'jsp/buscarclientes.jsp', // Archivo JSP que procesará la solicitud
        type: 'POST', // Método de la solicitud
        data: {
            listar: 'buscarDoctoresDisponibles', // Parámetro para identificar la operación
            dia: selectedDay, // Día seleccionado
            hora: selectedTime // Hora seleccionada
        },
        success: function (response) {
            // Validar si la respuesta está vacía
            if (!response.trim()) {
                $('#idproducto').html('<option value="0">No hay doctores disponibles en esta hora</option>');
            } else {
                // Actualizar el select con la respuesta del servidor
                $('#idproducto').html(response);
            }
        },
        error: function (xhr, status, error) {
            // Manejo de errores
            console.error("Error al cargar doctores:", error);
            $('#idproducto').html('<option value="0">Error al cargar doctores</option>');
        }
    });
}



    

   

    

    

    function validarFormulario() {
        var proveedor = $("#cliente").val();
        var ciudad = $("#idproducto").val();
        var hora = $("#hora").val();
        var fecharegistro = $("#fecharegistro").val();
        
        if (proveedor === "0") {
            mostrarAlerta("Por favor, seleccione un cliente", "alert-danger");
            return false;
        }
        if (fecharegistro === "") {
            mostrarAlerta("Por favor, complete la fecha", "alert-danger");
            return false;
        }
        if (ciudad === "0") {
            mostrarAlerta("Por favor, seleccione un doctor", "alert-danger");
            return false;
        }
        if (hora === "") {
            mostrarAlerta("Por favor, complete la hora", "alert-danger");
            return false;
        }
        return true;
    }

    function mostrarAlerta(mensaje, tipo) {
        $("#mensajeAlerta")
            .removeClass()
            .addClass("alert " + tipo)
            .text(mensaje)
            .show()
            .fadeOut(3000, function () {
                $(this).html("");
            });
    }
});

function rellenarcliente() {
    $.ajax({
        data: { listar: 'buscarcliente' },
        url: 'jsp/buscarcliente.jsp',
        type: 'post',
        success: function(response) {
            console.log(response);  // Ver la respuesta
            $("#cliente").html(response);
        },
        error: function(xhr, status, error) {
            console.log("Error en la solicitud AJAX: " + error);
        }
    });
}
function cargarcliente() {
    $.ajax({
        url: 'jsp/clinombres.jsp',
        type: 'post',
        success: function (response) {
            $("#cliente").html(response);
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

function rellenaralumno() {
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

function dividiralumno(a) {
    datos = a.split(',');
    $("#codalumno").val(datos[0]);
    $("#documento").val(datos[1]);
}