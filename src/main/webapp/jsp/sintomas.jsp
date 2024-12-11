<%@include file="conexion.jsp" %>
<% 
    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM sintomas order by idsintomas asc;");
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString("idsintomas")); %></td>
    <td><% out.print(rs.getString("nombre")); %></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenarSintomas('<% out.print(rs.getString("idsintomas")); %>', '<% out.print(rs.getString("nombre")); %>')">
    <img src="img/editar.png" >
</li>
<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString("idsintomas")); %>')" title="Eliminar Síntoma" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
            out.println("Error SQL al listar síntomas: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");

        try {
            PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM sintomas WHERE nombre = ?");
            psConsulta.setString(1, nombre);
            ResultSet rsConsulta = psConsulta.executeQuery();

            if (rsConsulta.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El síntoma ya existe.</i>");
            } else {
                PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO sintomas(nombre) VALUES (?)");
                psInsertar.setString(1, nombre);
                int filasInsertadas = psInsertar.executeUpdate();

                if (filasInsertadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>Síntoma insertado correctamente.</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo insertar el síntoma.</i>");
                }
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al insertar síntoma: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String nombre = request.getParameter("nombre");
        String queryRuc = "SELECT * FROM sintomas WHERE nombre = ? AND idsintomas <> ?";

        try {
try (PreparedStatement psRuc = conn.prepareStatement(queryRuc)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psRuc.setString(1, nombre);
                psRuc.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsRuc = psRuc.executeQuery()) {
                    if (rsRuc.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El sintoma ya está registrado en otro doctor.</i>");
                        return; // Salir del método si el RUC ya existe
                    }
                }
            }
            // Convertir pk a entero si es necesario
            int idSintoma = Integer.parseInt(pk);

            // Preparar la consulta de actualización
            PreparedStatement psModificar = conn.prepareStatement("UPDATE sintomas SET nombre = ? WHERE idsintomas = ?");
            psModificar.setString(1, nombre);
            psModificar.setInt(2, idSintoma); // Usar setInt para establecer el ID del síntoma

            // Ejecutar la consulta de actualización
            int filasModificadas = psModificar.executeUpdate();

            if (filasModificadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Síntoma actualizado correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se pudo actualizar el síntoma.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("Error: El ID del síntoma no es válido.");
        } catch (SQLException e) {
            out.println("Error SQL al actualizar síntoma: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        //out.print(pk);
        try {
            // Validar si pkdel es un número válido
            int idsintomas = Integer.parseInt(pk);

            // Preparar la consulta de eliminación
            PreparedStatement psEliminar = conn.prepareStatement("DELETE FROM sintomas WHERE idsintomas = ?");
            psEliminar.setInt(1, idsintomas);

            int filasEliminadas = psEliminar.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Síntoma eliminado correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se encontró el síntoma para eliminar.</i>");
            }
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este sintoma se utiliza en un registro.</i>");
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

