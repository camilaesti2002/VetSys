<%@ include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && (sesion.getAttribute("tipo").equals("DOCTOR") || sesion.getAttribute("tipo").equals("ADMINISTRADOR")))) {
%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/citas.js"></script>
<main id="main" class="main">
    <div class="container-fluid">
        <!-- Modal de eliminar detalle -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">ELIMINAR DETALLE</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="eliminar" action="#" method="post">
                        <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                        <div class="modal-body">
                            <p>¿Estás seguro de que deseas eliminar el registro?</p>
                            <input type="hidden" name="idpk" id="idpk">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" name="eliminarregistrodetalle" id="eliminarregistrodetalle" data-bs-dismiss="modal">Si</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal de eliminar cita -->
        <div class="modal fade" id="exampleModalCita" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">ELIMINAR CITA</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas eliminar la cita?</p>
                        <input type="hidden" name="idpk" id="idpkCita">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" name="eliminar-registro-venta" id="eliminar-registro-venta" data-bs-dismiss="modal">Si</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Formulario de consulta -->
        <section class="content" style="margin-top: 40px;">
            <form id="form" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                <input type="hidden" id="listar" name="listar" value="cargar" />
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card form-card" style="background-color: #B3C6E7;">
                            <div class="card-body">
                                <h5 class="card-title" style="font-size: 18px; font-family: Arial, sans-serif;">Consulta</h5>

                                <div class="form-group">
                                    <label for="cliente" class="control-label">Cliente</label>
                                    <select class="form-control normal-select" name="cliente" id="cliente" onchange="dividiralumno(this.value)">
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="documento" class="control-label">Documento</label>
                                    <input type="hidden" id="codalumno" name="codalumno">
                                    <input class="form-control" type="text" name="documento" id="documento" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>
                                    <small><span class="symbol required"></span></small>
                                </div>
                                <div class="form-group">
                                    <label for="precio" class="control-label">Cobro por Consulta <span class="symbol required"></span></label>
                                    <input class="form-control" value="100000" type="text" name="precio" id="precio" autocomplete="off" placeholder="Precio" required onkeyup="puntitos(this, this.value.charAt(this.value.length - 1))" readonly="readonly">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card form-card" style="background-color: #B3C6E7;">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fa fa-archive"></i> Datos del Médico</h5>
                                <div id="error"></div>
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
                                    <label class="control-label">Hora</label>
                                    <input type="time" name="hora" id="hora" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="idproducto" class="control-label">Médico <span class="symbol required"></span></label>
                                    <input type="hidden" id="codproducto" name="codproducto">
                                    <select class="form-control normal-select" name="idproducto" id="idproducto" >
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="fecharegistro" class="control-label">Fecha de Cita</label>
                                    <input class="form-control" type="date" name="fecharegistro" id="fecharegistro" autocomplete="off">
                                </div>
                                <div class="text-end mt-3">
                                    <input type="hidden" name="idusuarios" id="idusuarios" value="<% out.print(sesion.getAttribute("id")); %>">
                                    <button type="button" name="agregar" value="agregar" id="AgregaProductoVentas" class="btn btn-primary">
                                        <span class="fa fa-shopping"></span> Agregar
                                    </button>
                                    <div id="respuesta" style="width: 250px; margin: auto; text-align: center"></div>
                                    <div id="mensajeAlerta" class="alert" style="display: none;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section>

    </div>
</main>
<script>
    document.getElementById("fecharegistro").setAttribute("min", new Date().toISOString().split("T")[0]);
</script>
<%@ include file="footer.jsp" %>
<% } else { %>
<p>No tienes permiso para acceder a esta página.</p>
<% }%>
