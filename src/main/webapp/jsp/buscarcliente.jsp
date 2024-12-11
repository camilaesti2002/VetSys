<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
     // Obtener parámetros de solicitud
    String listar = request.getParameter("listar");

    String idclientes = request.getParameter("idclientes");
    String idDoctores = request.getParameter("iddoctores");
    
    
    // Verifica si idclientes es nulo o vacío, asigna un valor por defecto si es necesario
    if (idclientes == null || idclientes.trim().isEmpty()) {
        idclientes = "0"; // Valor por defecto
    }

    Statement st = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    try {
        st = conn.createStatement();
        
        // Validar si se busca la lista de clientes
        if ("buscarcliente".equals(listar)) {
            String query = "select DISTINCT c.idclientes,c.nombre,c.apellido,c.ci from pacientes inner join clientes c  on pacientes.idclientes =c.idclientes  ORDER BY c.idclientes ASC ";
            rs = st.executeQuery(query);
%>
<select id="cliente">
    <option value="0">Seleccione un cliente</option>
    <%
        while (rs.next()) {
    %>
    out.printl("<option value="<% out.print(rs.getString(1)); %>,<% out.print(rs.getString(4)); %>"><% out.print(rs.getString(1)); %>-<% out.print(rs.getString(2)); %></option>")

    <%
        }
    %>
</select>

<%
        // Validar si se busca la lista de doctores
        } else if ("buscarpropiedad".equals(listar)) {
            String query = "SELECT * FROM doctores ORDER BY iddoctores ASC";
            rs = st.executeQuery(query);
%>
<select name="propiedad" id="propiedad">
    <option value="0">Seleccione un doctors</option>
    <%
        while (rs.next()) {
    %>
    <option value="<%= rs.getString(1) %>"><%= rs.getString(1) %> <%= rs.getString(2) %></option>
    <%
        }
    %>
</select>
<%
        // Validar si se buscan los horarios del doctor seleccionado
        } else if ("buscarhorarios".equals(listar) && idDoctores != null) {
            // Consulta para obtener los horarios del doctor seleccionado
            String query = "SELECT h.hora_inicio, h.hora_fin FROM doctores d INNER JOIN horarios h ON d.iddoctores = h.iddoctores WHERE d.iddoctores = ?";
             ps = conn.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(idDoctores));
            rs = ps.executeQuery();

            if (rs.next()) {
                String horaInicio = rs.getString("hora_inicio");
                String horaFin = rs.getString("hora_fin");

                // Devolver horarios en formato JSON
                out.print("{\"hora_inicio\": \"" + horaInicio + "\", \"hora_fin\": \"" + horaFin + "\"}");
            } else {
                // Si no hay horarios, devolver JSON vacío
                out.print("{\"hora_inicio\": \"\", \"hora_fin\": \"\"}");
            }

            rs.close();
            ps.close();
        } else if ("buscaranimal".equals(listar)) {
            // Consulta para obtener pacientes basado en idclientes
            String query = "SELECT * FROM pacientes WHERE idclientes='" + idclientes + "' ORDER BY idpaciente ASC";
            rs = st.executeQuery(query);
%>
<select name="paciente" id="paciente">
    <option value="0">Seleccione un paciente</option>
    <%
        while (rs.next()) {
    %>
    <option value="<%= rs.getString(1) %>"><%= rs.getString(1) %> <%= rs.getString(2) %></option>
    <%
        }
    %>
</select>
<%
        } else if ("buscarsintomas".equals(listar)) {
            // Consulta para obtener síntomas
            String query = "SELECT * FROM sintomas ORDER BY idsintomas ASC";
            rs = st.executeQuery(query);
%>
<select name="sintomas" id="sintomas">
    <option value="0">Seleccione un síntoma</option>
    <%
        while (rs.next()) {
    %>
    <option value="<%= rs.getString(1) %>"><%= rs.getString(1) %> <%= rs.getString(2) %></option>
    <%
        }
    %>
</select>
<%
        } else if ("buscarmedicamentos".equals(listar)) {
            // Consulta para obtener medicamentos
            String query = "SELECT * FROM medicamentos ORDER BY idmedicamentos ASC";
            rs = st.executeQuery(query);
%>
<select name="medicamentos" id="medicamentos">
    <option value="0">Seleccione un medicamento</option>
    <%
        while (rs.next()) {
    %>
    <option value="<%= rs.getString(1) %>"><%= rs.getString(1) %> <%= rs.getString(2) %></option>
    <%
        }
    %>
</select>
<%
        } 
    } catch (Exception e) {
        out.println("Error PSQL: " + e + "<br>");
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {
            out.println("Error al cerrar la conexión: " + ex + "<br>");
        }
    }
%>
