<%@include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR"))) {
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/medicamentos.js"></script>
<style>
        

        .widget-box {
            background-color: #E0E6EF;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .form-group {
            flex: 0 0 48%; /* Ajuste del tamaño para que ocupen menos espacio */
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .text-center {
            text-align: center;
        }

        #botondep {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        #botondep:hover {
            background-color: #0056b3;
        }

        .alert {
            margin-top: 10px;
        }
    </style>
<!-- Modal para eliminar medicamento -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Eliminar Medicamento</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eliminar" action="#" method="post">
                    <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                    <p>¿Estás seguro de que deseas eliminar el medicamento?</p>
                    <input type="hidden" name="pkdel" id="pkdel">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" name="eliminartodo" id="eliminartodo" data-bs-dismiss="modal">Sí</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Impresión -->
<div class="modal fade" id="exampleModals" tabindex="-1" aria-labelledby="exampleModalLabels" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabels">IMPRIMIR DATOS MEDICAMENTOS</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="imprimir" action="#" method="post">
                    <input type="hidden" name="imprimir" id="imprimir" value="imprimir">
                    <p>¿Estás seguro de que deseas imprimir el registro?</p>
                    <input type="hidden" name="pkimp" id="pkimp">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" name="imprimirtodo" id="imprimirtodo" data-bs-dismiss="modal">Sí</button>
                    </div>
                </form>
            </div>
        </div> 
    </div>
</div>

<div class="container-fluid" style="background-color: #F0F4F8;">
    <hr>
    <div class="row justify-content-center">
    <div class="col-md-6">
        <div class="widget-box">
            <div class="widget-title text-center">
                <span class="icon"> <i class="icon-align-justify"></i> </span>
            </div>
            <div class="widget-content nopadding" style="background-color: #E0E6EF; padding: 15px;">
                <form action="#" method="get" class="form-horizontal" id="form">
                    <h5 class="text-center" style="font-size: 24px; font-family: 'Arial Black', Arial, sans-serif;"><b>Formulario Medicamentos</b></h5>
                    <input type="hidden" name="listar" id="listar" value="cargar">
                    <input type="hidden" name="pk" id="pk">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="nombre">Nombre del Medicamento</label>
                            <textarea class="form-control form-control-sm" name="nombre" id="nombre" placeholder="Ingrese el nombre del medicamento" onkeypress="return validarTexto(event)"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="vencimiento">Fecha de Vencimiento</label>
                            <input type="date" class="form-control form-control-sm" name="vencimiento" id="vencimiento">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="lote">Lote</label>
                            <input type="text" class="form-control form-control-sm" name="lote" id="lote" placeholder="Ingrese el número de lote" onkeypress="return validarTextoYNumeros(event)">
                        </div>
                        <div class="form-group">
                            <label for="codigodebarras">Código de Barras</label>
                            <input type="text" class="form-control form-control-sm" name="codigodebarras" id="codigodebarras" placeholder="Ingrese el código de barras" onkeypress="return validarTextoYNumeros(event)">
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="button" class="btn btn-primary btn-sm" id="botondep">Procesar</button>
                        <br>
                        <div id="mensaje" class="mt-2"></div>
                        <div id="mensajeAlerta" class="alert alert-danger mt-2" style="display: none;"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

    <br>

    <!-- Listado de Medicamentos -->
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="listado-columna">
                <div class="listado" style="background-color: #B3C6E7; padding: 15px;">
                    <h5 class="text-center">
                        <a href="listadomedicamentos.jsp" class="ms-2 text-decoration-none" title="Imprimir" target="_blank">LISTADO <i class="fas fa-print"></i></a>
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover table-sm text-center" id="resultado">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Fecha de Vencimiento</th>
                                    <th>Lote</th>
                                    <th>Código de Barras</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Aquí van los datos de la tabla -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function validarTexto(event) {
        var e = event || window.event;
        var tecla = e.keyCode || e.which;
        var teclado = String.fromCharCode(tecla);
        var input = e.target;
        var texto = input.value + teclado;
        if ((texto.length > 15) || ((teclado < 'A' || teclado > 'z') && teclado != "")) {
            e.preventDefault();
            return false;
        }
        return true;
    }

    function validarTextoYNumeros(event) {
        var e = event || window.event;
        var tecla = e.keyCode || e.which;
        var teclado = String.fromCharCode(tecla);
        var input = e.target;
        var texto = input.value + teclado;

        // Verificar si la longitud excede 15 caracteres o si la tecla no es una letra ni un número
        if ((texto.length > 15) || (!/^[a-zA-Z0-9]*$/.test(teclado))) {
            e.preventDefault();
            return false;
        }
        return true;
    }

    function validarFecha(event) {
        var input = event.target;
        var fecha = new Date(input.value);
        var anio = fecha.getFullYear();

        // Verificar si el año es 2024 o mayor y si el valor del campo contiene exactamente 4 dígitos en el año
        if (anio < 2024 || !/^\d{4}$/.test(input.value.split("-")[0])) {
            alert("El año debe ser 2024 o superior y contener exactamente 4 dígitos.");
            input.value = "";  // Limpiar el campo de fecha si no cumple con los requisitos
        }
    }

    // Asignar el evento onchange al campo de fecha
    document.getElementById('vencimiento').addEventListener('change', validarFecha);
</script>

<%@include file="footer.jsp" %>
<% } else {
        response.sendRedirect("dashboard.jsp");
    }
%>
