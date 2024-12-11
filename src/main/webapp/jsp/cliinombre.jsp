<%@include file="conexion.jsp" %>
<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idclientes, nombre FROM clientes");
        while (rs.next()) {
            out.println("<option value='" + rs.getString("idclientes") + "'>" + rs.getString("nombre") + "</option>");
        }
    } catch(Exception e) {
        out.println("Error SQL: " + e.getMessage());
    }
%>
