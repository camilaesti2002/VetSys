<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String pkimp = request.getParameter("pkimp");
    if (pkimp != null && !pkimp.isEmpty()) {
        session.setAttribute("pkimp", pkimp);
        out.println("pkimp guardado en la sesión.");  // Puedes eliminar este mensaje en producción
    } else {
        out.println("Error: pkimp no recibido.");
        }
%>