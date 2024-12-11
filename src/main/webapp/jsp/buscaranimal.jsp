<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
if(request.getParameter("listar") != null && request.getParameter("idclientes") != null) {
    String sql = "SELECT idpaciente, nombre FROM pacientes WHERE idclientes = ? ORDER BY nombre";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, Integer.parseInt(request.getParameter("idclientes")));
        ResultSet rs = ps.executeQuery();
%>
        <option value="">Seleccione un animal</option>
<%
        while(rs.next()) {
%>
            <option value="<%= rs.getInt("idpaciente") %>"><%= rs.getString("nombre") %></option>
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
    <option value="">Seleccione un cliente primero</option>
<%
}
%>