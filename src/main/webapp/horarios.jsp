<%@include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR"))) {
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/horarios.js"></script>
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
                <h5 class="modal-title" id="exampleModalLabel">Eliminar Horario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eliminar" action="#" method="post">
                    <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                    <p>¿Estás seguro de que deseas eliminar el horario?</p>
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
                    <h1 class="modal-title fs-5" id="exampleModalLabels">IMPRIMIR DATOS HORARIOS</h1>
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

    <!-- Formulario de Horarios -->
    <div class="row">
    <div class="col-md-8 offset-md-2">
        <div class="widget-box">
            <div class="widget-title">
                <span class="icon"> <i class="icon-align-justify"></i> </span>
            </div>
            <div class="widget-content nopadding">
                <form action="#" method="get" class="form-horizontal" id="form">
                    <h5 class="text-center" style="font-size: 24px; font-family: 'Arial Black', Arial, sans-serif;"><b>Formulario Horarios</b></h5>
                    <input type="hidden" name="listar" id="listar" value="cargar">
                    <input type="hidden" name="pk" id="pk">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="dias">Día</label>
                            <select name="dias" id="dias" class="form-control">
                                <option value="0">Seleccione un día</option>
                                <option value="Lunes">Lunes</option>
                                <option value="Martes">Martes</option>
                                <option value="Miércoles">Miércoles</option>
                                <option value="Jueves">Jueves</option>
                                <option value="Viernes">Viernes</option>
                                <option value="Sábado">Sábado</option>
                                <option value="Domingo">Domingo</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="hora">Hora Inicio</label>
                            <input type="time" class="form-control" name="hora" id="hora" placeholder="Ingrese la hora" />
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="horafin">Hora Fin</label>
                            <input type="time" class="form-control" name="horafin" id="horafin" placeholder="Ingrese la hora" />
                        </div>
                        <div class="form-group">
                            <label for="doctor">Doctor</label>
                            <select class="form-control" name="doctor" id="doctor"></select>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="button" class="btn btn-primary" id="botondep">Procesar</button>
                        <div id="mensaje" class="mt-2"></div>
                        <div id="mensajeAlerta" class="alert alert-danger mt-2" style="display: none;"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

    <br>

    <!-- Listado de Horarios -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="listado-columna">
                <div class="listado" style="background-color: #B3C6E7; padding: 20px;">
                  <h5 class="text-center">
                        <a href="listadohorarios.jsp" class="ms-2 text-decoration-none" title="Imprimir" target="_blank">LISTADO  <i class="fas fa-print"></i></a>
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" id="resultado">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Día</th>
                                    <th>Hora Inicio</th>
                                    <th>Hora Fin</th>
                                    <th>Doctor</th>
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
    // Tu código JavaScript aquí
</script>

<%@include file="footer.jsp" %>
<% } else {
        response.sendRedirect("dashboard.jsp");
    }
%>
