<%@include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR"))) {
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/indicaciones.js"></script>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">ELIMINAR CONSULTA</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eliminar" action="#" method="post">
                    <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas eliminar el registro?</p>
                        <input type="hidden" name="pkdel" id="pkdel">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" name="eliminartodo" id="eliminartodo" data-bs-dismiss="modal">Si</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid" style="background-color: #FFFFFF;">
    <hr>
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                </div>
                <div class="text-center" class="widget-content nopadding" style="background-color: #A8E6CF; font-size: smaller;">
                    <form action="#" method="get" class="form-horizontal" id="form">
                        <div class="control-group">
                            <br>
                            <h4>Formulario Indicaciones</h4>
                            <input type="hidden" name="listar" id="listar" value="cargar">
                            <input type="hidden" name="pk" id="pk">
                            <br>
                            <label class="control-label">Descripción</label>
                            <div class="controls">
                                <textarea class="span11" name="descripcion" id="descripcion" placeholder="Ingrese la descripción" rows="10" style="resize: both; width: 100%;"></textarea>
                            </div>
                        </div>
                        <div class="boton-centrado">
                            <input name="botondep" id="botondep" type="button" value="PROCESAR" class="btn btn-primary">
                            <br><br>
                            <div id="mensaje"></div>
                            <div style="padding: 5px;"></div>
                            <div id="mensajeAlerta" class="alert" style="display: none;"></div>
                            <div></div><br></br>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <br>
    <!-- Listado de indicaciones -->
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="listado-columna">
                <div class="listado" style="background-color: #9dc1d3; padding: 20px;">
                    <h1 style="font-size: larger; text-align: center;">Listado</h1>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" id="resultado" style="font-size: larger;">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descripción</th>
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
        if ((texto.length > 50) || ((teclado < 'A' || teclado > 'z') && teclado != "")) {
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
