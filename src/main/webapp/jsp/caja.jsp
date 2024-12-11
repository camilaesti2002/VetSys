<%@include file="conexion.jsp" %>
<%
    String listar = request.getParameter("listar");
    
    
    if ("cargar".equals(listar)) {
        String montoStr = request.getParameter("monto");
        String fecharegistro = request.getParameter("fecharegistro");
        String usuarioStr = request.getParameter("idusuarios");


        
        if (montoStr != null && !montoStr.isEmpty() &&
            fecharegistro != null && !fecharegistro.isEmpty() &&
            usuarioStr != null && !usuarioStr.isEmpty()) {

            try {
                // Convertir monto y usuario a enteros
                int monto = Integer.parseInt(montoStr);
                int usuario = Integer.parseInt(usuarioStr);

                // Validar si ya existe una apertura con estado 'ABIERTA'
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM aperturas WHERE ape_estado = 'ABIERTA'");
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // La apertura ya existe, mostrar mensaje de error
                    out.println("<i class='alert alert-danger'>La caja ya está abierta.</i>");
                } else {
                    // La apertura no existe, insertar en la base de datos
                    PreparedStatement st = conn.prepareStatement(
                        "INSERT INTO aperturas(ape_fecha, ape_monto, idusuarios) " +
                        "VALUES (TO_DATE(?, 'DD-MM-YYYY'), ?, ?)"
                    );
                    st.setString(1, fecharegistro); // Asegúrate de que fecharegistro esté en formato 'dd-MM-yyyy'
                    st.setInt(2, monto);            // Pasar el monto como entero
                    st.setInt(3, usuario);          // Pasar el usuario como entero
                    st.executeUpdate();
                    out.println("<i class='alert alert-success'>CAJA ABIERTA</i>");
                }
            } catch (NumberFormatException e) {
                out.println("Error al convertir monto o usuario a número: " + e.getMessage());
            } catch (SQLException e) {
                out.println("Error SQL al insertar datos: " + e.getMessage());
            } catch (Exception e) {
                out.println("Error general al insertar datos: " + e.getMessage());
            }
        } else {
            out.println("<i class='alert alert-danger'>Faltan parámetros requeridos o están vacíos.</i>");
        }
    } else if ("cerrar".equals(listar)) {
        String montoStr = request.getParameter("monto");
        String fecharegistro = request.getParameter("fecharegistro");
        String usuarioStr = request.getParameter("idusuarios");
        String aperturaStr = request.getParameter("idaperturas");

        // Validar si idaperturas está vacío o es null
        if (aperturaStr == null || aperturaStr.isEmpty()) {
            out.println("<i class='alert alert-danger'>DEBE ABRIR CAJA PARA CERRAR</i>");
        } else if (montoStr != null && !montoStr.isEmpty() &&
                   fecharegistro != null && !fecharegistro.isEmpty() &&
                   usuarioStr != null && !usuarioStr.isEmpty()) {

            try {
                // Convertir monto, usuario y apertura a enteros
                int monto = Integer.parseInt(montoStr);
                int usuario = Integer.parseInt(usuarioStr);
                int apertura = Integer.parseInt(aperturaStr);

                // Validar si ya existe una apertura con estado 'ABIERTA'
                PreparedStatement ps = conn.prepareStatement("SELECT ape_monto FROM aperturas WHERE ape_estado = 'ABIERTA'");
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    int aperturaMonto = rs.getInt("ape_monto");

                    // Verificar si el monto de cierre es menor que el monto de apertura
                    if (monto < aperturaMonto) {
                        out.println("<i class='alert alert-danger'>El monto de cierre no puede ser menor que el monto de apertura.</i>");
                    } else {
                        // La apertura existe, insertar en la base de datos
                        PreparedStatement st = conn.prepareStatement(
                            "INSERT INTO cierre(cie_fecha, cie_monto, idaperturas) " +
                            "VALUES (TO_DATE(?, 'DD-MM-YYYY'), ?, ?)"
                        );
                        st.setString(1, fecharegistro); // Asegúrate de que fecharegistro esté en formato 'dd-MM-yyyy'
                        st.setInt(2, monto);            // Pasar el monto como entero
                        st.setInt(3, apertura);         // Pasar la apertura como entero
                        st.executeUpdate();

                        // Actualizar el estado de la apertura
                        PreparedStatement stUpdate = conn.prepareStatement(
                            "UPDATE aperturas SET ape_estado = 'CERRADA' WHERE idaperturas = ?"
                        );
                        stUpdate.setInt(1, apertura);
                        stUpdate.executeUpdate();

                        out.println("<i class='alert alert-success'>CAJA CERRADA</i>");
                    }
                } else {
                    // La apertura no existe
                    out.println("<i class='alert alert-danger'>No hay ninguna caja abierta.</i>");
                }
            } catch (NumberFormatException e) {
                out.println("<i class='alert alert-danger'>Error al procesar los datos. Asegúrese de que todos los campos sean correctos.</i>");
            } catch (SQLException e) {
                out.println("<i class='alert alert-danger'>Error al realizar la operación. Intente nuevamente.</i>");
            } catch (Exception e) {
                out.println("<i class='alert alert-danger'>Se produjo un error inesperado. Intente nuevamente.</i>");
            }
        } else {
            out.println("<i class='alert alert-danger'>Faltan parámetros requeridos o están vacíos.</i>");
        }
    }
%>
