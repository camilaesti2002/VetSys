<%@include file="conexion.jsp" %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery(" select * from consulta;");
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenadosconsulta('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>')">
    <i class="icon-edit"></i> Editar
</li>

<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')" title="Eliminar Clientes" data-bs-toggle="modal" data-bs-target="#exampleModal">
    <i class="icon-trash"></i> Eliminar
</li>

</td>

</tr>

<%
            }
        } catch (Exception e) {
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
    String fecha = request.getParameter("fecha");
    String hora = request.getParameter("hora");

    try {
        // Verificar si ya existe un registro con la misma fecha y hora
        PreparedStatement psConsulta = conn.prepareStatement("SELECT * FROM consulta WHERE fecha = ? AND hora = ?");
        // Convertir la cadena de fecha a un tipo de datos date utilizando la función to_date de PostgreSQL
        psConsulta.setDate(1, java.sql.Date.valueOf(fecha));
        psConsulta.setString(2, hora);
        ResultSet rsConsulta = psConsulta.executeQuery();

        if (rsConsulta.next()) {
            // Si ya existe un registro con la misma fecha y hora, mostrar mensaje de error
            out.println("<i class='alert alert-danger'>La fecha y hora ya están registradas.</i>");
        } else {
            // Si no existe un registro con la misma fecha y hora, insertar en la base de datos
            PreparedStatement psInsertar = conn.prepareStatement("INSERT INTO consulta(fecha, hora) VALUES (?, ?)");
            // Convertir la cadena de fecha a un tipo de datos date utilizando la función to_date de PostgreSQL
            psInsertar.setDate(1, java.sql.Date.valueOf(fecha));
            psInsertar.setString(2, hora);
            int filasInsertadas = psInsertar.executeUpdate();

            if (filasInsertadas > 0) {
                // Si se insertaron filas correctamente, mostrar mensaje de éxito
                out.println("<i class='alert alert-success'>DATOS CARGADOS</i>");
            } else {
                // Si no se insertaron filas (posiblemente debido a un error), mostrar mensaje de error
                out.println("<i class='alert alert-danger'>No se pudo insertar el registro.</i>");
            }
        }
    } catch (SQLException e) {
        out.println("Error SQL al insertar datos: " + e.getMessage());
    } catch (Exception e) {
        out.println("Error general al insertar datos: " + e.getMessage());
    }
}
 else if (request.getParameter("listar").equals("modificar")) {
        //out.println(request.getParameter("nombre"));
        //out.println(request.getParameter("pk"));
        String pk = request.getParameter("pk");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        try {
            Statement st = conn.createStatement();
            ResultSet rs = null;
            st.executeUpdate("update consulta set fecha='" + fecha + "',hora='" + hora + "' where idconsulta='" + pk + "' ");
            out.println("<i class='alert alert-success'>DATOS ACTUALIZADOS</i>");
        } catch (SQLException e) {
            out.println("Error SQL al actualizar datos: " + e.getMessage());

        } catch (Exception e) {
            out.println("Error general al actualizar datos: " + e.getMessage());
        }

    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            Statement st = conn.createStatement();
            ResultSet rs = null;
            st.executeUpdate("delete from consulta where idconsulta='" + pk + "'");
            out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
        } catch (SQLException e) {
            out.println("Error SQL al eliminar datos: " + e.getMessage());

        } catch (Exception e) {
            out.println("Error general al eliminar datos: " + e.getMessage());
        }
    }
%>