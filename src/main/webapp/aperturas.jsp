<%@include file="header.jsp"%>
<% 
    if (sesion != null && (
        sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("CAJERO") ||
        sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR")
    )) { 
%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/caja.js"></script>
<main id="main" class="main">
    <%
        // Obtener la fecha actual
        Date fechaActual = new Date();

        // Crear un formateador de fecha
        SimpleDateFormat formateadorFecha = new SimpleDateFormat("dd-MM-yyyy");

        // Formatear la fecha
        String fechaFormateada = formateadorFecha.format(fechaActual);
    %>
    <section class="section d-flex justify-content-center align-items-center" style="min-height: 80vh; background-color: #FFFFFF;">
        <div class="col-lg-8"> <!-- Cambié el tamaño de la columna a 6 -->
            <div class="card">
                                <div class="card-body" style="background-color: #9dc1d3; padding: 20px; border-radius: 8px;">
                    <h5 class="card-title"></h5>
                    <form id="form">
                        <h2 style="text-align: center">Abrir Caja</h2>
                        <input type="hidden" name="listar" id="listar" value="cargar">
                        <input type="hidden" name="pk" id="pk">

                        <div class="form-group">
                            <label for="nombre">Monto:</label><br>
                            <input type="text" class="form-control" onkeypress="return validarRuc(event)" name="monto" id="monto" placeholder="Ingrese el monto de apertura">
                        </div>
                        <div class="form-group">
                            <label for="field-12" class="control-label">Fecha de Apertura</label>
                            <input class="form-control" type="text" name="fecharegistro" id="fecharegistro" autocomplete="off" placeholder="Ingrese Fecha" value="<%= fechaFormateada %>" readonly>
                        </div>
                        <div class="boton-centrado text-center"> <!-- Clase para centrar el botón -->
                            <input name="botondep" id="botondep" type="button" value="PROCESAR" class="btn btn-primary">
                            <br><br> 
                            <div id="mensaje"></div>
                            <div style="padding: 5px;"></div>
                            <div id="mensajeAlerta" class="alert" style="display: none;"></div>
                            <input type="hidden" name="idusuarios" id="idusuarios" value="<% out.print(sesion.getAttribute("id")); %>">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <script>
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

            // Verificar longitud exacta de 11 caracteres
            if (texto.length > 10) {
                e.preventDefault();
                return false;
            }

            return true;
        }
    </script>
</main><!-- End #main -->

<%@include file="footer.jsp" %>
<% } else {
    response.sendRedirect("dashboard.jsp");
}
%>

