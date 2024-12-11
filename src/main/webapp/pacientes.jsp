<%@include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR"))) {
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/pacientes.js"></script>
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
                <h5 class="modal-title" id="exampleModalLabel">Eliminar Paciente</h5>
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
<div class="modal fade" id="exampleModals" tabindex="-1" aria-labelledby="exampleModalLabels" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabels">IMPRIMIR DATOS PACIENTES</h1>
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

    <!-- Formulario de Pacientes -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon"> <i class="icon-align-justify"></i> </span>
                </div>
                <div class="widget-content nopadding" style="background-color: #E0E6EF; padding: 15px;">
                    <form action="#" method="get" class="form-horizontal" id="form">
                        <h5 class="text-center" style="font-size: 24px; font-family: 'Arial Black', Arial, sans-serif;"><b>Formulario Pacientes</b></h5>
                        <input type="hidden" name="listar" id="listar" value="cargar">
                        <input type="hidden" name="pk" id="pk">

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="nombre">Nombre</label>
                                <input type="text" class="form-control form-control-sm" onkeypress="return validarTexto(event)" name="nombre" id="nombre" placeholder="Ingrese el nombre" />
                            </div>
                            <div class="form-group col-md-6">
                                <label for="raza">Especie</label>
                                <select class="form-control form-control-sm" name="especie" id="especie"></select>
                                <input type="hidden" name="idespecies" id="idespecies" value="">
                            </div>

                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="raza">Raza</label>
                                <select class="form-control form-control-sm" name="raza" id="raza"></select>
                                <input type="hidden" name="idraza" id="idraza" value="">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="edad">Edad</label>
                                <input type="text" class="form-control form-control-sm" onkeypress="return validarRuc(event)" name="edad" id="edad" placeholder="Ingrese la edad" />
                            </div>

                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="sexo">Sexo</label>
                                <select id="sexo" name="sexo" class="form-control form-control-sm">
                                    <option value="0">Seleccione el sexo</option>
                                    <option value="MACHO">MACHO</option>
                                    <option value="HEMBRA">HEMBRA</option>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="peso">Peso</label>
                                <input type="text" class="form-control form-control-sm" onkeypress="return validarRuc(event)" name="peso" id="peso" placeholder="Ingrese el peso" />
                            </div>

                        </div>
                        <div class="text-center">
                            <label for="clientes">Clientes</label>
                            <div class="d-flex justify-content-center">
                                <select class="form-control form-control-sm text-center" name="clientes" id="clientes" style="width: 400px;"></select>
                            </div>
                        </div>

                        <br>
                        <div class="text-center">
                            <div class="text-center">
                                <button type="button" class="btn btn-primary btn-sm" id="botondep">Procesar</button>
                            </div>
                            <div class="text-center">
                                <div id="mensaje" class="mt-2"></div>
                                <div id="mensajeAlerta" class="alert alert-danger mt-2" style="display: none;"></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <br>

    <!-- Listado de Pacientes -->
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="listado-columna">
                <div class="listado" style="background-color: #B3C6E7; padding: 15px;">
                    <h5 class="text-center">

                        <a href="listadopacientes.jsp" class="ms-2 text-decoration-none" title="Imprimir" target="_blank">LISTADO  <i class="fas fa-print"></i></a>
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover table-sm" id="resultado">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Especie</th>
                                    <th>Raza</th>
                                    <th>Edad</th>
                                    <th>Sexo</th>
                                    <th>Peso</th>
                                    <th>Cod</th>
                                    <th>Clientes</th>
                                    <th style="text-align: center;">Acción</th>
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

        // Verificar longitud máxima de 3 caracteres (para edad y peso)
        if (texto.length > 3) {
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
