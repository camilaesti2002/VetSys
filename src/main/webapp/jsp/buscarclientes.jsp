<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    // Capturar parámetros de solicitud
    String listar = request.getParameter("listar");
    String selectedDay = request.getParameter("dia");
    String selectedTime = request.getParameter("hora");

    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        if ("buscarDoctoresDisponibles".equals(listar)) {
            String query = "SELECT DISTINCT d.iddoctores, d.nombre " +
                           "FROM doctores d " +
                           "INNER JOIN horarios h ON d.iddoctores = h.iddoctores " +
                           "WHERE h.dias LIKE ? ";

            if (selectedTime != null && !selectedTime.isEmpty()) {
                query += " AND ? BETWEEN h.hora_inicio AND h.hora_fin";
            }

            ps = conn.prepareStatement(query);
            int paramIndex = 1;
            ps.setString(paramIndex++, "%" + selectedDay + "%");
            if (selectedTime != null && !selectedTime.isEmpty()) {
                ps.setString(paramIndex, selectedTime);
            }

            rs = ps.executeQuery();

            // Enviar las opciones al cliente
            response.setContentType("text/html;charset=UTF-8");
            out.println("<option value='0'>Seleccione un doctor</option>");
            while (rs.next()) {
                out.println("<option value='" + rs.getString("iddoctores") + "'>" +
                            rs.getString("nombre") + "</option>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<option value='0'>Error al cargar doctores</option>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
