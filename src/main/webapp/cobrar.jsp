<%@include file="header.jsp" %>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/consul.js"></script>
<div class="container-fluid" style="background-color: #FFFFFF;">
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Cobrar CITA</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas cobrar la cita?</p>
                        <input type="hidden" name="idpk" id="idpk">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" name="cobrar-cita" id="cobrar-cita" data-bs-dismiss="modal">Si</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
     <div class="modal fade" id="exampleModals" tabindex="-1" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabels">ANULAR CITA</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas anular la cita?</p>
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
                <div class="listado" style="background-color: #B3C6E7; padding: 20px;">
                   <h1 style="font-size: 22px; text-align: center; font-family: 'Arial Black', Arial, sans-serif;">Listado para cobrar </h1>

                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" id="resultado" style="font-size: larger;">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Cliente</th>
                                    <th>C.I</th>
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