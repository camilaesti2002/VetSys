<%@include file="conexion.jsp" %>
<% 
    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM servicios;"); // Cambiado a 'servicios'
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString("idservicios")); %></td> <!-- Cambiado a 'idservicio' -->
    <td><% out.print(rs.getString("descripcion")); %></td>
    <td><% out.print(rs.getDouble("precio")); %></td> <!-- Cambiado a 'precio' y tipo de dato double -->
    <td><% out.print(rs.getDouble("iva")); %></td> <!-- Cambiado a 'iva' y tipo de dato double -->
    <td class="edit-botones">  
        <li class="btn btn-outline-warning" onclick="rellenarServicios('<% out.print(rs.getString("idservicios")); %>', '<% out.print(rs.getString("descripcion")); %>', '<% out.print(rs.getDouble("precio")); %>', '<% out.print(rs.getDouble("iva")); %>')"> <!-- Actualizado para servicios -->
            <i class="icon-edit"></i> Editar
        </li>
        <li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString("idservicios")); %>')" title="Eliminar Servicio" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <i class="icon-trash"></i> Eliminar
        </li>
    </td>
</tr>
<%
            }
        } catch (SQLException e) {
            out.println("Error SQL al listar servicios: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String ivaStr = request.getParameter("iva");
        
        try {
            double precio = Double.parseDouble(precioStr);
            double iva = Double.parseDouble(ivaStr);

            PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM servicios WHERE descripcion = ?");
            psConsulta.setString(1, descripcion);
            ResultSet rsConsulta = psConsulta.executeQuery();

            if (rsConsulta.next()) {
                out.println("<i class='alert alert-danger'>El servicio ya existe.</i>");
            } else {
                PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO servicios(descripcion, precio, iva) VALUES (?, ?, ?)");
                psInsertar.setString(1, descripcion);
                psInsertar.setDouble(2, precio);
                psInsertar.setDouble(3, iva);
                int filasInsertadas = psInsertar.executeUpdate();

                if (filasInsertadas > 0) {
                    out.println("<i class='alert alert-success'>Servicio insertado correctamente.</i>");
                } else {
                    out.println("<i class='alert alert-danger'>No se pudo insertar el servicio.</i>");
                }
            }
        } catch (NumberFormatException e) {
            out.println("Error: El precio o IVA no es válido.");
        } catch (SQLException e) {
            out.println("Error SQL al insertar servicio: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String ivaStr = request.getParameter("iva");
        
        try {
            int idServicios = Integer.parseInt(pk);
            double precio = Double.parseDouble(precioStr);
            double iva = Double.parseDouble(ivaStr);

            PreparedStatement psModificar = conn.prepareStatement("UPDATE servicios SET descripcion = ?, precio = ?, iva = ? WHERE idservicios = ?"); // Cambiado a 'idservicio'
            psModificar.setString(1, descripcion);
            psModificar.setDouble(2, precio);
            psModificar.setDouble(3, iva);
            psModificar.setInt(4, idServicios);

            int filasModificadas = psModificar.executeUpdate();

            if (filasModificadas > 0) {
                out.println("<i class='alert alert-success'>Servicio actualizado correctamente.</i>");
            } else {
                out.println("<i class='alert alert-danger'>No se pudo actualizar el servicio.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("Error: El ID del servicio, precio o IVA no son válidos.");
        } catch (SQLException e) {
            out.println("Error SQL al actualizar servicio: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            int idServicios = Integer.parseInt(pk);

            PreparedStatement psEliminar = conn.prepareStatement("DELETE FROM servicios WHERE idservicios = ?"); // Cambiado a 'idservicios'
            psEliminar.setInt(1, idServicios);

            int filasEliminadas = psEliminar.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<i class='alert alert-success'>Servicio eliminado correctamente.</i>");
            } else {
                out.println("<i class='alert alert-danger'>No se encontró el servicio para eliminar.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("Error: El ID del servicio no es válido.");
        } catch (SQLException e) {
            out.println("Error SQL al eliminar servicio: " + e.getMessage());
        }
    }
%>

