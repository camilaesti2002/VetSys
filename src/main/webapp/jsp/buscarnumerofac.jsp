<%@include file="conexion.jsp" %>
<%
    try {
        // Preparar la consulta SQL para obtener el último número
        // Using 'AS numero' to explicitly name the column
        String query = "SELECT COALESCE((SELECT numero FROM consulta WHERE numero ~ '^[0-9]+$' ORDER BY CAST(numero AS INTEGER) DESC LIMIT 1), '1') AS numero;";
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        String nuevoVenNumero;
        
        if (rs.next()) {
            String venNumero = rs.getString("numero");  // Now this will work because we aliased the column as 'numero'
            // Agregar logging para debug
            System.out.println("Número recuperado de BD: " + venNumero);
            
            if (venNumero != null && !venNumero.trim().isEmpty()) {
                // Obtener solo los dígitos del número y asegurarse de que no haya espacios
                String numeroStr = venNumero.trim().replaceAll("[^0-9]", "");
                System.out.println("Número después de limpiar: " + numeroStr);
                
                try {
                    // Convertir directamente a entero y sumar 1
                    int numero = Integer.parseInt(numeroStr);
                    System.out.println("Número convertido a entero: " + numero);
                    numero++; // Incrementar
                    System.out.println("Número después de incrementar: " + numero);
                    
                    // Formatear el nuevo número con ceros a la izquierda
                    nuevoVenNumero = String.format("%07d", numero);
                    System.out.println("Nuevo número formateado: " + nuevoVenNumero);
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
        
        // Imprimir el nuevo número
        out.print(nuevoVenNumero);
        
    } catch (SQLException e) {
        out.println("Error SQL: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        out.println("Error general: " + e.getMessage());
        e.printStackTrace();
    }
%>