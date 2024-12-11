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
<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString("idsintomas")); %>')" title="Eliminar S�ntoma" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
            out.println("Error SQL al listar s�ntomas: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");

        try {
            PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM sintomas WHERE nombre = ?");
            psConsulta.setString(1, nombre);
            ResultSet rsConsulta = psConsulta.executeQuery();

            if (rsConsulta.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El s�ntoma ya existe.</i>");
            } else {
                PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO sintomas(nombre) VALUES (?)");
                psInsertar.setString(1, nombre);
                int filasInsertadas = psInsertar.executeUpdate();

                if (filasInsertadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>S�ntoma insertado correctamente.</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo insertar el s�ntoma.</i>");
                }
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al insertar s�ntoma: " + e.getMessage());
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
                        out.println("<i class='alert alert-danger'>El sintoma ya est� registrado en otro doctor.</i>");
                        return; // Salir del m�todo si el RUC ya existe
                    }
                }
            }
            // Convertir pk a entero si es necesario
            int idSintoma = Integer.parseInt(pk);

            // Preparar la consulta de actualizaci�n
            PreparedStatement psModificar = conn.prepareStatement("UPDATE sintomas SET nombre = ? WHERE idsintomas = ?");
            psModificar.setString(1, nombre);
            psModificar.setInt(2, idSintoma); // Usar setInt para establecer el ID del s�ntoma

            // Ejecutar la consulta de actualizaci�n
            int filasModificadas = psModificar.executeUpdate();

            if (filasModificadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>S�ntoma actualizado correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se pudo actualizar el s�ntoma.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("Error: El ID del s�ntoma no es v�lido.");
        } catch (SQLException e) {
            out.println("Error SQL al actualizar s�ntoma: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        //out.print(pk);
        try {
            // Validar si pkdel es un n�mero v�lido
            int idsintomas = Integer.parseInt(pk);

            // Preparar la consulta de eliminaci�n
            PreparedStatement psEliminar = conn.prepareStatement("DELETE FROM sintomas WHERE idsintomas = ?");
            psEliminar.setInt(1, idsintomas);

            int filasEliminadas = psEliminar.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>S�ntoma eliminado correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se encontr� el s�ntoma para eliminar.</i>");
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

