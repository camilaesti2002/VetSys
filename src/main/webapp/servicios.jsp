<%@include file="header.jsp" %>
<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR"))) {
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/servicios.js"></script>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Eliminar Servicio</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="eliminar" action="#" method="post">
                    <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                    <p>¿Estás seguro de que deseas eliminar este servicio?</p>
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

<div class="container-fluid" style="background-color: #FFFFFF;">
    <hr>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon"> <i class="icon-align-justify"></i> </span>
                </div>
                <div class="widget-content nopadding" style="background-color: #9dc1d3; padding: 15px;">
                    <form action="#" method="get" class="form-horizontal" id="form">
                        <h5 class="text-center"><b>Servicios</b></h5>
                        <input type="hidden" name="listar" id="listar" value="cargar">
                        <input type="hidden" name="pk" id="pk">

                        <div class="form-group">
                            <label for="descripcion">Descripción</label>
                            <input type="text" class="form-control form-control-sm" name="descripcion" id="descripcion" placeholder="Ingrese una breve descripción">
                        </div>
                        <div class="form-group">
                            <label for="precio">Precio</label>
                            <input type="number" class="form-control form-control-sm" name="precio" id="precio" placeholder="Ingrese el precio" readonly>
                        </div>
                        <div class="form-group">
                            <label for="iva">IVA (%)</label>
                            <input type="number" class="form-control form-control-sm" name="iva" id="iva" value="10" readonly="">
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

    <!-- Listado de Servicios -->
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="listado-columna">
                <div class="listado" style="background-color: #9dc1d3; padding: 15px;">
                   <h5 class="text-center">
                        Listado 
                        <a href="listado.jsp" class="ms-2 text-decoration-none" title="Imprimir"><i class="fas fa-print"></i></a>
                    </h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover table-sm" id="resultado">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Descripcion</th>
                                    <th>Precio</th>
                                    <th>IVA</th>
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
    document.addEventListener('DOMContentLoaded', function() {
        const descripcionInput = document.getElementById('descripcion');
        const precioInput = document.getElementById('precio');

        // Definir los precios para diferentes descripciones
        const preciosServicios = {
            "baño": 30000,
            "corte": 50000,
            "limpieza": 25000,
            "vacunacion": 25000
        };

        descripcionInput.addEventListener('input', function() {
            const descripcion = descripcionInput.value.toLowerCase().trim();
            const precio = preciosServicios[descripcion];
            
            if (precio !== undefined) {
                precioInput.value = precio.toFixed(2);
            } else {
                precioInput.value = "";  // Limpia el campo si no hay coincidencia
            }
        });
    });
</script>

<%@include file="footer.jsp" %>
<% } else {
        response.sendRedirect("dashboard.jsp");
    }
%>
