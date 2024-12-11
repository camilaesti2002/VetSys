<%@include file="conexion.jsp" %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * from doctores order by iddoctores asc;");
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenadosclien('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>')">
    <img src="img/editar.png" >
</li>

<li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')" title="Eliminar Doctores" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");

        try {
            // Validar si el RUC y el teléfono ya existen
            PreparedStatement psRuc = conn.prepareStatement("SELECT * FROM doctores WHERE correo = ?");
            psRuc.setString(1, correo);
            ResultSet rsRuc = psRuc.executeQuery();

            PreparedStatement psTelefono = conn.prepareStatement("SELECT * FROM doctores WHERE telefono = ?");
            psTelefono.setString(1, telefono);
            ResultSet rsTelefono = psTelefono.executeQuery();

            if (rsRuc.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El Correo ya está registrado.</i>");
            } else if (rsTelefono.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El teléfono ya está registrado.</i>");
            } else {
                // RUC y teléfono no existen, insertar en la base de datos
                Statement st = conn.createStatement();
                st.executeUpdate("INSERT INTO doctores(nombre,telefono,correo) VALUES ('" + nombre + "','" + telefono + "','" + correo + "')");
                out.println("<br>");
                out.println("<i class='alert alert-success'>DATOS CARGADOS</i>");
            }
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
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String queryRuc = "SELECT * FROM doctores WHERE telefono = ? AND iddoctores <> ?";
        String queryTelefono = "SELECT * FROM doctores WHERE correo = ? AND iddoctores <> ?";

        try {
            try (PreparedStatement psRuc = conn.prepareStatement(queryRuc)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psRuc.setString(1, telefono);
                psRuc.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsRuc = psRuc.executeQuery()) {
                    if (rsRuc.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El telefono ya está registrado en otro doctor.</i>");
                        return; // Salir del método si el RUC ya existe
                    }
                }
            }
            try (PreparedStatement psTelefono = conn.prepareStatement(queryTelefono)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psTelefono.setString(1, correo);
                psTelefono.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsTelefono = psTelefono.executeQuery()) {
                    if (rsTelefono.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El correo ya está registrado en otro doctor.</i>");
                        return; // Salir del método si el teléfono ya existe
                    }
                }
            }
            Statement st = conn.createStatement();
            ResultSet rs = null;
            st.executeUpdate("update doctores set nombre='" + nombre + "',telefono='" + telefono + "',correo='" + correo + "' where iddoctores='" + pk + "' ");
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
            st.executeUpdate("delete from doctores where iddoctores='" + pk + "'");
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este doctor se utiliza en un registro.</i>");
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