<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String listar = request.getParameter("listar");
    String idconsulta = request.getParameter("idconsulta");

    if ("buscarcliente".equals(listar) && idconsulta != null) {
        PreparedStatement pst = conn.prepareStatement(
            "SELECT c.idconsulta, cli.nombre, cli.apellido, cli.documento, cli.telefono, c.fecharegistro, c.hora, c.precio, p.nombre AS doctorNombre " +
            "FROM consulta c " +
            "JOIN cliente cli ON c.idcliente = cli.idcliente " +
            "JOIN producto p ON c.idproducto = p.idproducto " +
            "WHERE c.idconsulta = ?");
        pst.setString(1, idconsulta);
        
        ResultSet rs = pst.executeQuery();
        
        if (rs.next()) {
            String clienteNombre = rs.getString("nombre") + " " + rs.getString("apellido");
            String clienteDocumento = rs.getString("documento");
            String clienteTelefono = rs.getString("telefono");
            String fechaRegistro = rs.getString("fecharegistro");
            String hora = rs.getString("hora");
            String precio = rs.getString("precio");
            String doctorNombre = rs.getString("doctorNombre");
            
            // Construcción del JSON
            String jsonResponse = "{";
            jsonResponse += "\"clienteNombre\":\"" + clienteNombre + "\",";
            jsonResponse += "\"clienteDocumento\":\"" + clienteDocumento + "\",";
            jsonResponse += "\"clienteTelefono\":\"" + clienteTelefono + "\",";
            jsonResponse += "\"Fecha\":\"" + fechaRegistro + "\",";
            jsonResponse += "\"Hora\":\"" + hora + "\",";
            jsonResponse += "\"Total\":\"" + precio + "\",";
            jsonResponse += "\"doctorNombre\":\"" + doctorNombre + "\"";
            jsonResponse += "}";
            
            out.print(jsonResponse);
        } else {
            // Si no se encontró ninguna consulta
            String jsonResponse = "{\"error\":\"Consulta no encontrada\"}";
            out.print(jsonResponse);
        }
    } else {
        // Si los parámetros son incorrectos
        String jsonResponse = "{\"error\":\"Parámetros no válidos\"}";
        out.print(jsonResponse);
    }
%>
