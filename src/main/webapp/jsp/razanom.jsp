<%@include file="conexion.jsp" %>
out.printl("<option value="0">Seleccione una raza</option>");
<% 
    String specieId = request.getParameter("specieId");
    if (specieId != null && !specieId.equals("0")) {
    try {
    Statement st = null;
    ResultSet rs = null;
    st = conn.createStatement();
    rs = st.executeQuery("SELECT idraza, nombre FROM raza WHERE idespecies = " + specieId + ";");
    while (rs.next()) {  
%>

out.printl("<option value="<% out.print(rs.getString(1)); %>"><% out.print(rs.getString(1)); %>-<% out.print(rs.getString(2)); %></option>")
<% 
}
  } catch (Exception e) {
    out.println("error PSQL" + e);
  }
}

%>

