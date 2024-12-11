<%@ include file="conexion.jsp" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>

<%    if (request.getParameter("listar") != null && request.getParameter("listar").equals("cargar")) {
    // DATOS PARA LA CABECERA
    String codalumno = request.getParameter("cliente");
    String codproducto = request.getParameter("idproducto");
    String fecharegistro = request.getParameter("fecharegistro");
    String usuario = request.getParameter("idusuarios");
    String precio = request.getParameter("precio");
    String cantidad = request.getParameter("hora");

    // Asegúrate de que codalumno contenga solo la parte antes de la coma
    if (codalumno != null && codalumno.contains(",")) {
        codalumno = codalumno.split(",")[0];
    }

    // Asegúrate de que codproducto contenga solo la parte antes de la coma
    if (codproducto != null && codproducto.contains(",")) {
        codproducto = codproducto.split(",")[0];
    }

    // Validar y convertir precio a entero
    Integer precioI = null;
    try {
        if (precio != null && !precio.trim().isEmpty()) {
            precioI = Integer.parseInt(precio);
        } else {
            out.println("Error: Precio no válido.");
            return;
        }
    } catch (NumberFormatException e) {
        out.println("Error: Precio no válido.");
        return;
    }

    Statement st = null;
    ResultSet rs = null;

    try {
        st = conn.createStatement();

        // Verificar si ya existe una cita con el mismo doctor, fecha y un lapso de 1 hora
        String checkQuery = "SELECT COUNT(*) as total FROM consulta WHERE iddoctores = '"
                + codproducto + "' AND fecha = '" + fecharegistro
                + "' AND hora BETWEEN '" + cantidad + "'::time - interval '1 hour' AND '" + cantidad + "'::time + interval '1 hour'";

        rs = st.executeQuery(checkQuery);

        if (rs.next() && rs.getInt("total") > 0) {
            // Ya existe una cita para este doctor en esta fecha y hora dentro del lapso de 1 hora
            out.println("<div id='errorMessage' class='alert alert-danger' style='width: 300px; margin: auto;'>"
                    + "Ya existe una cita programada con este doctor en la fecha y hora seleccionada, dentro del lapso de una hora.</div>");
            return;
        }

        // Si no existe una cita, procedemos con la inserción
        st.executeUpdate("INSERT INTO consulta(idclientes, fecha, idusuarios, hora, iddoctores) VALUES('"
                + codalumno + "','" + fecharegistro + "','" + usuario + "','" + cantidad + "','" + codproducto + "')");

        out.println("<div id='successMessage' class='alert alert-success' style='width: 300px; margin: auto;'>"
                + "Consulta registrada exitosamente.</div>");

    } catch (Exception e) {
        out.println("Error PSQL: " + e.getMessage());
    } finally {
        if (rs != null) try {
            rs.close();
        } catch (SQLException e) {
            /* Ignorar */ }
        if (st != null) try {
            st.close();
        } catch (SQLException e) {
            /* Ignorar */ }
    }
}



%>

<script>
    // Este script hará que el mensaje de éxito desaparezca después de 3 segundos
    setTimeout(function () {
        var successMessage = document.getElementById('successMessage');
        if (successMessage) {
            successMessage.style.display = 'none';
        }
    }, 3000); // 3000 milisegundos = 3 segundos
</script>
