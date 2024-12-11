<%@ include file="conexion.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    if (request.getParameter("listar").equals("buscarInforme")) {
        try {
            StringBuilder query = new StringBuilder();
            query.append("SELECT p.nombre, dt.cantidad, dt.precio,c.fecha,c.iddoctores ");
            query.append("FROM detalleconsulta dt ");
            query.append("inner join  consulta c ON c.idconsulta = dt.idconsulta INNER JOIN doctores p on p.iddoctores=c.iddoctores");
            query.append("WHERE 1=1");

            // Agregar filtros dinámicamente
            if (request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").isEmpty() &&
                request.getParameter("fechaFin") != null && !request.getParameter("fechaFin").isEmpty()) {
                query.append("AND c.fecha BETWEEN '").append(request.getParameter("fechaInicio"))
                     .append("' AND '").append(request.getParameter("fechaFin")).append("' ");
            }

    

            if (request.getParameter("proveedor") != null && !request.getParameter("proveedor").isEmpty()) {
                query.append("AND c.iddoctores = ").append(request.getParameter("proveedor")).append(" ");
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
    <td class="py-1 px-2"><%= rs.getString("nombre") %></td>
    <td class="py-1 px-2"><%= rs.getString("precio") %></td>

  
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