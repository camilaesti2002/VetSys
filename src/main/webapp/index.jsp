<!DOCTYPE html>
<%@include file="a.jsp" %>
<html dir="ltr">
    <%@page import="java.math.BigInteger"%> <!-- SIRVE PARA LUEGO GENERAR LA FUNCION MD5  -->
    <%@page import="java.security.MessageDigest"%> <!-- SIRVE PARA LA SEGURIDAD DEL LOGIN -->
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="keywords" content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Matrix lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Matrix admin lite design, Matrix admin lite dashboard bootstrap 5 dashboard template" />
  <meta name="description" content="Matrix Admin Lite Free Version is powerful and clean admin dashboard template, inpired from Bootstrap Framework" />
  <meta name="robots" content="noindex,nofollow" />
  <title>Matrix Admin Lite Free Versions Template by WrapPixel</title>
  <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png" />
      <script src="js/jquery-3.7.1.min.js"></script>
  <script src="js/login.js"></script>
  <style>
    body {
        background-color: #dee2e6;
      margin: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .auth-wrapper {
      width: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #dee2e6;
      height: 100vh;
    }
    .auth-box {
      width: 100%;
      max-width: 400px;
      background-color: #B3C6E7 ;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
    .auth-box form {
      margin: 0;
    }
    /* Estilo para las alertas con fondo rojo */
.alert-rojo {
    background-color: #f8d7da; /* Color de fondo rojo claro */
    color: #721c24; /* Color del texto en rojo oscuro */
    border-color: #f5c6cb; /* Color del borde */
}

/* Opcional: Puedes añadir más estilos como borde, padding, etc. */
.alert {
    padding: 15px;
    border-radius: 4px;
    margin-bottom: 20px;
}

  </style>
</head>

<body>
  <div class="main-wrapper">
    <div class="preloader">
      <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
      </div>
    </div>

    <div class="auth-wrapper d-flex justify-content-center align-items-center position-fixed top-50 start-50 translate-middle my-5 rounded-3">
      <div class="auth-box border-top border-secondary">
        <div id="loginform">
          <div class="text-center pt-3 pb-3">
              <h3 style="color: black">SistemaWebVeterinaria</h3>
          </div>
          <form method="post" class="form-horizontal mt-3" id="form" name="form">
            <div class="row pb-4">
              <div class="col-12">
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
<span class="input-group-text" 
      style="background-color: #4A90E2; color: white; height: 100%;" 
      id="basic-addon1">
    <i class="mdi mdi-account fs-4"></i>
</span>
                  </div>
                  <input type="text" name="user" id="user" class="form-control form-control-lg" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" required="" />
                </div>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                   <span class="input-group-text" 
      style="background-color: #9E9E9E; color: white; height: 100%;" 
      id="basic-addon2">
    <i class="mdi mdi-lock fs-4"></i>
</span>

                  </div>
                  <input type="password" name="pswrd" id="pswrd" class="form-control form-control-lg" placeholder="Password" aria-label="Password" aria-describedby="basic-addon2" required="" />
                </div>
              </div>
            </div>
            <div class="row border-top border-secondary">
              <div class="col-12">
                <div class="form-group">
                  <div class="pt-3">
<button class="btn btn-success float-end text-white" 
        type="button" 
        id="ValidarInicio" 
        name="ValidarInicio" 
        style="background-color: #8A9AB8; border-color: #8A9AB8;">
    Iniciar Sesión
</button>
                                                                    <input type="hidden" id="btnLogin"  name="btnLogin">
                    <div id="mensaje"></div>
                    <br></br>
<div id="mensajeAlerta" style="display: none; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 15px; border-radius: 4px; margin-bottom: 20px;"></div>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>



</body>
</html>

<%@include file="footer.jsp" %>
