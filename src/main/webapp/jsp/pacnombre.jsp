<%@include file="conexion.jsp" %>
<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idpaciente, nombre FROM pacientes");
        while (rs.next()) {
            out.println("<option value='" + rs.getString("idpaciente") + "'>" + rs.getString("nombre") + "</option>");
        }
    } catch(Exception e) {
        out.println("Error SQL: " + e.getMessage());
    }
%>

