<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ include file="jsp/conexion.jsp" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {
        // Obtén pkimp desde la sesión
        String codigo = (String) session.getAttribute("pkimp");
        
        if (codigo != null && !codigo.isEmpty()) {
            File reportFile = new File(application.getRealPath("reportes/reporteusuarios.jasper"));
            Map parametros = new HashMap();
            parametros.put("idusuarios", Integer.parseInt(codigo));
            
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);
            
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            
            ServletOutputStream output = response.getOutputStream();
            output.write(bytes, 0, bytes.length);
            output.flush();
            output.close();
            
            // Remueve el valor de pkimp de la sesión para evitar reutilización indebida
            session.removeAttribute("pkimp");
        } else {
            // En lugar de mostrar un mensaje, se cierra la página después de mostrar un alert
%>
            <script type="text/javascript">
                alert('El parámetro pkimp no se recibió correctamente o ya fue utilizado.');
                window.close();
            </script>
<%
        }
    } catch (java.io.FileNotFoundException ex) {
        ex.getMessage();
    }
%>

