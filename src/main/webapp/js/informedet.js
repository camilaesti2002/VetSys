$(document).ready(function () {
    cargarcliente();
    
     $("#fin").prop("disabled", true);

    // Habilitar el campo 'fin' solo cuando 'inicio' tenga una fecha válida
    $("#inicio").on("change", function () {
        var inicio = $(this).val();

        if (inicio) {
            $("#fin").prop("disabled", false); // Habilitar el campo 'fin'
            $("#fin").attr("min", inicio);    // Establecer el mínimo en el campo 'fin'
        } else {
            $("#fin").prop("disabled", true); // Desactivar el campo 'fin'
            $("#fin").val("");               // Limpiar el campo 'fin'
        }
    });

    // Validar que 'fin' no sea menor que 'inicio'
    $("#fin").on("change", function () {
        var inicio = $("#inicio").val();
        var fin = $(this).val();

        if (fin && fin < inicio) {
            mostrarAlerta("La fecha final no puede ser anterior a la fecha inicial.", "alert-danger");
            $(this).val(""); // Limpiar el campo 'fin'
        }
    });
    $('#botondep').click(function () {
    if (validarFechas()) {
        mostrarInformeModal();
    }
});
$("#imprimirtodo").on('click', function () {
    var pkimps = $("#pkimps").val();
    var totalEnLetras = $("#totalEnLetras").val();

    console.log("Valor de pkimps:", pkimps);
    console.log("Valor de totalEnLetras:", totalEnLetras);

    if (totalEnLetras === "") {
        alert("El campo total en letras está vacío");
        return;
    }

    // Verifica el estado desde verificarEstado.jsp
    $.post('jsp/verificarEstado.jsp', { idpk: pkimps }, function (estado) {
        // Limpia el estado recibido eliminando espacios adicionales
        estado = estado.trim();
        console.log("Estado recibido (limpio):", estado);

        if (estado === "FINALIZADO") {
            $.post('guardarPkimps.jsp', { pkimps: pkimps, totalEnLetras: totalEnLetras }, function () {
                window.open('reporteventa.jsp', '_blank');
            });
        } else if (estado === "CANCELADO" || estado === "ANULADO" || estado === "OTRO") {
            $.post('guardarPkim.jsp', { pkimps: pkimps }, function () {
                window.open('reporteventas.jsp', '_blank');
            });
        } else {
            alert("Estado desconocido: " + estado);
        }
    }).fail(function () {
        alert("Error al verificar el estado.");
    });
});



});

const rowsPerPage = 5;
let currentPage = 1;
let allRows = [];

function mostrarInformeModal() {
    if (!document.querySelector('style[data-id="paginacion-modal"]')) {
        const style = document.createElement('style');
        style.setAttribute('data-id', 'paginacion-modal');
        style.textContent = `
#paginationInforme {
    display: flex;
    justify-content: center;
    margin-top: 20px;
    width: 300px;
    margin-left: auto;
    margin-right: auto;
}

#paginationInforme .page-link {
    border: 1px solid #ddd;
    padding: 5px 10px;
    margin: 0 5px;
    text-decoration: none;
    color: #4154f1;
    border-radius: 4px;
    font-size: 14px;
}

#paginationInforme .page-link.active {
    background-color: #4154f1;
    color: white;
    border: 1px solid #4154f1;
}

#informeModal .table-responsive {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    max-height: 400px; /* Altura máxima con scroll */
}

#informeModal .table-responsive table {
    width: 100%;
    min-width: 650px; /* Reducido de 750px */
}

/* Estilos para pantallas pequeñas (celulares) */
@media (max-width: 576px) {
    #resultadosInforme thead th {
        font-size: 10px;
        padding: 8px 4px; /* Padding reducido */
    }
    
    #resultadosInforme tbody td {
        font-size: 10px;
        padding: 8px 4px; /* Padding reducido */
    }
    
    #paginationInforme {
        width: 100%;
    }
    
    #paginationInforme .page-link {
        padding: 4px 8px;
        font-size: 12px;
    }
}

/* Estilos para pantallas medianas (tablets) */
@media (min-width: 576px) and (max-width: 768px) {
    #resultadosInforme thead th {
        font-size: 12px;
        padding: 8px 6px; /* Padding reducido */
    }
    
    #resultadosInforme tbody td {
        font-size: 12px;
        padding: 8px 6px; /* Padding reducido */
    }
}

#searchInforme {
    width: 200px;
    padding: 6px 10px; /* Padding reducido */
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    margin-bottom: 10px;
}

#informeModal .mensaje-alerta {
    margin-top: 10px;
    padding: 8px; /* Padding reducido */
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f8d7da;
    color: #721c24;
}`;
        document.head.appendChild(style);
    }

    const modalHTML = `
    <div class="modal fade" id="informeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg"> <!-- Cambiado de modal-xl a modal-lg -->
            <div class="modal-content">
                <div class="modal-header py-2"> <!-- Reduced padding -->
                    <h5 class="modal-title">Resultados del Informe</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-3"> <!-- Reduced padding -->
                    <section class="section dashboard">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body p-3"> <!-- Reduced padding -->
                                        <div class="table-responsive">
                                            <div class="d-flex justify-content-between mb-2"> <!-- Reduced margin -->
                                                <button type="button" class="btn btn-primary" onclick="generarReporte()">
                                                    Listado de Consultas
                                                </button>
                                        </div>
                                            <table class="table table-sm"> <!-- Added table-sm for more compact look -->
                                                <thead>
                                                    <tr>
                                                        <th>Doctor</th>
                                                        <th>Precio Consulta</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="resultadosInforme">
                                                </tbody>
                                            </table>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>`;

    if (!document.getElementById('informeModal')) {
        $('body').append(modalHTML);
        
        $('#searchInforme').on('input', function() {
            currentPage = 1;
            filterTable();
        });
    }
    
    $('#informeModal').on('hidden.bs.modal', function () {
            // Limpiar la tabla
            $("#resultadosInforme").empty();
            
            // Limpiar el campo de búsqueda
            $("#searchInforme").val('');
            
            // Reiniciar las variables de paginación
            currentPage = 1;
            allRows = [];
            
            // Limpiar la paginación
            $("#paginationInforme").empty();
            
            // Si tienes algún otro elemento que necesites limpiar, hazlo aquí
        });

    const filtros = {
        fechaInicio: $('#inicio').val(),
        fechaFin: $('#fin').val(),
        numeroFactura: $('#numero').val(),
        condicion: $('#condicion').val(),
        estado: $('#estado').val(),
        proveedor: $('#proveedores').val()
    };

    buscarCompras(filtros);

    const modal = new bootstrap.Modal(document.getElementById('informeModal'));
    modal.show();
}



