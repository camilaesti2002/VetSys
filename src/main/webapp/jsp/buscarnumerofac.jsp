<%@include file="conexion.jsp" %>
<%
    try {
        // Preparar la consulta SQL para obtener el �ltimo n�mero
        // Using 'AS numero' to explicitly name the column
        String query = "SELECT COALESCE((SELECT numero FROM consulta WHERE numero ~ '^[0-9]+$' ORDER BY CAST(numero AS INTEGER) DESC LIMIT 1), '1') AS numero;";
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        String nuevoVenNumero;
        
        if (rs.next()) {
            String venNumero = rs.getString("numero");  // Now this will work because we aliased the column as 'numero'
            // Agregar logging para debug
            System.out.println("N�mero recuperado de BD: " + venNumero);
            
            if (venNumero != null && !venNumero.trim().isEmpty()) {
                // Obtener solo los d�gitos del n�mero y asegurarse de que no haya espacios
                String numeroStr = venNumero.trim().replaceAll("[^0-9]", "");
                System.out.println("N�mero despu�s de limpiar: " + numeroStr);
                
                try {
                    // Convertir directamente a entero y sumar 1
                    int numero = Integer.parseInt(numeroStr);
                    System.out.println("N�mero convertido a entero: " + numero);
                    numero++; // Incrementar
                    System.out.println("N�mero despu�s de incrementar: " + numero);
                    
                    // Formatear el nuevo n�mero con ceros a la izquierda
                    nuevoVenNumero = String.format("%07d", numero);
                    System.out.println("Nuevo n�mero formateado: " + nuevoVenNumero);
                } catch (NumberFormatException e) {
                    System.out.println("Error al convertir: " + e.getMessage());
                    nuevoVenNumero = "0000001";
                }
            } else {
                nuevoVenNumero = "0000001";
            }
        } else {
            nuevoVenNumero = "0000001";
        }
        
        // Imprimir el nuevo n�mero
        out.print(nuevoVenNumero);
        
    } catch (SQLException e) {
        out.println("Error SQL: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        out.println("Error general: " + e.getMessage());
        e.printStackTrace();
    }
%>