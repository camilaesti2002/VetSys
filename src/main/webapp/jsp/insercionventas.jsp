<%@page import="java.io.PrintWriter"%>
<%@ include file="conexion.jsp" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>


<%    if (request.getParameter("listar") != null && request.getParameter("listar").equals("cargar")) {
    // Obtén los parámetros de la solicitud
    String codalumno = request.getParameter("cliente");
    String codproducto = request.getParameter("idproducto");
    String fecharegistro = request.getParameter("fecharegistro");
    String usuario = request.getParameter("idusuarios");
    String recetas = request.getParameter("recetas");
    String precio = request.getParameter("precio");
    String cantidad = request.getParameter("hora");
    String animalParam = request.getParameter("animal");
    Integer pacientes = null;
    if (animalParam != null && !animalParam.isEmpty()) {
        pacientes = Integer.parseInt(animalParam);
    }
    String medicamentosParam = request.getParameter("medicamentos");
    Integer medicamentos = null;
    if (medicamentosParam != null && !medicamentosParam.isEmpty()) {
        medicamentos = Integer.parseInt(medicamentosParam);
    }
    String sintomasParam = request.getParameter("sintomas");
    Integer sintomas = null;
    if (sintomasParam != null && !sintomasParam.isEmpty()) {
        sintomas = Integer.parseInt(sintomasParam);
    }

    // Obtén el idconsulta del formulario y realiza el parseo a entero
    String idconsultaParam = request.getParameter("idconsulta");
    Integer idconsulta = null;
    try {
        if (idconsultaParam != null && !idconsultaParam.isEmpty()) {
            idconsulta = Integer.parseInt(idconsultaParam);
        }
    } catch (NumberFormatException e) {
        out.println("Error: idconsulta no válido.");
        return;
    }

    // Asegúrate de que codalumno contenga solo la parte antes de la coma
    if (codalumno != null && codalumno.contains(",")) {
        codalumno = codalumno.split(",")[0];
    }

    // Validar y convertir precio a entero
    Integer precioI = null;
    try {
        precioI = Integer.parseInt(precio);
    } catch (NumberFormatException e) {
        out.println("Error: Precio no válido.");
        return;
    }

    PreparedStatement pstInsert = null;

    try {
        conn.setAutoCommit(false); // Inicia transacción

        // Procedemos directamente con la inserción, sin verificar si ya existe un detalleconsulta
        String insertQuery = "INSERT INTO detalleconsulta(idconsulta, precio, idpacientes, idsintomas, recetas, idmedicamentos) VALUES (?, ?, ?, ?, ?, ?)";
        pstInsert = conn.prepareStatement(insertQuery);
        pstInsert.setInt(1, idconsulta);
        pstInsert.setInt(2, precioI);
        pstInsert.setInt(3, pacientes);
        pstInsert.setInt(4, sintomas);
        pstInsert.setString(5, recetas);
        pstInsert.setInt(6, medicamentos);

        pstInsert.executeUpdate();
        conn.commit();
        out.println("<br>");
        out.println("<i class='alert alert-success'>Datos cargados correctamente</i>");
        out.println("<script>setTimeout(function() { document.querySelector('.alert').style.display = 'none'; }, 1000);</script>");

    } catch (Exception e) {
        try {
            if (conn != null) {
                conn.rollback(); // Revierte la transacción en caso de error
            }
        } catch (SQLException ex) {
            out.println("Error al revertir la transacción: " + ex);
        }
        out.println("Error PSQL: " + e);
    } finally {
        try {
            if (pstInsert != null) pstInsert.close();
            if (conn != null) {
                conn.setAutoCommit(true); // Restaurar autoCommit
                conn.close();
            }
        } catch (SQLException e) {
            out.println("Error al cerrar recursos: " + e);
        }
    }
} else if (request.getParameter("listar").equals("listar")) {
        // Obtener el valor del parámetro idconsulta
        String idpk = request.getParameter("idconsulta");
        System.out.println("el parametro es" + idpk);
        // Verificar si idpk es nulo o vacío
        if (idpk != null && !idpk.isEmpty()) {
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Mostrar el valor de idconsulta en la consola
                System.out.println("idconsulta recibido: " + idpk);

                String query = "select det.iddetalleconsulta, pa.nombre as paciente, sin.nombre as sintomas, det.recetas, med.nombre,det.precio from detalleconsulta det inner join pacientes pa on pa.idpaciente = det.idpacientes inner join sintomas sin on sin.idsintomas = det.idsintomas inner join medicamentos med on med.idmedicamentos = det.idmedicamentos where det.idconsulta = ?";

                ps = conn.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(idpk));
                rs = ps.executeQuery();

                // Verificar si hay resultados
                if (!rs.isBeforeFirst()) {
                    System.out.println("No se encontraron resultados para idconsulta: " + idpk);
                } else {
                    while (rs.next()) {
                        String precio = rs.getString(6);

                        // Verificar si precio es un número
                        Integer precioI;
                        try {
                            precioI = Integer.parseInt(precio);
                        } catch (NumberFormatException e) {
                            System.out.println("Error en la conversión del precio: " + precio);
                            continue; // Saltar esta fila si el precio no es válido
                        }

                        int calculo = precioI;
%>
<tr>
    <td> 
<li class="btn btn-outline-danger" title="Eliminar Registro" data-bs-toggle="modal" data-bs-target="#exampleModal" 
    onclick="$('#idpk').val(<% out.print(rs.getString(1)); %>)">
    <i class="icon-trash"></i> Eliminar
</li>
</td>
<td><% out.print(rs.getString(2)); %></td>
<td><% out.print(rs.getString(3)); %></td>
<td><% out.print(rs.getString(5)); %></td>
<td><% out.print(rs.getString(4)); %></td>
</tr>   
<%
                }
            }
        } catch (Exception e) {
            // Mostrar el error completo en la consola
            e.printStackTrace();  // Esto imprime el error completo en la consola de Tomcat
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
                /* Ignorar */ }
            if (ps != null) try {
                ps.close();
            } catch (Exception e) {
                /* Ignorar */ }
        }
    } else {
        System.out.println("Error: El parámetro idconsulta no está presente o es inválido.");
    }
} else if (request.getParameter("listar").equals("listars")) {
        // Obtener el valor del parámetro idconsulta
        String idpk = request.getParameter("idconsulta");
        System.out.println("el parametro es" + idpk);
        // Verificar si idpk es nulo o vacío
        if (idpk != null && !idpk.isEmpty()) {
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Mostrar el valor de idconsulta en la consola
                System.out.println("idconsulta recibido: " + idpk);

                String query = "select det.iddetalleconsulta, pa.nombre as paciente, sin.nombre as sintomas, det.recetas, med.nombre,det.precio from detalleconsulta det inner join pacientes pa on pa.idpaciente = det.idpacientes inner join sintomas sin on sin.idsintomas = det.idsintomas inner join medicamentos med on med.idmedicamentos = det.idmedicamentos where det.idconsulta = ?";

                ps = conn.prepareStatement(query);
                ps.setInt(1, Integer.parseInt(idpk));
                rs = ps.executeQuery();

                // Verificar si hay resultados
                if (!rs.isBeforeFirst()) {
                    System.out.println("No se encontraron resultados para idconsulta: " + idpk);
                } else {
                    while (rs.next()) {
                        String precio = rs.getString(6);

                        // Verificar si precio es un número
                        Integer precioI;
                        try {
                            precioI = Integer.parseInt(precio);
                        } catch (NumberFormatException e) {
                            System.out.println("Error en la conversión del precio: " + precio);
                            continue; // Saltar esta fila si el precio no es válido
                        }

                        int calculo = precioI;
%>
<tr>
<td><% out.print(rs.getString(2)); %></td>
<td><% out.print(rs.getString(3)); %></td>
<td><% out.print(rs.getString(5)); %></td>
<td><% out.print(rs.getString(4)); %></td>
</tr>   
<%
                }
            }
        } catch (Exception e) {
            // Mostrar el error completo en la consola
            e.printStackTrace();  // Esto imprime el error completo en la consola de Tomcat
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
                /* Ignorar */ }
            if (ps != null) try {
                ps.close();
            } catch (Exception e) {
                /* Ignorar */ }
        }
    } else {
        System.out.println("Error: El parámetro idconsulta no está presente o es inválido.");
    }
} else if (request.getParameter("listar").equals("mostrartotales")) {
    String idpk = request.getParameter("idconsulta");
    System.out.println("el parametro para mostrar el total es " + idpk);
    if (idpk != null && !idpk.isEmpty()) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Usar un HashMap para rastrear pacientes únicos y sus precios
            Map<Integer, Integer> patientPrices = new HashMap<>();
            
            String query = "SELECT det.iddetalleconsulta, det.idpacientes, det.idsintomas, det.recetas, det.idmedicamentos, det.precio FROM detalleconsulta det WHERE det.idconsulta = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(idpk));
            rs = ps.executeQuery();
            
            while (rs.next()) {
                int idPaciente = rs.getInt(2);  // Obtener el ID del paciente
                int precio = rs.getInt(6);      // Obtener el precio
                
                // Si el paciente no está en el mapa, agregar su precio
                // Si el paciente ya está en el mapa, no se agregará de nuevo
                if (!patientPrices.containsKey(idPaciente)) {
                    patientPrices.put(idPaciente, precio);
                }
            }
            
            // Calcular el total sumando los precios de pacientes únicos
            int sumador = 0;
            for (int precioUnico : patientPrices.values()) {
                sumador += precioUnico;
            }
            
            out.println(sumador);
        } catch (Exception e) {
            System.out.println("Error al calcular el total: " + e);
            // Opcional: imprimir el stack trace para más detalles
            // e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error cerrando recursos: " + e);
            }
        }
    } else {
        System.out.println("Error: El parámetro idconsulta no está presente o es inválido.");
    }
} else if (request.getParameter("listar").equals("eliminardetalle")) {

    String pk = request.getParameter("pk");
    try {
        Statement st = null;
        st = conn.createStatement();
        st.executeUpdate("delete from detalleconsulta where iddetalleconsulta='" + pk + "'");
        //out.println("<i class='alert alert-success'>Datos eliminados</i>");
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }
} else if ("cancelarventa".equals(request.getParameter("listar"))) {
    String idpk = request.getParameter("idconsulta");

    if (idpk != null && !idpk.isEmpty()) {
        PreparedStatement psUpdate = null;

        try {
            // Actualizar el estado de la venta a 'CANCELADO'
            String updateQuery = "UPDATE consulta SET estado='CANCELADO' WHERE idconsulta = ?";
            psUpdate = conn.prepareStatement(updateQuery);
            psUpdate.setInt(1, Integer.parseInt(idpk));

            int rowsAffected = psUpdate.executeUpdate();

            if (rowsAffected > 0) {
                // Mostrar mensaje de éxito si la actualización fue exitosa
                out.println("<i class='alert alert-success'>Venta con ID " + idpk + " cancelada correctamente.</i>");
            } else {
                // Mostrar mensaje si no se afectaron filas
                out.println("<i class='alert alert-warning'>No se encontró la venta con ID " + idpk + " para cancelar.</i>");
            }
        } catch (Exception e) {
            // Mostrar mensaje de error en caso de excepción
            out.println("<i class='alert alert-danger'>Error al cancelar la venta: " + e.getMessage() + "</i>");
        } finally {
            // Cerrar recursos
            try {
                if (psUpdate != null) {
                    psUpdate.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                out.println("<i class='alert alert-danger'>Error al cerrar los recursos: " + e.getMessage() + "</i>");
            }
        }
    } else {
        out.println("<i class='alert alert-warning'>El parámetro idconsulta no está presente o es inválido.</i>");
    }
} else if ("finalizarventa".equals(request.getParameter("listar"))) {
    String idpk = request.getParameter("idconsulta");
    String totalStr = request.getParameter("total");
    String condicion = request.getParameter("condicion");
    String numero = request.getParameter("numerofac");
    if (idpk != null && !idpk.isEmpty() && totalStr != null && !totalStr.isEmpty()) {
        PreparedStatement ps = null;

        try {
            // Convertir total a tipo adecuado (asumido como Double aquí, cambia si es necesario)
            double total = Double.parseDouble(totalStr);

            // Preparar la consulta de actualización con parámetros
            String query = "UPDATE consulta SET estado = 'PENDIENTES',condicion='"+condicion+"',numero='"+numero+"', total = ? WHERE idconsulta = ?";
            ps = conn.prepareStatement(query);
            ps.setDouble(1, total);
            ps.setInt(2, Integer.parseInt(idpk));

            // Ejecutar la actualización
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // Mostrar mensaje de éxito si la actualización fue exitosa
                out.println("<i class='alert alert-success'>Venta con ID " + idpk + " finalizada correctamente.</i>");
            } else {
                // Mostrar mensaje si no se afectaron filas
                out.println("<i class='alert alert-warning'>No se encontró la venta con ID " + idpk + " para finalizar.</i>");
            }
        } catch (Exception e) {
            // Mostrar mensaje de error en caso de excepción
            out.println("<i class='alert alert-danger'>Error al finalizar la venta: " + e.getMessage() + "</i>");
        } finally {
            // Cerrar recursos
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                out.println("<i class='alert alert-danger'>Error al cerrar el PreparedStatement: " + e.getMessage() + "</i>");
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                out.println("<i class='alert alert-danger'>Error al cerrar la conexión: " + e.getMessage() + "</i>");
            }
        }
    } else {
        out.println("<i class='alert alert-warning'>El parámetro idconsulta o total no está presente o es inválido.</i>");
    }
} else if ("finalizarventas".equals(request.getParameter("listar"))) {
    String idpk = request.getParameter("idconsulta");
    String totalStr = request.getParameter("total");
    String condicion = request.getParameter("condicion");
    String numero = request.getParameter("numerofac");
    String metodoPago = request.getParameter("metodoPago");
    String bancoPago = request.getParameter("bancoPago");
    
    if (idpk != null && !idpk.isEmpty() && totalStr != null && !totalStr.isEmpty()) {
        PreparedStatement ps = null;
        try {
            double total = Double.parseDouble(totalStr);
            
            // Base query without bank for cash payments
            String query;
            if ("1".equals(metodoPago)) {
                // For cash payments (metodoPago = 1), exclude bank
                query = "UPDATE consulta SET estado = 'FINALIZADO', " +
                       "condicion = ?, " +
                       "idmetodo = ?::integer, " +
                       "numero = ?, " +
                       "total = ? " +
                       "WHERE idconsulta = ?::integer";
                
                ps = conn.prepareStatement(query);
                ps.setString(1, condicion);
                ps.setInt(2, Integer.parseInt(metodoPago));
                ps.setString(3, numero);
                ps.setDouble(4, total);
                ps.setInt(5, Integer.parseInt(idpk));
            } else {
                // For other payment methods, include bank
                query = "UPDATE consulta SET estado = 'FINALIZADO', " +
                       "condicion = ?, " +
                       "idmetodo = ?::integer, " +
                       "idbanco = ?::integer, " +
                       "numero = ?, " +
                       "total = ? " +
                       "WHERE idconsulta = ?::integer";
                
                ps = conn.prepareStatement(query);
                ps.setString(1, condicion);
                ps.setInt(2, Integer.parseInt(metodoPago));
                ps.setInt(3, Integer.parseInt(bancoPago));
                ps.setString(4, numero);
                ps.setDouble(5, total);
                ps.setInt(6, Integer.parseInt(idpk));
            }

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<i class='alert alert-success'>Venta con ID " + idpk + " finalizada correctamente.</i>");
            } else {
                out.println("<i class='alert alert-warning'>No se encontró la venta con ID " + idpk + " para finalizar.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("<i class='alert alert-danger'>Error en el formato de los números: " + e.getMessage() + "</i>");
        } catch (Exception e) {
            out.println("<i class='alert alert-danger'>Error al finalizar la venta: " + e.getMessage() + "</i>");
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                out.println("<i class='alert alert-danger'>Error al cerrar el PreparedStatement: " + e.getMessage() + "</i>");
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                out.println("<i class='alert alert-danger'>Error al cerrar la conexión: " + e.getMessage() + "</i>");
            }
        }
    } else {
        out.println("<i class='alert alert-warning'>El parámetro idconsulta o total no está presente o es inválido.</i>");
    }
} else if (request.getParameter("listar").equals("listarventas")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();

        rs = st.executeQuery("SELECT c.idconsulta, c.fecha, c.idclientes, c.total, CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_completo, cli.ci, d.nombre, c.hora FROM  consulta c INNER JOIN doctores d ON c.iddoctores = d.iddoctores INNER JOIN clientes cli ON c.idclientes = cli.idclientes WHERE  c.estado = 'PENDIENTE' ORDER BY c.idconsulta ASC;");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        while (rs.next()) {
            Date fechaVenta = rs.getDate(2);
            String fechaFormateada = sdf.format(fechaVenta);
%>
<tr>


    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(fechaFormateada); %></td> <!-- Imprimir fecha formateada -->
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
<td><% out.print(rs.getString(8)); %></td>
<td><% out.print(rs.getString(4)); %></td>
    <td>
<li class="btn btn-outline-primary" title="Atender " data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#idpk').val(<% out.print(rs.getString(1)); %>)">
    <i class="icon-trash"></i> ATENDER
</li>
</td>
</tr>   
<%
        }
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }

} else if (request.getParameter("listar").equals("listarventass")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();

        rs = st.executeQuery("SELECT c.idconsulta, c.fecha, c.idclientes, c.total, CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_completo,cli.ci FROM consulta c INNER JOIN clientes cli ON c.idclientes = cli.idclientes WHERE c.estado = 'PENDIENTES' ORDER BY c.idconsulta ASC;");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        while (rs.next()) {
            Date fechaVenta = rs.getDate(2);
            String fechaFormateada = sdf.format(fechaVenta);
%>
<tr>


    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(fechaFormateada); %></td> <!-- Imprimir fecha formateada -->
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(4)); %></td>

    <td>
<li class="btn btn-outline-primary" title="Atender " data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#idpk').val(<% out.print(rs.getString(1)); %>)">
    <i class="icon-trash"></i> COBRAR
</li>
</td>
</tr>   
<%
        }
    } catch (Exception e) {
        out.println("error PSQL" + e);
    }

} else if (request.getParameter("listar").equals("listarventa")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();

        rs = st.executeQuery("SELECT c.idconsulta, c.fecha, c.idclientes, c.total, CONCAT(cli.nombre, ' ', cli.apellido) AS nombre_completo,cli.ci FROM consulta c INNER JOIN clientes cli ON c.idclientes = cli.idclientes WHERE c.estado = 'FINALIZADO' ORDER BY c.idconsulta ASC;");
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        while (rs.next()) {
            Date fechaVenta = rs.getDate(2);
            String fechaFormateada = sdf.format(fechaVenta);
%>
<tr>


    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(fechaFormateada); %></td> <!-- Imprimir fecha formateada -->
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(4)); %></td>

    <td>

        <button class="btn btn-outline-primary" 
                onclick="setPrintData('<%= rs.getString(1)%>', '<%= rs.getString(4)%>')" 
                title="Imprimir Factura" 
                data-bs-toggle="modal" 
                data-bs-target="#exampleModals">
            <img src="img/impresora.png">
        </button>

    </td>
</tr>   
<%
            }
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }

    } else if ("anularventa".equals(request.getParameter("listar"))) {
        String idpk = request.getParameter("idpk");
        System.out.println("ID recibido: " + idpk);  // Imprime el idpk recibido

        if (idpk != null && !idpk.isEmpty()) {
            PreparedStatement psUpdate = null;

            try {
                // Actualizar el estado de la venta a 'CANCELADO'
                String updateQuery = "UPDATE consulta SET estado='ANULADO' WHERE idconsulta = ?";
                psUpdate = conn.prepareStatement(updateQuery);
                psUpdate.setInt(1, Integer.parseInt(idpk));

                int rowsAffected = psUpdate.executeUpdate();

                if (rowsAffected > 0) {
                    // Mostrar mensaje de éxito si la actualización fue exitosa
                    out.println("<i class='alert alert-success'>Venta con ID " + idpk + " cancelada correctamente.</i>");
                } else {
                    // Mostrar mensaje si no se afectaron filas
                    out.println("<i class='alert alert-warning'>No se encontró la venta con ID " + idpk + " para cancelar.</i>");
                }
            } catch (Exception e) {
                // Mostrar mensaje de error en caso de excepción
                out.println("<i class='alert alert-danger'>Error al cancelar la venta: " + e.getMessage() + "</i>");
            } finally {
                // Cerrar recursos
                try {
                    if (psUpdate != null) {
                        psUpdate.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("<i class='alert alert-danger'>Error al cerrar los recursos: " + e.getMessage() + "</i>");
                }
            }
        } else {
            out.println("<i class='alert alert-warning'>El parámetro idconsulta no está presente o es inválido.</i>");
        }
    }


%>
