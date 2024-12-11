<%@include file="conexion.jsp" %>
<%
    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM indicaciones");
            while (rs.next()) {     
%>
<tr>
    <td><% out.print(rs.getInt("idindicaciones")); %></td>
    <td><% out.print(rs.getString("descripcion")); %></td>
    <td class="edit-botones">  
        <li class="btn btn-outline-warning" onclick="rellenarIndicaciones('<% out.print(rs.getInt("idindicaciones")); %>', '<% out.print(rs.getString("descripcion")); %>')">
            <i class="icon-edit"></i> Editar
        </li>
        <li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getInt("idindicaciones")); %>')" title="Eliminar Indicaciones" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <i class="icon-trash"></i> Eliminar
        </li>
    </td>
</tr>
<%
            }
        } catch(Exception e) {
            out.println("Error PSQL: " + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String descripcion = request.getParameter("descripcion");

        try {
            // Validar si la descripción ya existe
            PreparedStatement psDescripcion = conn.prepareStatement("SELECT * FROM indicaciones WHERE descripcion = ?");
            psDescripcion.setString(1, descripcion);
            ResultSet rsDescripcion = psDescripcion.executeQuery();

            if (rsDescripcion.next()) {
                out.println("<i class='alert alert-danger'>La descripción ya está registrada.</i>");
            } else {
                // Insertar en la base de datos
                PreparedStatement insertStatement = conn.prepareStatement("INSERT INTO indicaciones(descripcion) VALUES (?)");
                insertStatement.setString(1, descripcion);
                insertStatement.executeUpdate();
                out.println("<i class='alert alert-success'>DATOS CARGADOS</i>");
            }
        } catch (SQLException e) {
            out.println("Error SQL al insertar datos: " + e.getMessage());
        } catch (Exception e) {
            out.println("Error general al insertar datos: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String descripcion = request.getParameter("descripcion");

        try {
            // Actualizar la descripción
            PreparedStatement updateStatement = conn.prepareStatement("UPDATE indicaciones SET descripcion = ? WHERE idindicaciones = ?");
            updateStatement.setString(1, descripcion);
            updateStatement.setInt(2, Integer.parseInt(pk));
            updateStatement.executeUpdate();
            out.println("<i class='alert alert-success'>DATOS ACTUALIZADOS</i>");
        } catch (SQLException e) {
            out.println("Error SQL al actualizar datos: " + e.getMessage());
        } catch (Exception e) {
            out.println("Error general al actualizar datos: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");

        try {
            PreparedStatement deleteStatement = conn.prepareStatement("DELETE FROM indicaciones WHERE idindicaciones = ?");
            deleteStatement.setInt(1, Integer.parseInt(pk));
            deleteStatement.executeUpdate();
            out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
        } catch (SQLException e) {
            out.println("Error SQL al eliminar datos: " + e.getMessage());
        } catch (Exception e) {
            out.println("Error general al eliminar datos: " + e.getMessage());
        }
    }
%>
