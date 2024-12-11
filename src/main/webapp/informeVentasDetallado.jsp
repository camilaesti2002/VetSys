<%@include file="header.jsp"%>
<% 
    if (sesion != null && sesion.getAttribute("tipo") != null && sesion.getAttribute("tipo").equals("ADMINISTRADOR")) { 
%>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/informeventadetallado.js"></script>

<!-- Incluir JS de Select2 -->
<main id="main" class="main">


    <div class="modal fade" id="exampleModals" tabindex="-1" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabels">IMPRIMIR DATOS VENTA</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="eliminar" action="#" method="post">
                        <input type="hidden" name="imprimir" id="imprimir" value="imprimir">
                        <div class="modal-body">
                            <p>¿Estás seguro de que deseas imprimir la venta seleccionada?</p>
                            <input type="hidden" name="pkimps" id="pkimps">
                            <input type="hidden" name="total" id="total">
                            <input type="hidden" name="totalEnLetras" id="totalEnLetras" readonly>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" name="imprimirtodo" id="imprimirtodo" data-bs-dismiss="modal">Sí</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <section class="section" style="background-color: #ffffff; padding: 20px; border-radius: 10px;">
        <div class="row justify-content-center"> <!-- Centra el formulario -->
            <div class="col-lg-8">
                <div class="card" style="background: #B3C6E7;">
                    <div class="card-body">
                        <h2 class="card-title text-center">DATOS DEL INFORME PACIENTES</h2> <!-- Título centrado -->
                        <form id="form">
                            <input type="hidden" name="listar" id="listar" value="cargar">
                            <input type="hidden" name="pk" id="pk">

                            <div class="row"> <!-- Fila con dos columnas -->
                                <div class="col-md-6"> <!-- Columna izquierda -->
                                    <div class="form-group">
                                        <label for="nombre">Fecha Desde:</label>
                                        <input type="date" class="form-control" name="inicio" id="inicio" onkeypress="return validarTexto(event)" placeholder="Ingrese el nombre" onpaste="bloquearPegado(event)">
                                    </div>
                                </div>
                                <div class="col-md-6"> <!-- Columna derecha -->
                                    <div class="form-group">
                                        <label for="departamento">Fecha Hasta:</label>
                                        <input type="date" class="form-control" name="fin" id="fin" onkeypress="return validarTexto(event)" placeholder="Ingrese el nombre" onpaste="bloquearPegado(event)">
                                    </div>
                                </div>
                            </div>

                            <!-- Centrado del select de Clientes -->
                        <div class="row justify-content-center"> <!-- Fila centrada -->
                            <div class="col-md-6"> <!-- Ajustar el ancho del select -->
                                <div class="form-group text-center"> <!-- Centrar el contenido -->
                                    <label for="proveedores">Pacientes</label>
                                    <select class="form-control" name="proveedores" id="proveedores"></select>
                                </div>
                            </div>
                        </div>

                            <!-- Fila con el botón centrado -->
                            <div class="row">
                                <div class="col-12 text-center"> <!-- Centra el contenido de la columna -->
                                    <input name="botondep" id="botondep" type="button" value="PROCESAR" class="btn btn-primary">
                                    <br><br>
                                    <div id="mensaje"></div>
                                    <div style="padding: 5px;"></div>
                                    <div id="mensajeAlerta" class="alert" style="display: none;"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    






    <script>


        function validarNumeroFactura(event) {
            var e = event || window.event;
            var tecla = e.keyCode || e.which;
            var teclado = String.fromCharCode(tecla);

            // Permitir solo números
            if (!/^\d$/.test(teclado)) {
                return false;
            }

            // Limitar el número de caracteres a 7
            var input = e.target || e.srcElement;
            if (input.value.length >= 7) {
                return false;
            }

            return true;
        }
        function validarTotal(event) {
    var e = event || window.event;
    var tecla = e.keyCode || e.which;
    var teclado = String.fromCharCode(tecla);

    // Permitir solo números
    if (!/^\d$/.test(teclado)) {
        return false;
    }

    // Obtener el elemento de entrada
    var input = e.target || e.srcElement;

    // No permitir iniciar con 0
    if (input.value.length === 0 && teclado === '0') {
        return false;
    }

    // Limitar el número de caracteres a 15
    if (input.value.length >= 15) {
        return false;
    }

    return true;
}

        function validarBuscador(event) {
            var e = event || window.event;
            var tecla = e.keyCode || e.which;
            var teclado = String.fromCharCode(tecla);
            var input = e.target;
            var texto = (input.value + teclado).trim(); // Trim para eliminar espacios al inicio y final

            // Expresión regular para permitir letras, números y la letra "ñ"
            var regex = /^[a-zA-Z0-9ñÑ]+$/;

            if (texto.length > 10 || !regex.test(teclado)) {
                e.preventDefault();
                return false;
            }
            return true;
        }
    </script>

</main><!-- End #main -->

<%@include file="footer.jsp" %>
<% } else {
    response.sendRedirect("dashboard.jsp");
}
%>

