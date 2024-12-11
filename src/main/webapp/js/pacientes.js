$(document).ready(function () {
    listadopacientes();
    cargarcliente();
    loadSpecies();
    loadBreed();
    
    $("#especie").on('change', function() {
    var specierId = $(this).val();
    loadBreed(specierId);
  });
    
    $("#botondep").on('click', function () {
        $("#nombre").val($("#nombre").val().toUpperCase().trim());
        $("#raza").val($("#raza").val().toUpperCase().trim());
        $("#edad").val($("#edad").val().toUpperCase().trim());
        $("#sexo").val($("#sexo").val().toUpperCase().trim());
        $("#peso").val($("#peso").val().toUpperCase().trim());
        if (validarFormulario()) {
            var datosformularios = $("#form").serialize();
        $.ajax({
            data: datosformularios,
            url: 'jsp/pacientes.jsp',
            type: 'post',
            success: function (response) {
                // Muestra el mensaje de confirmación
                $("#mensaje").html(response).fadeIn().delay(3500).fadeOut();
                // Llama a listadoclientesajax() después de la operación exitosa
                    listadopacientes();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#raza").val("0");
                $("#edad").val("");
                $("#sexo").val("0");
                $("#peso").val("");
                $("#clientes").val("0");
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
        window.open('reportepacientes.jsp', '_blank');
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
                listadopacientes();
                // Restablece los campos del formulario
                $("#listar").val("cargar");
                $("#pk").val("");
                $("#nombre").val("");
                $("#raza").val("0");
                $("#edad").val("");
                $("#sexo").val("0");
                $("#peso").val("");
                $("#clientes").val("0");
            }
        });
    });
});

function listadopacientes() {
    $.ajax({
        data: {listar: 'listar'},
        url: 'jsp/pacientes.jsp',
        type: 'post',
        success: function (response) {
            $("#resultado tbody").html(response);
        }
    });
}

function rellenadospac(id, nom, idraza, edad, sex, pes, cli) {
    console.log("ID:", id);
    console.log("Nombre:", nom);
    console.log("ID Raza:", idraza);
    console.log("Edad:", edad);
    console.log("Sexo:", sex);
    console.log("Peso:", pes);
    console.log("Cliente:", cli);
    
    $("#listar").val("modificar");
    $("#nombre").val(nom);
    $("#raza").val(idraza);
    $("#edad").val(edad);
    $("#sexo").val(sex);
    $("#peso").val(pes);
    $("#clientes").val(cli);
    $("#pk").val(id);
}




function cargarcliente() {
    $.ajax({
        url: 'jsp/clinombre.jsp',
        type: 'post',
        success: function (response) {
            $("#clientes").html(response);
        }
    });
}

function loadSpecies() {
  $.ajax({
    url: 'jsp/especienomb.jsp',
    type: 'post',
    success: function(response) {
      $("#especie").html(response);
      $("#especie").prop('disabled', false);
    }
  });
}

function loadBreed(specieId) {
  $.ajax({
    data: { specieId: specieId },
    url: 'jsp/razanom.jsp',
    type: 'post',
    success: function(response) {
      $("#raza").html(response);
      $("#raza").prop('disabled', specieId === '0');
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
    var raza = $("#raza").val().trim();
    var edad = $("#edad").val().trim();
    var sexo = $("#sexo").val().trim();
    var peso = $("#peso").val().trim();
    var clientes = $("#clientes").val(); // Obtiene el valor seleccionado del departamento

    if (nombre === "") {
        mostrarAlerta("Por favor, complete el nombre.", "alert-danger");
        return false;
    } else {
        if (raza === "0") {
            mostrarAlerta("Por favor, complete la raza.", "alert-danger");
            return false;
        } else {
            if (edad === "") {
                mostrarAlerta("Por favor, complete la edad.", "alert-danger");
                return false;
            } else {
                if (sexo === "0") {
                    mostrarAlerta("Por favor, complete el sexo.", "alert-danger");
                    return false;
                } else {
                if (peso === "") {
                    mostrarAlerta("Por favor, complete el peso.", "alert-danger");
                    return false;
                }else {
                    if (clientes === "0") {
                        mostrarAlerta("Por favor, seleccione un cliente", "alert-danger");
                        return false;
                    } else {
                        return true;
                    }
                }
            }
        }
    }
}
}
