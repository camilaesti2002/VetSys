<%-- Archivo: jsp/verificarEstado.jsp --%>
<%@ include file="conexion.jsp" %>
<%
    try {
        String idpk = request.getParameter("idpk");
        if (idpk != null && !idpk.trim().isEmpty()) {
            // Consulta para obtener el estado
            String sql = "SELECT estado FROM consulta WHERE idoconsulta = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idpk));
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Enviar el estado como respuesta
                out.print(rs.getString("estado"));
            } else {
                out.print("Error: ID no encontrado");
            }

            rs.close();
            ps.close();
        } else {
            out.print("Error: ID no proporcionado");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
