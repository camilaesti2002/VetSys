<%@include file="conexion.jsp"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%
Statement st = null;
ResultSet rs = null;


if (request.getParameter("btnLogin") != null) {

    /*Tomamos los parametros del HTML*/
    String user = request.getParameter("user");
    String password = request.getParameter("pswrd");

    /*Instanciamos para crear nuestras sesiones*/
    HttpSession sesion = request.getSession();

    try {
        st = conn.createStatement();
        rs = st.executeQuery("SELECT * FROM usuarios  WHERE nombre='" + user + "' AND clave='" + password + "';");
        
        boolean found = false;
        if (rs.next()) {
            // Si encontró un usuario válido, establece las sesiones
            sesion.setAttribute("logueado", "1");
            sesion.setAttribute("user", rs.getString("nombre"));
            sesion.setAttribute("id", rs.getString("idusuarios"));
            sesion.setAttribute("tipo", rs.getString("rol"));
            out.println("DATOS CORRECTOS");
        } else {
            out.println("DATOS INCORRECTOS");
        }
        
    } catch (Exception e) {
        out.print(e.getMessage());
    }
}
%>