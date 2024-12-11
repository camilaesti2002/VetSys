<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    try {
        if ("buscardoctor".equals(request.getParameter("listar"))) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT h.idhorarios, h.dias, h.hora_inicio, h.hora_fin, h.iddoctores, d.nombre FROM horarios h INNER JOIN doctores d ON h.iddoctores = d.iddoctores ORDER BY h.idhorarios;");
            
            boolean hayResultados = false; // Variable para verificar si hay resultados
%>
            <select name="cliente" id="cliente">
<%
            while (rs.next()) {
                hayResultados = true; // Si hay al menos un resultado, se actualiza esta variable
%>  
                <option value="<%= rs.getString(5) %>,<%= rs.getString(3) %>,<%= rs.getString(4) %>,<%= rs.getString(2) %>">
                    <%= rs.getString(5) %> <%= rs.getString(6) %>
                </option>
<% 
            }

            // Si no hubo resultados en la consulta
            if (!hayResultados) {
%>
                <option value="0">No hay doctores disponibles</option>
<%
            }
%>
            </select>
<%
        }    
    } catch(Exception e) {
        out.println("Error PSQL: " + e);
    } finally {
        try {
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            out.println("Error al cerrar la conexión: " + ex);
        }
    }
%>
