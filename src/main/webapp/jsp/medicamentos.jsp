<%@include file="conexion.jsp" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM medicamentos order by idmedicamentos asc ;");
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            while (rs.next()) {
                Date fechaVenta = rs.getDate(3);
                String fechaFormateada = sdf.format(fechaVenta);

%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(fechaFormateada); %></td> <!-- Imprimir fecha formateada -->
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenadosmedicamentos('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>')">
    <img src="img/editar.png" >
</li>
<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')" title="Eliminar Clientes" data-bs-toggle="modal" data-bs-target="#exampleModal">
    <img src="img/borrar.png" >
</li>
<button class="btn btn-outline-danger" onclick="$('#pkimp').val(<% out.print(rs.getString(1)); %>)"  title="Imprimir Persona" data-bs-toggle="modal" data-bs-target="#exampleModals"">
    <img src="img/impresora.png" >
</button>

</td>
</tr>
<%
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al listar medicamentos: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");
        String vencimiento = request.getParameter("vencimiento");
        String lote = request.getParameter("lote");
        String codigodebarras = request.getParameter("codigodebarras");
        
        try {
            PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM medicamentos WHERE nombre = ?");
            psConsulta.setString(1, nombre);
            ResultSet rsConsulta = psConsulta.executeQuery();
            PreparedStatement psConsultas = conn.prepareStatement("SELECT * FROM medicamentos WHERE codigodebarras = ?");
            psConsultas.setString(1, codigodebarras);
            ResultSet rsConsultas = psConsultas.executeQuery();

            if (rsConsulta.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El medicamento ya existe.</i>");
            } else if(rsConsultas.next()){
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El codigo de barra ya se uso.</i>");
                }else {
                PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO medicamentos (nombre, vencimiento, lote, codigodebarras) VALUES (?, ?, ?, ?)");
                psInsertar.setString(1, nombre);
                psInsertar.setString(2, vencimiento);
                psInsertar.setString(3, lote);
                psInsertar.setString(4, codigodebarras);
                int filasInsertadas = psInsertar.executeUpdate();

                if (filasInsertadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>Medicamento insertado correctamente.</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo insertar el medicamento.</i>");
                }
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al insertar medicamento: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String nombre = request.getParameter("nombre");
        String vencimiento = request.getParameter("vencimiento");
        String lote = request.getParameter("lote");
        String codigodebarras = request.getParameter("codigodebarras");
        String queryRuc = "SELECT * FROM medicamentos WHERE nombre = ? AND idmedicamentos <> ?";
        String queryTelefono = "SELECT * FROM medicamentos WHERE codigodebarras = ? AND idmedicamentos <> ?";

        try {
                try (PreparedStatement psRuc = conn.prepareStatement(queryRuc)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psRuc.setString(1, nombre);
                psRuc.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsRuc = psRuc.executeQuery()) {
                    if (rsRuc.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El medicamento ya está registrado .</i>");
                        return; // Salir del método si el RUC ya existe
                    }
                }
            }
                try (PreparedStatement psTelefono = conn.prepareStatement(queryTelefono)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psTelefono.setString(1, codigodebarras);
                psTelefono.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsTelefono = psTelefono.executeQuery()) {
                    if (rsTelefono.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El codigo de barras ya se esta utilizando.</i>");
                        return; // Salir del método si el teléfono ya existe
                    }
                }
            }
            int idMedicamento = Integer.parseInt(pk);
            PreparedStatement psModificar = conn.prepareStatement("UPDATE medicamentos SET nombre = ?, vencimiento= ?, lote=?, codigodebarras=? WHERE idmedicamentos = ?");
            psModificar.setString(1, nombre);
            psModificar.setString(2, vencimiento);
            psModificar.setString(3, lote);
            psModificar.setString(4, codigodebarras);
            psModificar.setInt(5, idMedicamento);
            int filasModificadas = psModificar.executeUpdate();

            if (filasModificadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Medicamento modificado correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-success'>No se pudo actualizar.</i>");
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al actualizar medicamento: " + e.getMessage());
        } catch (NumberFormatException e) {
            out.println("<br>");
            out.println("Error: El ID del medicamento no es válido.");
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            int idMedicamento = Integer.parseInt(pk);
            PreparedStatement psEliminar = conn.prepareStatement("DELETE FROM medicamentos WHERE idmedicamentos = ?");
            psEliminar.setInt(1, idMedicamento);
            int filasEliminadas = psEliminar.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Medicamento eliminado correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-success'>No se puedo eliminar el medicamento .</i>");
            }
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este medicamento se utiliza en un registro.</i>");
            } else {
                out.println("<br>");
                out.println("Error SQL al eliminar datos: " + e.getMessage());
            }
        } catch (Exception e) {
            out.println("<br>");
            out.println("Error general al eliminar datos: " + e.getMessage());
        }
    }
%>
