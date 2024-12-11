<%@include file="conexion.jsp" %>
out.printl("<option value="" id="depar">Seleccione un metodo de pago</option>");
<% 
    try{
      Statement st= null;
      ResultSet rs= null;
      st = conn.createStatement();
      rs = st.executeQuery("SELECT * FROM metododepago ORDER BY idmetodo ASC;");
      while (rs.next()){     
%>

out.printl("<option value="<% out.print(rs.getString(1)); %>"><% out.print(rs.getString(2)); %></option>")
<% 
    }
    } catch(Exception e){
out.println("error PSQL" + e);
}

%>