function buscarCompras(filtros) {
    $.ajax({
        data: {
            listar: 'buscarInforme',
            ...filtros
        },
        url: 'jsp/buscarInformeVentasdetdoctores.jsp',
        type: 'post',
        success: function(response) {
            $("#resultadosInforme").html(response);
            // Verificar si hay filas en la respuesta (excluyendo el mensaje de no resultados)
            const rowCount = $("#resultadosInforme tr").not('.no-results-row').length;
            
            if (rowCount === 0) {
                // Si no hay resultados, mostrar mensaje
                $("#resultadosInforme").html(`
                    <tr class="no-results-row text-center">
                        <td colspan="8" class="py-3">
                            <strong>No se encontraron registros con los datos especificados</strong>
                        </td>
                    </tr>
                `);
            } else {
                // Si hay resultados, proceder con la paginación
                allRows = Array.from($("#resultadosInforme tr"));
                paginate(allRows);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error al buscar compras:", error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Ocurrió un error al buscar las compras'
            });
        }
    });
}

function renderTable(rows) {
    const tbody = $("#resultadosInforme"); // Corregido el ID del tbody
    tbody.empty();
    rows.forEach(row => {
        tbody.append(row);
    });
}

function paginate(rows) {
    const totalRows = rows.length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);
    const start = (currentPage - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    const paginatedRows = rows.slice(start, end);

    renderTable(paginatedRows);
    renderPagination(totalPages);
}

function renderPagination(totalPages) {
    const pagination = $("#paginationInforme"); // Corregido el ID de la paginación
    pagination.empty();

    // Botón Anterior
    const prevButton = $('<a href="#" class="page-link">Anterior</a>');
    prevButton.on('click', function(e) {
        e.preventDefault();
        if (currentPage > 1) {
            currentPage--;
            filterTable();
        }
    });
    pagination.append(prevButton);

    // Números de página
    for (let i = 1; i <= totalPages; i++) {
        const pageItem = $('<a href="#" class="page-link"></a>').text(i);
        if (i === currentPage) {
            pageItem.addClass('active');
        }
        pageItem.on('click', function (e) {
            e.preventDefault();
            currentPage = i;
            filterTable();
        });
        pagination.append(pageItem);
    }

    // Botón Siguiente
    const nextButton = $('<a href="#" class="page-link">Siguiente</a>');
    nextButton.on('click', function(e) {
        e.preventDefault();
        if (currentPage < totalPages) {
            currentPage++;
            filterTable();
        }
    });
    pagination.append(nextButton);
}

function filterTable() {
    const searchTerm = $('#searchInforme').val().toLowerCase(); // Corregido el ID del input de búsqueda
    const filteredRows = allRows.filter(row => {
        const cells = row.getElementsByTagName('td');
        for (let i = 0; i < cells.length; i++) {
            const cellText = cells[i].textContent.toLowerCase();
            if (cellText.includes(searchTerm)) {
                return true;
            }
        }
        return false;
    });
    paginate(filteredRows);
}

function cargarcliente() {
    $.ajax({
        url: 'jsp/doctordet.jsp',
        type: 'post',
        success: function (response) {
            $("#proveedores").html(response);
        }
    });
};


function mostrarAlerta(mensaje, tipo) {
    $("#mensajeAlerta").removeClass().addClass("alert " + tipo).text(mensaje).show();
    $("#mensajeAlerta").fadeOut(7000, function () {
        $("#mensajeAlerta").html("");
    });
}

function validarFechas() {
    var inicio = $("#inicio").val().trim();
    var fin = $("#fin").val().trim();

    if ((inicio === "" && fin !== "") || (inicio !== "" && fin === "")) {
        mostrarAlerta("Por favor, complete ambos campos de fecha o deje ambos vacíos.", "alert-danger");
        return false;
    }
    return true;
}

function construirParametrosURL() {
    const params = new URLSearchParams();
    
    // Obtener todos los filtros
    const fechaInicio = $('#inicio').val();
    const fechaFin = $('#fin').val();
    const numeroFactura = $('#numero').val();
    const condicion = $('#condicion').val();
    const estado = $('#estado').val();
    const proveedor = $('#proveedores').val();
    
    // Añadir solo los filtros que tienen valor
    if (fechaInicio) params.append('fechaInicio', fechaInicio);
    if (fechaFin) params.append('fechaFin', fechaFin);
    if (numeroFactura) params.append('numeroFactura', numeroFactura);
    if (condicion) params.append('condicion', condicion);
    if (estado) params.append('estado', estado);
    if (proveedor) params.append('proveedor', proveedor);
    
    return params.toString();
}

function generarReporte() {
    const params = construirParametrosURL();
    window.open(`reportesventasdet.jsp?${params}`, '_blank');
}