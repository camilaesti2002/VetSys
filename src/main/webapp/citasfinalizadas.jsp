<%@include file="header.jsp" %>
<script src="js/jquery-3.7.1.min.js"></script>
<script src="js/listarcitasf.js"></script>
<div class="modal fade" id="exampleModals" tabindex="-1" aria-labelledby="exampleModalLabels" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabels">IMPRIMIR FACTURA</h1>
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
    
    
    <div class="modal fade" id="exampleModalss" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">ANULAR CONSULTA</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="eliminar" action="#" method="post">
                <input type="hidden" name="eliminar" id="eliminar" value="eliminar">
                <div class="modal-body">
                    <label for="cantidad-modal">Estas seguro de anular?</label>
                    <input type="hidden" name="idpk" id="idpk">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                    <button type="button" class="btn btn-primary" name="eliminar-registro-venta" id="eliminar-registro-venta">Sí</button>
                </div>
            </form>
        </div>
    </div>
</div>
    
    <div class="row">
         <div class="row justify-content-center">
        <div class="col-md-10 ">
            <br></br>
            <div class="listado-columna">
                <div class="listado" style="background-color: #B3C6E7; padding: 20px;">
                   <h1 style="font-size: 22px; text-align: center; font-family: 'Arial Black', Arial, sans-serif;">Listado de Citas Finalizadas</h1>

                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" id="resultado" style="font-size: larger;">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Cliente</th>
                                    <th>C.I</th>
                                    <th>Total</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody id="resultadosventas">
                                <!-- Aquí van los datos de la tabla -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>    
<script>
      // Función para establecer datos de impresión
    function setPrintData(id, total) {
        document.getElementById('pkimps').value = id;
        document.getElementById('total').value = total;
        convertirTotalEnLetras(); // Convertir a letras cuando se establece el total
    }

    // Función para convertir números a letras
    function numeroALetras(numero) {
    if (numero === 0) return "cero";

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
<%@include file="footer.jsp" %>