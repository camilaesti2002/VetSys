<%@ include file="conexion.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    if (request.getParameter("listar").equals("buscarInforme")) {
        try {
            StringBuilder query = new StringBuilder();
            query.append("SELECT c.nombre as clinombre, m.nombre as metodonombre,ct.total,ct.fecha ");
            query.append("FROM consulta ct ");
            query.append("INNER JOIN clientes c ON c.idclientes = ct.idclientes INNER JOIN metododepago m on m.idmetodo=ct.idmetodo ");
            query.append("WHERE 1=1 ");
            // Agregar filtros dinámicamente
            if (request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").isEmpty() &&
                request.getParameter("fechaFin") != null && !request.getParameter("fechaFin").isEmpty()) {
                query.append("AND ct.fecha BETWEEN '").append(request.getParameter("fechaInicio"))
                     .append("' AND '").append(request.getParameter("fechaFin")).append("' ");
            }
    
            if (request.getParameter("proveedor") != null && !request.getParameter("proveedor").isEmpty()) {
                query.append("AND dt.idpacientes = ").append(request.getParameter("proveedor")).append(" ");
            }
            query.append("ORDER BY ct.idconsulta ASC");
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query.toString());
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            while (rs.next()) {
                Date fechaCompra = rs.getDate("fecha");
                String fechaFormateada = sdf.format(fechaCompra);
%>
                <tr class="small align-middle">
    <td class="py-1 px-2"><%= rs.getString("clinombre") %></td>
    <td class="py-1 px-2"><%= rs.getString("metodonombre") %></td>
     <td class="py-1 px-2"><%= rs.getString("total") %></td>
    <td class="py-1 px-2"><%= fechaFormateada %></td>
  
</tr>
<%
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            out.println("Error en la consulta: " + e.getMessage());
        }
    }
%>