<%@ include file="conexion.jsp" %>

<%    String action = request.getParameter("listar");

    if (action == null) {
        out.println("<i class='alert alert-danger'>Acción no especificada.</i>");
        return;
    }

    if (action.equals("listar")) {
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT raza.idraza AS id, raza.nombre AS nombre, especie.nombre AS especie_nombre,especie.idespecies as ides FROM raza INNER JOIN especie ON raza.idespecies = especie.idespecies ORDER BY raza.idraza ASC");

            while (rs.next()) {
%>
<tr>
    <td><%= rs.getString("id")%></td>
    <td><%= rs.getString("nombre")%></td>
    <td><%= rs.getString("especie_nombre")%></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenarraza('<%= rs.getString("id")%>', '<%= rs.getString("nombre")%>', '<%= rs.getString("ides")%>')">
    <img src="img/editar.png" >
</li>

<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<%= rs.getString("id")%>')" title="Eliminar" data-bs-toggle="modal" data-bs-target="#exampleModal">
    <img src="img/borrar.png" >
</li>

<button class="btn btn-outline-danger" onclick="$('#pkimp').val('<%= rs.getString("id")%>')" title="Imprimir" data-bs-toggle="modal" data-bs-target="#exampleModals">
    <img src="img/impresora.png">
</button>
</td>
</tr>
<%
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error SQL al listar: " + e.getMessage() + "</i>");
        }
    } else if (action.equals("cargar")) {
        String nombre = request.getParameter("nombre");
        int especie = Integer.parseInt(request.getParameter("ciudad"));
        if (nombre == null || nombre.trim().isEmpty()) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>El nombre no puede estar vacío.</i>");
            return;
        }

        if (especie == 0) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Debe seleccionar una especie.</i>");
            return;
        }

        try {
            // Verificar si la raza ya existe
            PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM raza WHERE nombre = ?");
            psConsulta.setString(1, nombre);
            ResultSet rsConsulta = psConsulta.executeQuery();

            if (rsConsulta.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>La raza ya existe.</i>");
            } else {
                // Insertar nueva raza
                PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO raza(nombre,idespecies) VALUES (?, ?)");
                psInsertar.setString(1, nombre);
                psInsertar.setInt(2, especie);
                int filasInsertadas = psInsertar.executeUpdate();

                if (filasInsertadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>Raza insertada correctamente.</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo insertar la raza.</i>");
                }
            }
        } catch (SQLException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error SQL al insertar raza: " + e.getMessage() + "</i>");
        }
    } else if (action.equals("modificar")) {
        String pk = request.getParameter("pk");
        String nombre = request.getParameter("nombre");
        int especie = Integer.parseInt(request.getParameter("ciudad"));
        if (pk == null || nombre == null || nombre.trim().isEmpty()) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>El ID y el nombre no pueden estar vacíos.</i>");
            return;
        }

        try {
            // Convertir pk a entero
            int idraza = Integer.parseInt(pk);

            // Verificar si la raza existe
            PreparedStatement psSelect = conn.prepareStatement("SELECT nombre FROM raza WHERE idraza = ?");
            psSelect.setInt(1, idraza);
            ResultSet rs = psSelect.executeQuery();

            if (rs.next()) {
                String nombreActual = rs.getString("nombre");
                int especieActual = Integer.parseInt(request.getParameter("ciudad"));
                // Verificar si el nuevo nombre es diferente al actual
                

                // Actualizar raza
                PreparedStatement psModificar = conn.prepareStatement("UPDATE raza SET nombre = ?, idespecies = ? WHERE idraza = ?");
                psModificar.setString(1, nombre);
                psModificar.setInt(2, especie);
                psModificar.setInt(3, idraza);

                int filasModificadas = psModificar.executeUpdate();

                if (filasModificadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>Raza actualizada correctamente.</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo actualizar la raza. Verifique el ID proporcionado.</i>");
                }
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se encontró una raza con el ID proporcionado.</i>");
            }
        } catch (NumberFormatException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error: El ID de la raza no es válido.</i>");
        } catch (SQLException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error SQL al actualizar raza: " + e.getMessage() + "</i>");
        }
    } else if (action.equals("eliminar")) {
        String pk = request.getParameter("pkdel");

        if (pk == null || pk.trim().isEmpty()) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>El ID no puede estar vacío.</i>");
            return;
        }

        try {
            // Convertir pk a entero
            int idraza = Integer.parseInt(pk);

            // Eliminar raza
            PreparedStatement psEliminar = conn.prepareStatement("DELETE FROM raza WHERE idraza = ?");
            psEliminar.setInt(1, idraza);

            int filasEliminadas = psEliminar.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<br>");
                out.println("<i class='alert alert-success'>Raza eliminada correctamente.</i>");
            } else {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>No se encontró la raza para eliminar.</i>");
            }
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Esta raza se utiliza en un registro.</i>");
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
