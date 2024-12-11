<%@include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR"))) {
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/clientes.js"></script>
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
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Eliminar Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eliminar" action="#" method="post">
                    <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                    <p>¿Estás seguro de que deseas eliminar el registro?</p>
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
                    <h1 class="modal-title fs-5" id="exampleModalLabels">IMPRIMIR DATOS CLIENTE</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="eliminar" action="#" method="post">
                        <input type="hidden" name="imprimir" id="imprimir" value="imprimir">
                        <div class="modal-body">
                            <p>¿Estás seguro de que deseas imprimir el registro?</p>
                            <input type="hidden" name="pkimp" id="pkimp">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" name="imprimirtodo" id="imprimirtodo" data-bs-dismiss="modal">Si</button>
                        </div>
                    </form>
                </div>
            </div> 
        </div>
    </div>
<div class="container-fluid" style="background-color: #F0F4F8;">
    <hr>

    <!-- Formulario de Clientes -->
    <div class="row justify-content-center">
    <div class="col-md-8"> <!-- Ancho del formulario -->
        <div class="widget-box">
            <div class="widget-title">
                <span class="icon"> <i class="icon-align-justify"></i> </span>
            </div>
            <div class="widget-content nopadding" style="background-color: #E0E6EF; padding: 20px;">
                <form action="#" method="get" class="form-horizontal" id="form">
                    <h5 class="text-center" style="font-size: 24px; font-family: 'Arial Black', Arial, sans-serif;"><b>Formulario Clientes</b></h5>

                    <input type="hidden" name="listar" id="listar" value="cargar">
                    <input type="hidden" name="pk" id="pk">

                    <div class="form-row"> <!-- Fila para Nombre y Apellido -->
                        <div class="form-group col-md-6"> <!-- Columna para el nombre -->
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control form-control-sm" name="nombre" id="nombre" placeholder="Ingrese el nombre" />
                        </div>
                        <div class="form-group col-md-6"> <!-- Columna para el apellido -->
                            <label for="apellido">Apellido</label>
                            <input type="text" class="form-control form-control-sm" name="apellido" id="apellido" placeholder="Ingrese el apellido" />
                        </div>
                    </div>

                    <div class="form-row"> <!-- Fila para Cédula y Teléfono -->
                        <div class="form-group col-md-6"> <!-- Columna para la cédula -->
                            <label for="ruc">Cédula</label>
                            <input type="text" class="form-control form-control-sm" name="ruc" id="ruc" placeholder="Ingrese la cédula" />
                        </div>
                        <div class="form-group col-md-6"> <!-- Columna para el teléfono -->
                            <label for="telefono">Teléfono</label>
                            <input type="text" class="form-control form-control-sm" name="telefono" id="telefono" placeholder="Ingrese el teléfono" />
                        </div>
                    </div>

                    <div class="form-group text-center"> <!-- Centrar el campo de ciudad -->
                        <label for="ciudad">Ciudad</label>
                        <select class="form-control form-control-sm" name="ciudad" id="ciudad"></select>
                    </div>

                    <div class="text-center">
                        <button type="button" class="btn btn-primary btn-sm" id="botondep">Procesar</button>
                        <div id="mensaje" class="mt-2"></div>
                        <div id="mensajeAlerta" class="alert alert-danger mt-2" style="display: none;"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

    <br>

    <!-- Listado de Clientes -->
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="listado-columna">
                <div class="listado" style="background-color: #B3C6E7; padding: 15px;">
                    <h5 class="text-center">
                        <a href="listadoclientes.jsp" class="ms-2 text-decoration-none" title="Imprimir" target="_blank">LISTADO  <i class="fas fa-print"></i></a>
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover table-sm" id="resultado">
                            <thead>
                                <tr class="text-center" >
                                    <th> ID </th>
                                    <th> Nombre </th>
                                    <th> Apellido </th>
                                    <th> C.I. </th>
                                    <th> Teléfono </th>
                                    <th> Cód. </th>
                                    <th> Ciudad </th>
                                    <th> Acción </th>
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
    // Función para validar que nombre y apellido no se repitan
    function validarNombreApellido() {
        var nombre = document.getElementById('nombre').value.trim();
        var apellido = document.getElementById('apellido').value.trim();
        var tabla = document.getElementById('resultado');
        var filas = tabla.getElementsByTagName('tr');

        for (var i = 0; i < filas.length; i++) {
            var celdas = filas[i].getElementsByTagName('td');
            var nombreTabla = celdas[1].textContent.trim();
            var apellidoTabla = celdas[2].textContent.trim();

            if (nombre === nombreTabla && apellido === apellidoTabla) {
                alert('El nombre y apellido ingresados ya existen en la tabla.');
                return false;
            }
        }

        return true;
    }

    // Asignar la validación al botón de procesar
    document.getElementById('botondep').addEventListener('click', function (event) {
        if (!validarNombreApellido()) {
            event.preventDefault(); // Evitar que se envíe el formulario si la validación falla
        }
    });

    // Validar solo texto
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

    // Validar solo números en cédula
    function validarRuc(event) {
        var e = event || window.event;
        var tecla = e.keyCode || e.which;
        var teclado = String.fromCharCode(tecla);
        var input = e.target;
        var texto = input.value + teclado;

        // Verificar que solo se ingresen números
        if (isNaN(teclado)) {
            e.preventDefault();
            return false;
        }

        // Verificar longitud máxima de 10 caracteres (para cédula)
        if (texto.length > 10) {
            e.preventDefault();
            return false;
        }

        return true;
    }
</script>

<%@include file="footer.jsp" %>
<% } else {
        response.sendRedirect("dashboard.jsp");
    }
%>
