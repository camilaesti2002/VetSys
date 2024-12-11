<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ include file="jsp/conexion.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
try {
    // Crear el mapa de parámetros
    Map<String, Object> parametros = new HashMap<>();
    
    // Construir la cláusula WHERE dinámica
    StringBuilder whereClause = new StringBuilder();
    whereClause.append(" WHERE 1=1 ");
    
    // Validar y agregar filtro de fechas
    String fechaInicio = request.getParameter("fechaInicio");
    String fechaFin = request.getParameter("fechaFin");
    if (fechaInicio != null && !fechaInicio.isEmpty() && 
        fechaFin != null && !fechaFin.isEmpty()) {
        whereClause.append("AND r.fecha BETWEEN '").append(fechaInicio)
                  .append("' AND '").append(fechaFin).append("' ");
        parametros.put("FECHA_INICIO", fechaInicio);
        parametros.put("FECHA_FIN", fechaFin);
    }
    
    // Validar y agregar filtro de número de factura
    String numeroFactura = request.getParameter("numeroFactura");
    if (numeroFactura != null && !numeroFactura.isEmpty()) {
        whereClause.append("AND r.numero = '").append(numeroFactura).append("' ");
        parametros.put("NUMERO_FACTURA", numeroFactura);
    }
    
    // Validar y agregar filtro de condición
    String condicion = request.getParameter("condicion");
    if (condicion != null && !condicion.isEmpty()) {
        whereClause.append("AND r.condicion = '").append(condicion).append("' ");
        parametros.put("CONDICION", condicion);
    }
    
    // Validar y agregar filtro de estado
    String estado = request.getParameter("estado");
    if (estado != null && !estado.isEmpty()) {
        whereClause.append("AND r.estado = '").append(estado).append("' ");
        parametros.put("ESTADO", estado);
    }
    
    // Validar y agregar filtro de proveedor
    String proveedor = request.getParameter("proveedor");
    if (proveedor != null && !proveedor.isEmpty()) {
        whereClause.append("AND dt.idpacientes = ").append(proveedor).append(" ");
        parametros.put("ID_PROVEEDOR", proveedor);
    }
    
    // Agregar la cláusula WHERE completa como parámetro
    parametros.put("WHERE_CLAUSE", whereClause.toString());
    
    // Generar el reporte
    File reportFile = new File(application.getRealPath("reportes/listadoventas.jasper"));
    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, conn);
    
    // Enviar el PDF al navegador
    response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream output = response.getOutputStream();
    output.write(bytes, 0, bytes.length);
    output.flush();
    output.close();
    
} catch(Exception ex) {
    ex.printStackTrace();
    response.getWriter().write("Error al generar el reporte: " + ex.getMessage());
}
%>