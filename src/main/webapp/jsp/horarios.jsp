<%@include file="conexion.jsp" %>
<% 
    if (request.getParameter("listar") != null) {
        if (request.getParameter("listar").equals("listar")) {
            try {
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT h.idhorarios, h.dias, h.hora_inicio, h.hora_fin, h.iddoctores, d.nombre FROM horarios h INNER JOIN doctores d ON h.iddoctores = d.iddoctores ORDER BY h.idhorarios;");
                while (rs.next()) {
%>
<tr>
    <td><%= rs.getString(1)%></td>
    <td><%= rs.getString(2)%></td>
    <td><%= rs.getString(3)%></td>
    <td><%= rs.getString(4)%></td>
    <td><%= rs.getString(6)%></td>
    <td class="edit-botones">  
        <li class="btn btn-outline-warning" onclick="rellenadoshorarios('<%= rs.getString(1)%>', '<%= rs.getString(2)%>', '<%= rs.getString(3)%>', '<%= rs.getString(4)%>', '<%= rs.getString(5)%>')">
            <img src="img/editar.png" >
        </li>

        <li class="btn btn-outline-danger" onclick="$('#pkdel').val('<%= rs.getString(1)%>')" title="Eliminar horarios" data-bs-toggle="modal" data-bs-target="#exampleModal">
             <img src="img/borrar.png" >
        </li>
         <button class="btn btn-outline-danger" onclick="$('#pkimp').val(<% out.print(rs.getString(1)); %>)"  title="Imprimir Persona" data-bs-toggle="modal" data-bs-target="#exampleModals">
            <img src="img/impresora.png" >
        </button>
    </td>
</tr>
<%
                }
            } catch (SQLException e) {
                out.println("<br>");
                out.println("Error SQL al listar horarios: " + e.getMessage());
            }
        } else if (request.getParameter("listar").equals("cargar")) {
            String dias = request.getParameter("dias");
            String hora = request.getParameter("hora");
            String horafin = request.getParameter("horafin");
            String doctor = request.getParameter("doctor");

            

            if (dias == null || hora == null || horafin == null || doctor == null || dias.isEmpty() || hora.isEmpty() || horafin.isEmpty() || doctor.isEmpty()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Todos los campos son obligatorios.</i>");
            } else {
                try {
                    // Convertir el valor de doctor a entero
                    int doctorId = Integer.parseInt(doctor);

                    // Verificar si ya existe un registro con la misma fecha y hora
                    PreparedStatement psHorarios = conn.prepareStatement("SELECT * FROM horarios WHERE dias = ? AND hora_inicio = ?");
                    psHorarios.setString(1, dias);
                    psHorarios.setString(2, hora);
                    ResultSet rsHorarios = psHorarios.executeQuery();

                    if (rsHorarios.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>La fecha y hora ya están registradas.</i>");
                    } else {
                        // Si no existe un registro con la misma fecha y hora, insertar en la base de datos
                        PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO horarios(dias, hora_inicio, hora_fin, iddoctores) VALUES (?, ?, ?, ?)");
                        psInsertar.setString(1, dias);
                        psInsertar.setString(2, hora);
                        psInsertar.setString(3, horafin);
                        psInsertar.setInt(4, doctorId);  // Insertar como entero

                        int filasInsertadas = psInsertar.executeUpdate();

                        if (filasInsertadas > 0) {
                            // Si se insertaron filas correctamente, mostrar mensaje de éxito
                            out.println("<br>");
                            out.println("<i class='alert alert-success'>DATOS CARGADOS</i>");
                        } else {
                            out.println("<br>");
                            out.println("<i class='alert alert-danger'>No se pudo insertar el registro.</i>");
                        }
                    }
                } catch (NumberFormatException e) {
                    out.println("<br>");
                    out.println("Error: el ID del doctor no es un número válido.");
                } catch (SQLException e) {
                    out.println("<br>");
                    out.println("Error SQL al insertar datos: " + e.getMessage());
                    e.printStackTrace(); // Imprimir el stack trace para depurar
                }
            }
        } else if (request.getParameter("listar").equals("modificar")) {
    String pk = request.getParameter("pk");
    String dias = request.getParameter("dias");
    String hora = request.getParameter("hora");
    String horafin = request.getParameter("horafin");
    String doctor = request.getParameter("doctor");
    try {
        // Convertir el valor de doctor a entero
        int doctorId = Integer.parseInt(doctor);
        int pkId = Integer.parseInt(pk); // Asegúrate de convertir pk a entero si es de tipo integer en la BD

        PreparedStatement psModificar = conn.prepareStatement("UPDATE horarios SET dias=?, hora_inicio=?, hora_fin=?, iddoctores=? WHERE idhorarios=?");
        psModificar.setString(1, dias);
        psModificar.setString(2, hora);
        psModificar.setString(3, horafin);
        psModificar.setInt(4, doctorId);  // Insertar como entero
        psModificar.setInt(5, pkId); // Usar pkId como entero

        int filasActualizadas = psModificar.executeUpdate();
        if (filasActualizadas > 0) {
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS ACTUALIZADOS</i>");
        } else {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>No se pudo actualizar el registro.</i>");
        }
    } catch (NumberFormatException e) {
        out.println("<br>");
        out.println("Error: el ID del doctor o el ID del horario no es un número válido.");
    } catch (SQLException e) {
        out.println("<br>");
        out.println("Error SQL al actualizar datos: " + e.getMessage());
    }
} else if (request.getParameter("listar").equals("eliminar")) {
            String pk = request.getParameter("pkdel");
            try {
                Statement st = conn.createStatement();
                int filasEliminadas = st.executeUpdate("DELETE FROM horarios WHERE idhorarios='" + pk + "'");
                if (filasEliminadas > 0) {
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
                } else {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>No se pudo eliminar el registro.</i>");
                }
            } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este horario se utiliza en un registro.</i>");
            } else {
                out.println("<br>");
                out.println("Error SQL al eliminar datos: " + e.getMessage());
            }
        } catch (Exception e) {
            out.println("<br>");
            out.println("Error general al eliminar datos: " + e.getMessage());
        }
        }
    }
%>
