<%@include file="conexion.jsp" %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("Select * from usuarios order by idusuarios asc");
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>

    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenadosusuarios('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>')">
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
        } catch (Exception e) {
            out.println("<br>");
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");
        String clave = request.getParameter("clave");
        String rol = request.getParameter("rol");
        String estado = request.getParameter("estado");
        String personalesStr = request.getParameter("personales");

        try {
            // Convertir personalesStr a entero
            int personales = Integer.parseInt(personalesStr);

            // Verificar si el nombre ya existe
            PreparedStatement psNombre = conn.prepareStatement("SELECT * FROM usuarios WHERE nombre = ?");
            psNombre.setString(1, nombre);
            ResultSet rsNombre = psNombre.executeQuery();

            if (rsNombre.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El nombre ya está registrado.</i>");
            } else {
                // Verificar si el valor de personales ya existe
                PreparedStatement psPersonales = conn.prepareStatement("SELECT * FROM usuarios WHERE idpersonales = ?");
                psPersonales.setInt(1, personales);
                ResultSet rsPersonales = psPersonales.executeQuery();

                if (rsPersonales.next()) {
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>El personal ya está registrado.</i>");
                } else {
                    // No se encontraron registros duplicados, proceder con la inserción
                    PreparedStatement insertStatement = conn.prepareStatement("INSERT INTO usuarios(nombre, clave, rol, estado, idpersonales) VALUES (?, ?, ?, ?, ?)");
                    insertStatement.setString(1, nombre);
                    insertStatement.setString(2, clave);
                    insertStatement.setString(3, rol);
                    insertStatement.setString(4, estado);
                    insertStatement.setInt(5, personales);
                    insertStatement.executeUpdate();
                    out.println("<br>");
                    out.println("<i class='alert alert-success'>DATOS CARGADOS</i>");
                }
            }
        } catch (NumberFormatException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>Error al convertir el valor de personales a entero.</i>");
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al insertar datos: " + e.getMessage());
        } catch (Exception e) {
            out.println("<br>");
            out.println("Error general al insertar datos: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        //out.println(request.getParameter("nombre"));
        //out.println(request.getParameter("pk"));
        String pk = request.getParameter("pk");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("clave");
        String ruc = request.getParameter("rol");
        String telefono = request.getParameter("estado");
        String ciudad = request.getParameter("personales");
        String queryRuc = "SELECT * FROM usuarios WHERE nombre = ? AND idusuarios <> ?";

        try {
            try (PreparedStatement psRuc = conn.prepareStatement(queryRuc)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psRuc.setString(1, nombre);
                psRuc.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsRuc = psRuc.executeQuery()) {
                    if (rsRuc.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El nombre ya está registrado en otro usuario.</i>");
                        return; // Salir del método si el RUC ya existe
                    }
                }
            }
            Statement st = conn.createStatement();
            ResultSet rs = null;
            st.executeUpdate("update usuarios set nombre='" + nombre + "',clave='" + apellido + "',rol='" + ruc + "',estado='" + telefono + "',idpersonales='" + ciudad + "' where idusuarios='" + pk + "' ");
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS ACTUALIZADOS</i>");
        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al actualizar datos: " + e.getMessage());

        } catch (Exception e) {
            out.println("<br>");
            out.println("Error general al actualizar datos: " + e.getMessage());
        }

    } else if (request.getParameter("listar").equals("eliminar")) {
        String pk = request.getParameter("pkdel");
        try {
            Statement st = conn.createStatement();
            ResultSet rs = null;
            st.executeUpdate("delete from usuarios where idusuarios='" + pk + "'");
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este usuario se utiliza en un registro.</i>");
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

