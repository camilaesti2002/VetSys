<%@include file="conexion.jsp" %>
<%
    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT idpaciente, nombre FROM pacientes");
        // Agrega el primer <option> de selección
        out.println("<option value=''>Seleccione un paciente</option>");
        while (rs.next()) {
            out.println("<option value='" + rs.getString("idpaciente") + "'>" + rs.getString("nombre") + "</option>");
        }
    } catch(Exception e) {
        out.println("Error SQL: " + e.getMessage());
    }
%>
