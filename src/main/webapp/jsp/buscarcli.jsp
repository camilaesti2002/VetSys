<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    try {
        if ("buscarcliente".equals(request.getParameter("listar"))) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM personas WHERE per_tipo = 'CLIENTE' ORDER BY idpersonas ASC");
%>
                <option value="0" id="per">Seleccione un cliente</option>
<%
            while (rs.next()) {
%>  
                <option value="<%= rs.getString(7) %>,<%= rs.getString(3) %>"><%= rs.getString(1) %> <%= rs.getString(2) %> </option>
<% 
            }
        } else if ("buscarpropiedad".equals(request.getParameter("listar"))) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM propiedades WHERE prop_stock= 'VENTA' AND prop_tipo='VENTA' ORDER BY idpropiedades ASC");
%>
                <option value="0" id="per">Seleccione una propiedad</option>
<%
            while (rs.next()) {
%>  
                <option value="<%= rs.getString(1) %>,<%= rs.getString(9) %>"><%= rs.getString(1) %> <%= rs.getString(2) %> <%= rs.getString(3) %></option>
<%
            }
        } else if ("buscarclientes".equals(request.getParameter("listar"))) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT DISTINCT p.idpersonas, p.per_nombre, p.per_apellido, p.per_ci FROM cuentaclientes c INNER JOIN ventas v ON c.idventas = v.idventas INNER JOIN personas p ON v.idpersonas = p.idpersonas WHERE c.cue_estado = 'PENDIENTE' ORDER BY p.idpersonas ASC;");
%>
                <option value="0" id="per">Seleccione un cliente</option>
<%
            while (rs.next()) {
%>  
                <option value="<%= rs.getString(1) %>,<%= rs.getString(4) %>"><%= rs.getString(2) %> <%= rs.getString(3) %> </option>
<% 
            }
        } else if ("buscarclientess".equals(request.getParameter("listar"))) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT DISTINCT p.idpersonas, p.per_nombre, p.per_apellido, p.per_ci FROM cuentasalquiler c INNER JOIN contrato v ON c.idcontratos = v.idcontratos INNER JOIN personas p ON v.idpersonas = p.idpersonas WHERE c.cue_estado = 'PENDIENTE' ORDER BY p.idpersonas ASC;");
%>
                <option value="0" id="per">Seleccione un cliente</option>
<%
            while (rs.next()) {
%>  
                <option value="<%= rs.getString(1) %>,<%= rs.getString(4) %>"><%= rs.getString(2) %> <%= rs.getString(3) %> </option>
<% 
            }
        } else if ("buscarproveedor".equals(request.getParameter("listar"))) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT DISTINCT p.idproveedores, p.prov_nombre, p.prov_ruc FROM cuentaproveedor c INNER JOIN compras co ON c.idcompras= co.idcompras INNER JOIN proveedores p ON co.idproveedores =p.idproveedores WHERE c.cue_estado = 'PENDIENTE' ORDER BY p.idproveedores ASC;");
%>
                <option value="0" id="per">Seleccione un proveedor</option>
<%
            while (rs.next()) {
%>  
                <option value="<%= rs.getString(1) %>,<%= rs.getString(3) %>"><%= rs.getString(2) %>  </option>
<% 
            }
        } else if ("buscarpropiedades".equals(request.getParameter("listar"))) { 
            // Nueva condición para listar propiedades con prop_stock = 3 y prop_tipo = 'ALQUILER'
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM propiedades where prop_tipo='ALQUILER' ORDER BY idpropiedades ASC");
%>
                <option value="0" id="per">Seleccione una propiedad para alquiler</option>
<%
            while (rs.next()) {
%>  
                <option value="<%= rs.getString(1) %>,<%= rs.getString(4) %>"><%= rs.getString(1) %> <%= rs.getString(2) %> <%= rs.getString(3) %></option>
<% 
            }
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
