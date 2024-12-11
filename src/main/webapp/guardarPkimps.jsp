<%@ include file="jsp/conexion.jsp" %>
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String pkimps = request.getParameter("pkimps");
    String totalEnLetras = request.getParameter("totalEnLetras");
    System.out.println("Valor de totalEnLetras del String: " + totalEnLetras);
    if (pkimps != null && !pkimps.isEmpty()) {
        int idVentas = Integer.parseInt(pkimps);
        session.setAttribute("pkimps", pkimps);
        session.setAttribute("totalEnLetras", totalEnLetras);
        String sql = "SELECT CAST(detalleconsulta.precio AS integer) AS precio, detalleconsulta.iva AS iva, 0 AS exenta, 0 AS cinco, CAST(CAST(detalleconsulta.precio AS numeric) * CAST(detalleconsulta.cantidad AS numeric) AS integer) AS diez, CAST(CAST(detalleconsulta.precio AS numeric) * CAST(detalleconsulta.cantidad AS numeric) / 11 AS integer) AS liqiva10, CAST(detalleconsulta.precio AS integer) AS total FROM detalleconsulta INNER JOIN consulta ON detalleconsulta.idconsulta = consulta.idconsulta WHERE consulta.idconsulta = ?;";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idVentas);
        
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            session.setAttribute("precio", rs.getInt("precio"));
            session.setAttribute("iva", rs.getInt("iva"));
            session.setAttribute("exenta", rs.getInt("exenta"));
            session.setAttribute("cinco", rs.getInt("cinco"));
            session.setAttribute("diez", rs.getInt("diez"));
            session.setAttribute("liqiva10", rs.getInt("liqiva10"));
            session.setAttribute("total", rs.getInt("total"));
            System.out.println("pkimps en la sesión: " + session.getAttribute("pkimps"));
            System.out.println("totalEnLetras en la sesión: " + session.getAttribute("totalEnLetras"));
   
            System.out.println("total en la sesión: " + session.getAttribute("total"));
        }
        
        rs.close();
        ps.close();
    } else {
        out.println("Error: pkimps no recibido.");
    }
%>

