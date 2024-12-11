<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ include file="jsp/conexion.jsp" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<script src="assets/js/numero.js"></script>

<%
    try {
        // Obtén pkimp y otros parámetros desde la sesión
        String codigo = (String) session.getAttribute("pkimps");
        Integer cinco = (Integer) session.getAttribute("cinco");
        Integer exenta = (Integer) session.getAttribute("exenta");
        Integer diez = (Integer) session.getAttribute("diez");
        Integer liqiva10 = (Integer) session.getAttribute("liqiva10");
        Integer total = (Integer) session.getAttribute("total");
        Integer letras = (Integer) session.getAttribute("letras");
        String letrasConvertidas = (String) session.getAttribute("totalEnLetras");

        // Verifica los valores recuperados (esto es solo para depuración, no se debería hacer en producción)
        System.out.println("codigo: " + codigo);
        System.out.println("cinco: " + cinco);
        System.out.println("exenta: " + exenta);
        System.out.println("liqiva10: " + liqiva10);
        System.out.println("total: " + total);
        System.out.println("letras: " + letrasConvertidas);
%>

<!-- Muestra el valor de letras en el campo de texto -->

<%   
        

        if (codigo != null && !codigo.isEmpty()) {
            // Verifica que el archivo .jasper existe
            File reportFile = new File(application.getRealPath("reportes/facturaventa.jasper"));
            if (!reportFile.exists()) {
                throw new FileNotFoundException("El archivo de reporte no se encuentra en la ruta: " + reportFile.getPath());
            }

            // Manejo de parámetros para JasperReports
            Map<String, Object> parametros = new HashMap<>();
            parametros.put("facturas", Integer.parseInt(codigo));
            parametros.put("cincos", cinco != null ? cinco.toString() : "");
            parametros.put("exenta", exenta != null ? exenta.toString() : "");
            parametros.put("diez", diez != null ? diez.toString() : "");
            parametros.put("liqiva10", liqiva10 != null ? liqiva10.toString() : "");
            parametros.put("total", total != null ? total.toString() : "");
            parametros.put("letras", letrasConvertidas != null ? letrasConvertidas.toString() : "");

            // Ejecutar el reporte
            byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);

            // Configurar la respuesta para la descarga del archivo PDF
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);

            ServletOutputStream output = response.getOutputStream();
            output.write(bytes, 0, bytes.length);
            output.flush();
            output.close();

            // Remueve el valor de pkimps de la sesión para evitar reutilización indebida
            session.removeAttribute("pkimps");
        } else {
%>
<script type="text/javascript">
    alert('El parámetro pkimps no se recibió correctamente o ya fue utilizado.');
    window.close();
</script>
<%
        }
    } catch (java.io.FileNotFoundException ex) {
        ex.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el reporte: " + ex.getMessage());
    } catch (Exception ex) {
        ex.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el reporte: " + ex.getMessage());
    }
%>
