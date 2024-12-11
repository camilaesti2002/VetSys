<%@ include file="conexion.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    if (request.getParameter("listar").equals("buscarInforme")) {
        try {
            StringBuilder query = new StringBuilder();
            query.append("SELECT p.ci, c.fecha, CONCAT(p.nombre, ' ', p.apellido) AS nombre_completo, c.total, c.idconsulta, c.condicion,c.estado ");
            query.append("FROM consulta c ");
            query.append("INNER JOIN clientes p ON p.idclientes = c.idclientes ");
            query.append("WHERE 1=1 ");

            // Agregar filtros dinámicamente
            if (request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").isEmpty() &&
                request.getParameter("fechaFin") != null && !request.getParameter("fechaFin").isEmpty()) {
                query.append("AND c.fecha BETWEEN '").append(request.getParameter("fechaInicio"))
                     .append("' AND '").append(request.getParameter("fechaFin")).append("' ");
            }

            if (request.getParameter("numeroFactura") != null && !request.getParameter("numeroFactura").isEmpty()) {
                query.append("AND c.numero = '").append(request.getParameter("numeroFactura")).append("' ");
            }

            if (request.getParameter("condicion") != null && !request.getParameter("condicion").isEmpty()) {
                query.append("AND c.condicion = '").append(request.getParameter("condicion")).append("' ");
            }

            if (request.getParameter("estado") != null && !request.getParameter("estado").isEmpty()) {
                query.append("AND c.estado = '").append(request.getParameter("estado")).append("' ");
            }

            if (request.getParameter("proveedor") != null && !request.getParameter("proveedor").isEmpty()) {
                query.append("AND c.idclientes = ").append(request.getParameter("proveedor")).append(" ");
            }

            query.append("ORDER BY c.idconsulta ASC");

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query.toString());
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

            while (rs.next()) {
                Date fechaCompra = rs.getDate("fecha");
                String fechaFormateada = sdf.format(fechaCompra);
%>
                <tr class="small align-middle">
    <td class="py-1 px-2"><%= rs.getString("idconsulta") %></td>
    <td class="py-1 px-2"><%= fechaFormateada %></td>
    <td class="py-1 px-2"><%= rs.getString("nombre_completo") %></td>
    <td class="py-1 px-2"><%= rs.getString("ci") %></td>
    <td class="py-1 px-2"><%= rs.getString("condicion") %></td>
    <td class="py-1 px-2"><%= rs.getString("estado") %></td>
    <td class="py-1 px-2"><%= rs.getString("total") %></td>
  
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