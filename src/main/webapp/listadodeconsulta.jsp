<%@include file="header.jsp" %>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/listadodecitas.js"></script>
<div class="container-fluid" style="background-color: #FFFFFF;">
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">ELIMINAR CONSULTA</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas eliminar la consulta?</p>
                        <input type="hidden" name="idpk" id="idpk">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" name="eliminar-registro-venta" id="eliminar-registro-venta" data-bs-dismiss="modal">Si</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-13 ">
            <br></br>
            <div class="listado-columna">
                <div class="listado" style="background-color: #9dc1d3; padding: 20px;">
                    <h1 style="font-size: larger; text-align: center;">Listado de Consultas</h1>
                    <div class="table-responsive">
                        <button type="button" onclick="location.href = 'consulta.jsp'" class="btn btn-primary">Nueva Consulta</button><br></br>
                        <table class="table table-striped table-bordered table-hover" id="resultado" style="font-size: larger;">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Animal</th>
                                    <th>Sintomas</th>
                                    <th>Recetas</th>
                                    <th>Medicamentos</th>
                                    <th>Indicaciones</th>
                                    <th>Total</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody id="resultadosventas">
                                <!-- Aquí van los datos de la tabla -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>    
<%@include file="footer.jsp" %>
