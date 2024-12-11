<%@include file="conexion.jsp" %>
<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT iddoctores,nombre FROM doctores");
        // Agrega el primer <option> de selección
        out.println("<option value=''>Seleccione un doctor</option>");
        while (rs.next()) {
            out.println("<option value='" + rs.getString("iddoctores") + "'>" + rs.getString("nombre") + "</option>");
        }
    } catch(Exception e) {
        out.println("Error SQL: " + e.getMessage());
    }
%>
