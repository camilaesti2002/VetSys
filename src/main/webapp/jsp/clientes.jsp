<%@include file="conexion.jsp" %>
<%    if (request.getParameter("listar").equals("listar")) {
        try {
            Statement st = null;
            ResultSet rs = null;
            st = conn.createStatement();
            rs = st.executeQuery("SELECT c.idclientes, c.nombre, c.apellido, c.ci, c.telefono, c.idciudad, ciu.ciu_nombre FROM clientes AS c INNER JOIN ciudades AS ciu ON c.idciudad = ciu.idciudad order by idclientes asc;");
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
        <ul style="list-style: none; padding: 0; display: flex;">
            <button class="btn btn-outline-warning" style="margin-right: 5px; border-color: #000; color: #000;" onclick="rellenadosclien('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(3)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>')">
                 <img src="img/editar.png" >
            </button>
            <button class="btn btn-outline-danger" style="margin-right: 5px; border-color: #000; color: #000;" onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')" title="Eliminar Clientes" data-bs-toggle="modal" data-bs-target="#exampleModal">
                 <img src="img/borrar.png" >
            </button>
           <button class="btn btn-outline-danger" style="margin-right: 5px; border-color: #000;"s onclick="$('#pkimp').val(<% out.print(rs.getString(1)); %>)"  title="Imprimir Persona" data-bs-toggle="modal" data-bs-target="#exampleModals"">
            <img src="img/impresora.png" >
        </button>

        </ul>
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
            // Validar si el RUC ya existe
            PreparedStatement psRuc = conn.prepareStatement("SELECT * FROM clientes WHERE ci = ?");
            psRuc.setString(1, ruc);
            ResultSet rsRuc = psRuc.executeQuery();

            // Validar si el teléfono ya existe
            PreparedStatement psTelefono = conn.prepareStatement("SELECT * FROM clientes WHERE telefono = ?");
            psTelefono.setString(1, telefono);
            ResultSet rsTelefono = psTelefono.executeQuery();

            // Validar si la combinación de nombre y apellido ya existe
            

            if (rsRuc.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El C.I ya está registrado.</i>");
            } else if (rsTelefono.next()) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>El teléfono ya está registrado.</i>");
            }  else {
                // RUC, teléfono y combinación de nombre y apellido no existen, insertar en la base de datos
                Statement st = conn.createStatement();
                st.executeUpdate("INSERT INTO clientes(nombre,apellido,ci,telefono,idciudad) VALUES ('" + nombre + "','" + apellido + "','" + ruc + "','" + telefono + "','" + ciudad + "')");
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
        // Obtener los parámetros de la solicitud
        int pk = Integer.parseInt(request.getParameter("pk")); // Convertir pk a Integer
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String ruc = request.getParameter("ruc");
        String telefono = request.getParameter("telefono");
        String ciudad = request.getParameter("ciudad");

        // Convertir ciudad a Integer, y manejar la conversión de tipo con manejo de errores
        int idCiudad;
        try {
            idCiudad = Integer.parseInt(ciudad); // Convertir ciudad a Integer
        } catch (NumberFormatException e) {
            out.println("<br>");
            out.println("<i class='alert alert-danger'>ID de Ciudad no es un número válido.</i>");
            return; // Salir del método si la conversión falla
        }

        // Declarar las consultas SQL
        String queryRuc = "SELECT * FROM clientes WHERE ci = ? AND idclientes <> ?";
        String queryTelefono = "SELECT * FROM clientes WHERE telefono = ? AND idclientes <> ?";

        try {
            // Validar si el nuevo RUC ya existe en otro registro
            try (PreparedStatement psRuc = conn.prepareStatement(queryRuc)) {
                psRuc.setString(1, ruc);
                psRuc.setInt(2, pk);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsRuc = psRuc.executeQuery()) {
                    if (rsRuc.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El C.I ya está registrado en otro cliente.</i>");
                        return; // Salir del método si el RUC ya existe
                    }
                }
            }

            // Validar si el nuevo teléfono ya existe en otro registro
            try (PreparedStatement psTelefono = conn.prepareStatement(queryTelefono)) {
                psTelefono.setString(1, telefono);
                psTelefono.setInt(2, pk);  // Usar setInt para el tipo INTEGER
                try (ResultSet rsTelefono = psTelefono.executeQuery()) {
                    if (rsTelefono.next()) {
                        out.println("<br>");
                        out.println("<i class='alert alert-danger'>El teléfono ya está registrado en otro cliente.</i>");
                        return; // Salir del método si el teléfono ya existe
                    }
                }
            }

            // Validar si el nuevo nombre y apellido ya existen en otro registro
            

            // Validar si los nuevos datos son diferentes de los actuales
            String queryCurrentData = "SELECT nombre, apellido, ci, telefono, idciudad FROM clientes WHERE idclientes = ?";
            try (PreparedStatement psCurrentData = conn.prepareStatement(queryCurrentData)) {
                psCurrentData.setInt(1, pk);
                try (ResultSet rsCurrentData = psCurrentData.executeQuery()) {
                    if (rsCurrentData.next()) {
                        String currentNombre = rsCurrentData.getString("nombre");
                        String currentApellido = rsCurrentData.getString("apellido");
                        String currentRuc = rsCurrentData.getString("ci");
                        String currentTelefono = rsCurrentData.getString("telefono");
                        int currentIdCiudad = rsCurrentData.getInt("idciudad");

                        if (currentNombre.equals(nombre) && currentApellido.equals(apellido)
                                && currentRuc.equals(ruc) && currentTelefono.equals(telefono)
                                && currentIdCiudad == idCiudad) {
                            out.println("<br>");
                            out.println("<i class='alert alert-danger'>Debe modificar al menos un campo para guardar los cambios.</i>");
                            return; // Salir del método si no hay cambios
                        }
                    }
                }
            }

            // Si todas las validaciones pasan y hay cambios, actualizar en la base de datos
            String updateSQL = "UPDATE clientes SET nombre = ?, apellido = ?, ci = ?, telefono = ?, idciudad = ? WHERE idclientes = ?";
            try (PreparedStatement psUpdate = conn.prepareStatement(updateSQL)) {
                psUpdate.setString(1, nombre);
                psUpdate.setString(2, apellido);
                psUpdate.setString(3, ruc);
                psUpdate.setString(4, telefono);
                psUpdate.setInt(5, idCiudad);  // Convertir ciudad a INTEGER
                psUpdate.setInt(6, pk);  // Usar setInt para el tipo INTEGER
                psUpdate.executeUpdate();
                out.println("<br>");
                out.println("<i class='alert alert-success'>DATOS ACTUALIZADOS</i>");
            }

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
            st.executeUpdate("delete from clientes where idclientes='" + pk + "'");
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