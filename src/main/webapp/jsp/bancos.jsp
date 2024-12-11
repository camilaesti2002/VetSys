<%@include file="conexion.jsp" %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select * from bancos order by idbancos asc");
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenarbancos('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>')">
    <img src="img/editar.png" >
</li>

<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')" title="Eliminar Clientes" data-bs-toggle="modal" data-bs-target="#exampleModal">
    <img src="img/borrar.png" >
</li>

<button class="btn btn-outline-danger" onclick="$('#pkimp').val(<% out.print(rs.getString(1)); %>)"  title="Imprimir" data-bs-toggle="modal" data-bs-target="#exampleModals"">
    <img src="img/impresora.png" >
</button>

</td>

</tr>
<%
            }
        } catch (SQLException e) {
            out.println("Error SQL al listar ciudad: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");

        try {
            PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM bancos WHERE nombre = ?");
            psConsulta.setString(1, nombre);
            ResultSet rsConsulta = psConsulta.executeQuery();

            if (rsConsulta.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El banco ya existe.</i>");
            } else {
                PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO bancos(nombre) VALUES (?)");
                psInsertar.setString(1, nombre);

                int filasInsertadas = psInsertar.executeUpdate();

                if (filasInsertadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>Banco insertado correctamente.</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo insertar la ciudad.</i>");
                }
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al insertar ciudad: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String nombre = request.getParameter("nombre");

        try {
            // Convertir pk a entero
            int idbancos = Integer.parseInt(pk);

            // Validar que el campo nombre no esté vacío antes de proceder con la actualización
            if (nombre == null || nombre.trim().isEmpty()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Debe modificar.</i>");
                return;  // Salir del método para evitar que se realice una actualización vacía
            }

            // Preparar la consulta para obtener el nombre actual de la ciudad
            PreparedStatement psSelect = conn.prepareStatement("SELECT nombre FROM bancos WHERE idbancos= ?");
            psSelect.setInt(1, idbancos);
            ResultSet rs = psSelect.executeQuery();

            // Verificar si la ciudad existe
            if (rs.next()) {
                String nombreActual = rs.getString("nombre");

                // Validar que el nuevo nombre no sea igual al nombre actual
                if (nombreActual.equals(nombre)) {
                    out.println("<br>");
                    out.println("<i class='alert alert-warning'>Debe modificar al menos un campo para guardar los cambios");
                    return;  // Salir del método porque no hay cambios a aplicar
                }
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se encontró una ciudad con el ID proporcionado.</i>");
                return;  // Salir del método porque el ID de ciudad no existe
            }

            // Preparar la consulta de actualización
            PreparedStatement psModificar = conn.prepareStatement("UPDATE bancos SET nombre = ? WHERE idbancos = ?");
            psModificar.setString(1, nombre);
            psModificar.setInt(2, idbancos); // Usar setInt para establecer el ID de la ciudad

            // Ejecutar la consulta de actualización
            int filasModificadas = psModificar.executeUpdate();

            if (filasModificadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Banco actualizada correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se pudo actualizar la ciudad. Verifique que el ID de la ciudad sea válido.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error: El ID de la ciudad no es válido.</i>");
        } catch (SQLException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error SQL al actualizar ciudad: " + e.getMessage() + "</i>");
        } catch (Exception e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error general al actualizar ciudad: " + e.getMessage() + "</i>");
        }
    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");

        try {
            // Validar si pkdel es un número válido
            int idbancos = Integer.parseInt(pk);

            // Preparar la consulta de eliminación
            PreparedStatement psEliminar = conn.prepareStatement("DELETE FROM bancos WHERE idbancos = ?");
            psEliminar.setInt(1,idbancos);

            int filasEliminadas = psEliminar.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Banco eliminada correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se encontró la ciudad para eliminar.</i>");
            }
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este banco se utiliza en un registro.</i>");
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