<script>
    $(document).ready(function () {
        $('#proveedores').select2({
            placeholder: "Seleccione un cliente",
            allowClear: true
        });
    });
    
</script>
<script type="text/javascript">
    function validarTextos(event) {
        var tecla = event.keyCode || event.which;
        var teclado = String.fromCharCode(tecla);
        var input = event.target;

        // Permitir solo letras y espacios
        if (!/^[a-zA-Z\s]*$/.test(teclado) && tecla !== 8) { // 8 es el código de retroceso (backspace)
            event.preventDefault();
            return false;
        }

        // Permitir un máximo de 30 caracteres
        var texto = input.value + teclado;
        if (texto.length > 30) {
            event.preventDefault();
            return false;
        }

        return true;
    }
    // Función para establecer datos de impresión
    function setPrintData(id, total) {
        document.getElementById('pkimps').value = id;
        document.getElementById('total').value = total;
        convertirTotalEnLetras(); // Convertir a letras cuando se establece el total
    }

    // Función para convertir números a letras
    function numeroALetras(numero) {
        if (numero === 0)
            return "cero";

        const unidades = ["", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"];
        const decenas = ["", "diez", "veinti", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"];
        const centenas = ["", "ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos"];

        let resultado = "";

        // Manejo de millones
        if (numero >= 1000000) {
            let millones = Math.floor(numero / 1000000);
            if (millones === 1) {
                resultado += "un millón ";
            } else {
                resultado += numeroALetras(millones) + " millones ";
            }
            numero %= 1000000;
        }

        // Manejo de miles
        if (numero >= 1000) {
            let miles = Math.floor(numero / 1000);
            if (miles === 1) {
                resultado += "mil ";
            } else {
                resultado += numeroALetras(miles) + " mil ";
            }
            numero %= 1000;
        }

        // Manejo de centenas
        if (numero >= 100) {
            if (numero === 100) {
                resultado += "cien ";
            } else {
                resultado += centenas[Math.floor(numero / 100)] + " ";
            }
            numero %= 100;
        }

        // Manejo de decenas
        if (numero >= 20) {
            resultado += decenas[Math.floor(numero / 10)];
            numero %= 10;
            if (numero > 0) {
                resultado += " y ";
            }
        } else if (numero >= 10) {
            switch (numero) {
                case 10:
                    resultado += "diez";
                    break;
                case 11:
                    resultado += "once";
                    break;
                case 12:
                    resultado += "doce";
                    break;
                case 13:
                    resultado += "trece";
                    break;
                case 14:
                    resultado += "catorce";
                    break;
                case 15:
                    resultado += "quince";
                    break;
                case 16:
                    resultado += "dieciséis";
                    break;
                case 17:
                    resultado += "diecisiete";
                    break;
                case 18:
                    resultado += "dieciocho";
                    break;
                case 19:
                    resultado += "diecinueve";
                    break;
            }
            return resultado.trim();
        }

        // Manejo de unidades
        if (numero > 0) {
            resultado += unidades[numero];
        }

        // Corregir "veinti" seguido de unidad
        if (resultado.startsWith("veinti y")) {
            resultado = resultado.replace("veinti y", "veinti");
        }

        // Corregir espacios y formatear el resultado
        resultado = resultado.trim().replace(/ +/g, ' ');

        // Corregir caso específico para 'veinti' + unidad
        resultado = resultado.replace(/^veinti\s+y\s/, 'veinti');
        resultado = resultado.replace(/^veinti\s/, 'veinti');

        return resultado;
    }

// Función para convertir el valor del campo 'total' a letras
    function convertirTotalEnLetras() {
        const totalInput = document.getElementById('total').value;
        console.log("Valor del campo total:", totalInput); // Línea de depuración
        const total = parseInt(totalInput.replace(/,/g, ''), 10); // Convertir a número entero y eliminar comas
        if (!isNaN(total)) {
            const totalEnLetras = numeroALetras(total);
            document.getElementById('totalEnLetras').value = totalEnLetras + " .-";
        } else {
            document.getElementById('totalEnLetras').value = ""; // Limpiar si el valor no es un número válido
        }
    }

// Añadir un evento para que se convierta a letras cuando el valor del campo 'total' cambie
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('total').addEventListener('input', function () {
            console.log("Evento input disparado"); // Línea de depuración
            convertirTotalEnLetras();
        });
    });


</script>