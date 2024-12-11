<%@ include file="header.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    if (sesion != null && (sesion.getAttribute("tipo") != null && (sesion.getAttribute("tipo").equals("GERENTE COMPRAS") || sesion.getAttribute("tipo").equals("ADMINISTRADOR")))) {
        String idpk = request.getParameter("idpk");

        if (idpk != null && !idpk.isEmpty()) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/bdveterinaria", "postgres", "1");
                String query = "SELECT c.idconsulta, CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_completo, cli.ci, c.fecha, doc.nombre AS doctorNombre, c.hora, c.total, cli.idclientes, doc.iddoctores FROM consulta c INNER JOIN clientes cli ON c.idclientes = cli.idclientes INNER JOIN doctores doc ON c.iddoctores = doc.iddoctores WHERE c.estado='PENDIENTE' and idconsulta = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(idpk));
                rs = ps.executeQuery();

                if (rs.next()) {
                    String cliente = rs.getString(2);
                    String documento = rs.getString(3);
                    String fechaRegistro = rs.getString(4);
                    String doctornombre = rs.getString(5);
                    String hora = rs.getString(6); // Hora completa, ej. "16:23:00-04"
                    String idcliente = rs.getString(8);
                    String iddoctores = rs.getString(9);
                    String idconsulta = rs.getString(1);

                    SimpleDateFormat formatoOriginal = new SimpleDateFormat("yyyy-MM-dd");
                    SimpleDateFormat formatoDestino = new SimpleDateFormat("dd-MM-yyyy");
                    Date fechaDate = formatoOriginal.parse(fechaRegistro);
                    String fechaFormateadaRegistro = formatoDestino.format(fechaDate);
                    out.print("<script>");
                    out.print("document.addEventListener('DOMContentLoaded', function() {");

                    // Asignar valores a los inputs
                    out.print("document.getElementById('idclientes').value = '" + idcliente + "';");
                    out.print("document.getElementById('nombrecliente').value = '" + cliente + "';");
                    out.print("document.getElementById('documento').value = '" + documento + "';");
                    out.print("document.getElementById('fecharegistro').value = '" + fechaFormateadaRegistro + "';");
                    out.print("document.getElementById('iddoctores').value = '" + iddoctores + "';");
                    out.print("document.getElementById('nombredoctor').value = '" + doctornombre + "';");
                    out.print("document.getElementById('idconsulta').value = '" + idconsulta + "';");
                    // Formatear la hora
                    out.print("var horaCompleta = '" + hora + "';");
                    out.print("var horaFormateada = horaCompleta.split(':').slice(0, 2).join(':');");
                    out.print("document.getElementById('hora').value = horaFormateada;");

                    out.print("});");
                    out.print("</script>");
                } else {
                    out.println("No se encontraron resultados.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (ps != null) {
                        ps.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (conn != null) {
                        conn.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
%>


<%@ include file="jsp/conexion.jsp" %>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/consulta.js"></script>

<main id="main" class="main">
    <style>
        .normal-select {
            background-color: #ffffff; /* Color de fondo normal */
            color: #000000; /* Color de texto normal */
        }
        .readonly-select {
            background-color: #e9ecef; /* Color de fondo para readonly */
            color: #6c757d; /* Color de texto para readonly */
            border: 1px solid #ced4da; /* Borde para readonly */
            cursor: not-allowed; /* Cursor para indicar que no se puede editar */
        }
        .form-card {
            background-color: #A8E6CF; /* Color de fondo de las tarjetas */
            margin-bottom: 20px;
        }
        .card-title {
            color: #000; /* Color del título de la tarjeta */
        }
        .btn-primary {
            background-color: #007bff; /* Color del botón primario */
            border-color: #007bff; /* Color del borde del botón primario */
        }
        .btn-danger {
            background-color: #dc3545; /* Color del botón de peligro */
            border-color: #dc3545; /* Color del borde del botón de peligro */
        }
        .form-control {
            border-radius: .25rem; /* Bordes redondeados para los campos de formulario */
        }
        .modal-content {
            border-radius: .3rem; /* Bordes redondeados para el contenido del modal */
        }
    </style>

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
                        <button type="button" czlass="btn btn-primary" name="eliminarregistrodetalle" id="eliminarregistrodetalle" data-bs-dismiss="modal">Sí</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="content-wrapper">
        <section class="content">
            <form id="form" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                <input type="hidden" id="listar" name="listar" value="cargar" />

                <div class="row">
                    <div class="col-lg-6">
                        <div class="card form-card">
                            <div class="card-body"  style="background-color: #abb9e8;">
                                <h5 class="card-title">Consulta</h5>
                                <div class="form-group">
                                    <label for="cliente" class="control-label">Cliente</label>
                                    <form id="formulario" enctype="multipart/form-data" method="POST" role="form" class="form-horizontal form-groups-bordered">
                                        <input class="form-control" type="hidden" name="idclientes" id="idclientes" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>
                                    </form>
                                    <input class="form-control" type="text" name="nombrecliente" id="nombrecliente" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>
                                    <input class="form-control" type="hidden" name="idconsulta" id="idconsulta" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>

                                </div>
                                <div class="form-group">
                                    <label for="documento" class="control-label">Documento</label>
                                    <input type="hidden" id="codalumno" name="codalumno">
                                    <input class="form-control" type="text" name="documento" id="documento" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>
                                    <small><span class="symbol required"></span></small>
                                </div>
                                <div class="form-group">
                                    <label for="fecharegistro" class="control-label">Fecha de Cita</label>
                                    <input class="form-control" type="text" name="fecharegistro" id="fecharegistro" autocomplete="off" placeholder="Ingrese Fecha" readonly="readonly">
                                </div>
                                <br>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card form-card"  style="background-color: #abb9e8;">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fa fa-archive"></i></h5>
                                <div id="error"></div>
                                <div class="form-group">
                                    <label for="idproducto" class="control-label">Datos del Médico <span class="symbol required"></span></label>
                                    <input type="hidden" id="codproducto" name="codproducto">
                                    <input class="form-control" type="hidden" name="iddoctores" id="iddoctores" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>
                                    <input class="form-control" type="text" name="nombredoctor" id="nombredoctor" onKeyUp="this.value = this.value.toUpperCase();" autocomplete="off" placeholder="Cedula" readonly="readonly" required>

                                </div>
                                <div class="form-group">
                                    <label class="control-label">Hora</label>
                                    <input type="text" class="form-control" name="hora" id="hora" placeholder="Ingrese la hora" readonly="readonly" />
                                </div>
                                <div class="form-group">
                                    <label for="precio" class="control-label">Cobro por Consulta <span class="symbol required"></span></label>
                                    <input class="form-control" value="100000" type="text" name="precio" id="precio" autocomplete="off" placeholder="Precio" required onkeyup="puntitos(this, this.value.charAt(this.value.length - 1))" readonly="readonly">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-12">
                        <div class="card form-card">
                            <div class="card-body" style="background-color: #abb9e8;">

                                <h5 class="card-title"><i class="fa fa-archive"></i></h5>
                                <div id="error"></div>
                                <label for="detalles" class="control-label">Detalles<span class="symbol required"></span></label>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label">Animal</label>
                                            <input type="hidden" id="codproductos" name="codproductos">
                                            <select class="form-control normal-select" name="animal" id="animal" style="height: 38px;">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label">Sintomas</label>
                                            <select class="form-control normal-select" name="sintomas" id="sintomas" style="height: 38px;">
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label">Medicamentos</label>
                                            <select class="form-control normal-select" name="medicamentos" id="medicamentos" style="height: 38px;">
                                            </select>
                                        </div>

                                    </div><div class="col-md-3">
                                        <div class="form-group">
                                            <label for="recetas" class="control-label">Recetas<span class="symbol required"></span></label>
                                            <input class="form-control" type="text" name="recetas" id="recetas" autocomplete="off" placeholder="Complete la receta" style="height: 38px;">
                                        </div>
                                    </div>

                                </div>
                                <div class="text-end mt-3">
                                    <button type="button" name="agregar" value="agregar" id="AgregaProductoVentas" class="btn btn-primary">
                                        <span class="fa fa-shopping"></span> Agregar
                                    </button>
                                    <div id="respuesta"></div>
                                    <div id="mensajeAlerta" class="alert" style="display: none;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card" style="background-color: #abb9e8;">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered dt-responsive nowrap" id="carrito" style="width: 100%;">
                                            <h5 class="card-title"><i class="fa fa-archive"></i> Detalle de la Cita</h5>
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">Accion</th>
                                                    <th style="text-align: center;">Paciente</th>
                                                    <th style="text-align: center;">Sintomas</th>
                                                    <th style="text-align: center;">Medicamentos</th>
                                                    <th style="text-align: center;">Recetas</th>

                                                </tr>
                                            </thead>
                                            <tbody id="resultados">
                                                <!-- Aquí van tus filas de datos -->
                                            </tbody>
                                        </table>
                                        <table width="100%" id="carritototal">
                                            <tr>
                                                <td width="40px">
                                                    <span class="Estilo9"><label>Total:</label></span>
                                                </td>
                                                <td>
                                                    <div align="left" class="Estilo9"><label id="lbltotal" name="lbltotal"></label>
                                                        <input type="hidden" name="txtTotal" id="txtTotal" value="0" />
                                                        <input type="hidden" name="txtTotalCompra" id="txtTotalCompra" value="0" />
                                                        <input type="hidden" name="idusuarios" id="idusuarios" value="<% out.print(sesion.getAttribute("id")); %>">
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <br></br>
                                    <br></br>
                                    <div class="modal-footer">
                                        <button class="btn btn-danger" type="button"  id="btn-cancelar">
                                            <span class="fa fa-times"></span> Cancelar
                                        </button>
                                        <span style="margin-left: 5px; margin-right: 5px;"></span>
                                        <button type="button" name="btn-submit" id="btn-finalizar" class="btn btn-primary" >
                                            <span class="fa fa-save"></span> Registrar
                                        </button>

                                    </div>
                                    <br>
                                    <div id="mensajeAlertas" class="alert" style="display: none;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
            </form>
        </section>
    </div>
    <%    } else {
            response.sendRedirect("index.jsp");
        }
    %>
    <%@ include file="footer.jsp" %>
