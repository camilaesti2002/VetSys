<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    // Obtén el parámetro idclientes y listar de la solicitud
    String idclientes = request.getParameter("idclientes");
    String listar = request.getParameter("listar");
    
    // Depuración: imprime el valor recibido de idclientes
    out.println("ID Cliente recibido: " + idclientes + "<br>");

    // Verifica si idclientes es nulo o vacío, asigna un valor por defecto si es necesario
    if (idclientes == null || idclientes.trim().isEmpty()) {
        idclientes = "0"; // O cualquier valor por defecto que tenga sentido en tu caso
    }
    
    // Declara el objeto Statement y ResultSet fuera del bloque try para el manejo de recursos
    Statement st = null;
    ResultSet rs = null;
    
    try {
        // Crea un Statement para ejecutar la consulta
        st = conn.createStatement();
        
        // Verifica el valor del parámetro listar para decidir qué consulta ejecutar
        if ("buscaranimal".equals(listar)) {
            // Consulta para obtener pacientes basado en idclientes
            String query = "SELECT * FROM pacientes WHERE idclientes='" + idclientes + "' ORDER BY idpaciente ASC";
            rs = st.executeQuery(query);
%>
<select name="propiedad" id="propiedad">
    <option value="0" id="per">Seleccione un paciente</option>
    <%
        // Recorre el ResultSet y crea las opciones del select
        while (rs.next()) {
    %>
    <option value="<%= rs.getString(1) %>"><%= rs.getString(1) %> <%= rs.getString(2) %></option>
    <%
        }
    %>
</select>
<%
        } else if ("buscarcliente".equals(listar)) {
            // Consulta para obtener clientes
            String query = "SELECT * FROM clientes ORDER BY idclientes ASC";
            rs = st.executeQuery(query);
%>
<select name="cliente" id="cliente">
    <option value="0" id="per">Seleccione un cliente</option>
    <%
        // Recorre el ResultSet y crea las opciones del select
        while (rs.next()) {
    %>
    <option value="<%= rs.getString(1) %>,<%= rs.getString(4) %>"><%= rs.getString(2) %> <%= rs.getString(3) %></option>
    <%
        }
    %>
</select>
<%
        } else if ("buscarpropiedad".equals(listar)) {
            // Consulta para obtener doctores
            String query = "SELECT * FROM doctores ORDER BY iddoctores ASC";
            rs = st.executeQuery(query);
%>
<select name="propiedad" id="propiedad">
    <option value="0" id="per">Seleccione un doctor</option>
    <%
        // Recorre el ResultSet y crea las opciones del select
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
    <option value="0" id="per">Seleccione un síntoma</option>
    <%
        // Recorre el ResultSet y crea las opciones del select
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
    <option value="0" id="per">Seleccione un medicamento</option>
    <%
        // Recorre el ResultSet y crea las opciones del select
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
        // Maneja cualquier excepción y muestra un mensaje de error
        out.println("error PSQL: " + e + "<br>");
    } finally {
        try {
            // Cierra los recursos en el bloque finally
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
