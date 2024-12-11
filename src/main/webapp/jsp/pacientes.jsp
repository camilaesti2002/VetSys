<%@include file="conexion.jsp" %>
<%
if (request.getParameter("listar").equals("listar")) {
    try {
        Statement st = null;
        ResultSet rs = null;
        st = conn.createStatement();
        rs = st.executeQuery("SELECT p.idpaciente, p.nombre, r.nombre, p.edad, p.sexo, p.peso, p.idclientes, cli.nombre AS nombre_cliente,r.idraza,especie.nombre as especienombre FROM pacientes p INNER JOIN clientes cli ON p.idclientes = cli.idclientes INNER JOIN raza r ON p.idraza = r.idraza inner join especie on r.idespecies=especie.idespecies ORDER BY p.idpaciente");

        while (rs.next()) {
%>
<tr>
    <td><% out.print(rs.getString(1)); %></td>
    <td><% out.print(rs.getString(2)); %></td>
    <td><% out.print(rs.getString(10)); %></td>
    <td><% out.print(rs.getString(3)); %></td>
    <td><% out.print(rs.getString(4)); %></td>
    <td><% out.print(rs.getString(5)); %></td>
    <td><% out.print(rs.getString(6)); %></td>
    <td><% out.print(rs.getString(7)); %></td>
    <td><% out.print(rs.getString(8)); %></td>
    <td class="edit-botones">  
        <li class="btn btn-outline-warning" onclick="rellenadospac('<% out.print(rs.getString(1)); %>', '<% out.print(rs.getString(2)); %>', '<% out.print(rs.getString(9)); %>', '<% out.print(rs.getString(4)); %>', '<% out.print(rs.getString(5)); %>', '<% out.print(rs.getString(6)); %>', '<% out.print(rs.getString(7)); %>')">
    <img src="img/editar.png" >
</li>

        <li class="btn btn-outline-danger" onclick="$('#pkdel').val('<% out.print(rs.getString(1)); %>')" title="Eliminar Clientes" data-bs-toggle="modal" data-bs-target="#exampleModal">
            <img src="img/borrar.png" >
        </li>
        <button class="btn btn-outline-danger" onclick="$('#pkimp').val(<% out.print(rs.getString(1)); %>)" title="Imprimir Persona" data-bs-toggle="modal" data-bs-target="#exampleModals">
            <img src="img/impresora.png" >
        </button>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("<br>");
        out.println("Error en la consulta: " + e.getMessage());
    }
} else if (request.getParameter("listar").equals("cargar")) {
        String nombre = request.getParameter("nombre");
        String raza = request.getParameter("raza");
        String edad = request.getParameter("edad");
        String sexo = request.getParameter("sexo");
        String peso = request.getParameter("peso");
        String clientes = request.getParameter("clientes");

        try {
            Statement st = conn.createStatement();
            st.executeUpdate("INSERT INTO pacientes(nombre,idraza,edad,sexo,peso,idclientes) VALUES ('" + nombre + "','" + raza + "','" + edad + "','" + sexo + "','" + peso + "','" + clientes + "')");
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS CARGADOS</i>");

        } catch (SQLException e) {
            out.println("<br>");
            out.println("Error SQL al insertar datos: " + e.getMessage());
        } catch (Exception e) {
            out.println("<br>");
            out.println("Error general al insertar datos: " + e.getMessage());
        }
    } else if (request.getParameter("listar").equals("modificar")) {
        String pk = request.getParameter("pk");
        String nombre = request.getParameter("nombre");
        String raza = request.getParameter("raza");
        String edad = request.getParameter("edad");
        String sexo = request.getParameter("sexo");
        String peso = request.getParameter("peso");
        String clientes = request.getParameter("clientes");

        try {
            // Obtener los valores actuales de la base de datos
            String queryCurrentData = "SELECT nombre, idraza, edad, sexo, peso, idclientes FROM pacientes WHERE idpaciente = ?";
            PreparedStatement psCurrentData = conn.prepareStatement(queryCurrentData);
            psCurrentData.setInt(1, Integer.parseInt(pk)); // Conversión a entero
            ResultSet rsCurrentData = psCurrentData.executeQuery();

            if (rsCurrentData.next()) {
                String currentNombre = rsCurrentData.getString("nombre");
                String currentRaza = rsCurrentData.getString("idraza");
                int currentEdad = rsCurrentData.getInt("edad"); // Edad es un entero
                String currentSexo = rsCurrentData.getString("sexo");
                int currentPeso = rsCurrentData.getInt("peso"); // Peso es un entero
                int currentClientes = rsCurrentData.getInt("idclientes"); // idclientes es un entero

                // Verificar si los nuevos datos son diferentes de los actuales
                if (currentNombre.equals(nombre) && currentRaza.equals(raza)
                        && currentEdad == Integer.parseInt(edad) && currentSexo.equals(sexo)
                        && currentPeso == Integer.parseInt(peso) && currentClientes == Integer.parseInt(clientes)) {
                    // Los datos no han cambiado, mostrar mensaje de error
                    out.println("<br>");
                    out.println("<i class='alert alert-danger'>Debe modificar al menos un campo para guardar los cambios.</i>");
                    return; // Salir del método si no hay cambios
                }
            }

            // Si los datos han cambiado, actualizar en la base de datos
            String updateSQL = "UPDATE pacientes SET nombre = ?, idraza = ?, edad = ?, sexo = ?, peso = ?, idclientes = ? WHERE idpaciente = ?";
            PreparedStatement psUpdate = conn.prepareStatement(updateSQL);
            psUpdate.setString(1, nombre);
            psUpdate.setInt(2, Integer.parseInt(raza));
            psUpdate.setInt(3, Integer.parseInt(edad)); // Conversión a entero
            psUpdate.setString(4, sexo);
            psUpdate.setInt(5, Integer.parseInt(peso)); // Conversión a entero
            psUpdate.setInt(6, Integer.parseInt(clientes)); // Conversión a entero
            psUpdate.setInt(7, Integer.parseInt(pk)); // Conversión a entero
            psUpdate.executeUpdate();
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
            st.executeUpdate("delete from pacientes where idpaciente='" + pk + "'");
            out.println("<br>");
            out.println("<i class='alert alert-success'>DATOS ELIMINADOS</i>");
        } catch (SQLException e) {
            if (e.getSQLState().equals("23503")) {
                out.println("<br>");
                out.println("<i class='alert alert-danger'>Este paciente se utiliza en un registro.</i>");
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