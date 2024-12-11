<%@include file="conexion.jsp" %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("select p.idpersonales, p.nombre, p.apellido, p.ci, p.telefono, ci.idciudad, ci.ciu_nombre from personales p INNER JOIN ciudades ci ON p.idciudad= ci.idciudad order by p.idpersonales ASC ;  ");
            while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td class="edit-botones">  
<li class="btn btn-outline-warning" onclick="rellenadospers('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>')">
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
            out.println("error PSQL" + e);
        }
    } else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String ruc = request.getParameter("ruc");
        String telefono = request.getParameter("telefono");
        String ciudad = request.getParameter("ciudad");

        try {
            // Validar si el RUC y el teléfono ya existen
            PreparedStatement psRuc = conn.prepareStatement("SELECT * FROM personales WHERE ci = ?");
            psRuc.setString(1, ruc);
            ResultSet rsRuc = psRuc.executeQuery();

            PreparedStatement psTelefono = conn.prepareStatement("SELECT * FROM personales WHERE telefono = ?");
            psTelefono.setString(1, telefono);
            ResultSet rsTelefono = psTelefono.executeQuery();

            if (rsRuc.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El C.I ya está registrado.</i>");
            } else if (rsTelefono.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El teléfono ya está registrado.</i>");
            } else {
                // RUC y teléfono no existen, insertar en la base de datos
                Statement st = conn.createStatement();
                st.executeUpdate("INSERT INTO personales(nombre,apellido,ci,telefono,idciudad) VALUES ('" + nombre + "','" + apellido + "','" + ruc + "','" + telefono + "','" + ciudad + "')");
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
        String apellido = request.getParameter("apellido");
        String ruc = request.getParameter("ruc");
        String telefono = request.getParameter("telefono");
        String ciudad = request.getParameter("ciudad");
        String queryRuc = "SELECT * FROM personales WHERE ci = ? AND idpersonales <> ?";
        String queryTelefono = "SELECT * FROM personales WHERE telefono = ? AND idpersonales <> ?";

        try {
            try (PreparedStatement psRuc = conn.prepareStatement(queryRuc)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psRuc.setString(1, ruc);
                psRuc.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsRuc = psRuc.executeQuery()) {
                    if (rsRuc.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El C.I ya está registrado en otro cliente.</i>");
                        return; // Salir del método si el RUC ya existe
                    }
                }
            }
            try (PreparedStatement psTelefono = conn.prepareStatement(queryTelefono)) {
                int pkInt = Integer.parseInt(pk); // Convierte el String a int
                psTelefono.setString(1, telefono);
                psTelefono.setInt(2, pkInt);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsTelefono = psTelefono.executeQuery()) {
                    if (rsTelefono.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El teléfono ya está registrado en otro cliente.</i>");
                        return; // Salir del método si el teléfono ya existe
                    }
                }
            }
            Statement st = conn.createStatement();
            ResultSet rs = null;
            st.executeUpdate("update personales set nombre='" + nombre + "',apellido='" + apellido + "',ci='" + ruc + "',telefono='" + telefono + "',idciudad='" + ciudad + "' where idpersonales='" + pk + "' ");
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
            st.executeUpdate("delete from personales where idpersonales='" + pk + "'");
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este cliente se utiliza en un registro.</i>");
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
