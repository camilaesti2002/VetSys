<%@ include file="conexion.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    if (request.getParameter("listar").equals("buscarInforme")) {
        try {
            StringBuilder query = new StringBuilder();
          query.append("SELECT p.nombre, s.nombre AS sintomasnombre, md.nombre AS medicamentonombre, dt.recetas, dt.cantidad, c.fecha, dt.idpacientes ");
              query.append("FROM detalleconsulta dt ");
              query.append("INNER JOIN consulta c ON c.idconsulta = dt.idconsulta ");
              query.append("INNER JOIN pacientes p ON p.idpaciente = dt.idpacientes ");
              query.append("INNER JOIN sintomas s ON s.idsintomas = dt.idsintomas ");
              query.append("INNER JOIN medicamentos md ON md.idmedicamentos = dt.idmedicamentos ");
              query.append("WHERE 1=1 ");

            // Agregar filtros dinámicamente
            if (request.getParameter("fechaInicio") != null && !request.getParameter("fechaInicio").isEmpty() &&
                request.getParameter("fechaFin") != null && !request.getParameter("fechaFin").isEmpty()) {
                query.append("AND c.fecha BETWEEN '").append(request.getParameter("fechaInicio"))
                     .append("' AND '").append(request.getParameter("fechaFin")).append("' ");
            }

    

            if (request.getParameter("proveedor") != null && !request.getParameter("proveedor").isEmpty()) {
                query.append("AND dt.idpacientes = ").append(request.getParameter("proveedor")).append(" ");
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
    <td class="py-1 px-2"><%= rs.getString("sintomasnombre") %></td>
    <td class="py-1 px-2"><%= rs.getString("medicamentonombre") %></td>
    <td class="py-1 px-2"><%= rs.getString("recetas") %></td>

  
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