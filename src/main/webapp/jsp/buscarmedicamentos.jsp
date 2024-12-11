<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
if(request.getParameter("listar") != null) {
    String sql = "SELECT idmedicamentos, nombre FROM medicamentos ORDER BY nombre";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
%>
        <option value="">Seleccione un medicamento</option>
<%
        while(rs.next()) {
%>
            <option value="<%= rs.getInt("idmedicamentos") %>"><%= rs.getString("nombre") %></option>
<%
        }
        rs.close();
    } catch(Exception e) {
%>
        <option value="">Error: <%= e.getMessage() %></option>
<%
    }
} else {
%>
    <option value="">Seleccione un medicamento</option>
<%
}
%>