<!DOCTYPE html>
<%
    HttpSession sesion = request.getSession();
%>

<%
    if (sesion.getAttribute("logueado") == null || !sesion.getAttribute("logueado").equals("1")) {
        // Redirigir al usuario al index.jsp con sesionIniciada=0
%>
<script>
    alert("Debe Iniciar Sesion");
    location.href = 'index.jsp';
</script>
<%
} else {
// Almacenar estado de sesión en sessionStorage
%>
<html dir="ltr" lang="es">
    <style>
        /* CSS para scroll-sidebar */
        /* CSS para scroll-sidebar */
        .scroll-sidebar {
            background-color: #87CEEB !important;
            overflow-y: auto;
            height: 100%;
        }

        .sidebarnav {
            background-color: #87CEEB !important;
            overflow-y: auto;
            height: 100%;
        }

        /* Estilo para textos en negro y en negrita */
        .sidebar-item .sidebar-link .hide-menu,
        .navbar-brand .logo-text,
        .navbar-nav .nav-link {
            color: #000 !important; /* Color negro */
            font-weight: bold; /* Negrita */
        }

        .sidebar-item .sidebar-link:hover .hide-menu {
            color: #000 !important; /* Color negro al hacer hover */
            font-weight: bold; /* Negrita al hacer hover */
        }

        .navbar-header .logo-text {
            color: #000 !important; /* Color negro */
            font-weight: bold; /* Negrita */
        }

    </style>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <meta
            name="keywords"
            content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Matrix lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Matrix admin lite design, Matrix admin lite dashboard bootstrap 5 dashboard template"
            />
        <meta
            name="description"
            content="Matrix Admin Lite Free Version is powerful and clean admin dashboard template, inpired from Bootstrap Framework"
            />
        <meta name="robots" content="noindex,nofollow" />
        <title>SistemaWebVeterinaria</title>
        <!-- Favicon icon -->
        <link
            rel="icon"
            type="image/png"
            sizes="16x16"
            href="assets/images/veterinario.png"
            />
        <!-- Custom CSS -->
        <!-- Custom CSS -->
        <link rel="stylesheet" href="dist/css/iconss.css"/>
        <link href="dist/css/style.min.css" rel="stylesheet" />
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div
            id="main-wrapper"
            data-layout="vertical"
            data-navbarbg="skin5"
            data-sidebartype="full"
            data-sidebar-position="absolute"
            data-header-position="absolute"
            data-boxed-layout="full"
            >
            <!-- ============================================================== -->
            <!-- Topbar header - style you can find in pages.scss -->
            <!-- ============================================================== -->
            <header class="topbar" data-navbarbg="skin5">
                <nav class="navbar top-navbar navbar-expand-md navbar-dark" style="background-color: #ADD8E6;">
                    <div class="navbar-header" data-logobg="skin5">
                        <!-- ============================================================== -->
                        <!-- Logo -->
                        <!-- ============================================================== -->
                        <a class="navbar-brand" href="dashboard.jsp">
                            <!-- Logo icon -->
                            <b class="logo-icon ps-2">
                                <!-- Dark Logo icon -->
                                <img
                                    src="assets/images/veterinario.png"
                                    alt="homepage"
                                    class="light-logo"
                                    width="25"
                                    />
                            </b>
                            <!--End Logo icon -->
                            <!-- Logo text -->
                            <span class="logo-text ms-2" style="color: #000; font-size: 15px">
                                SistemaWebVeterinaria
                            </span>
                        </a>
                        <!-- ============================================================== -->
                        <!-- End Logo -->
                        <!-- ============================================================== -->
                        <!-- ============================================================== -->
                        <!-- Toggle visible on mobile only -->
                        <!-- ============================================================== -->
                        <a
                            class="nav-toggler waves-effect waves-light d-block d-md-none"
                            href="javascript:void(0)"
                            ><i class="ti-menu ti-close"></i
                            ></a>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End Logo -->
                    <!-- ============================================================== -->
                    <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin8">
                        <!-- ============================================================== -->
                        <!-- toggle and nav items -->
                        <!-- ============================================================== -->
                        <ul class="navbar-nav float-start me-auto" style="background-color: #ADD8E6;">
                            <li class="nav-item d-none d-lg-block">
                                <a
                                    class="nav-link sidebartoggler waves-effect waves-light"
                                    href="javascript:void(0)"
                                    data-sidebartype="mini-sidebar"
                                    ><i class="mdi mdi-menu font-24"></i
                                    ></a>
                            </li>
                        </ul>
                        <!-- ============================================================== -->
                        <!-- Right side toggle and nav items -->
                        <!-- ============================================================== -->
                        <ul class="navbar-nav float-end" style="background-color: #ADD8E6;">
                            <li class="nav-item dropdown">
                                <a
                                    class="
                                    nav-link
                                    dropdown-toggle
                                    text-muted
                                    waves-effect waves-dark
                                    pro-pic
                                    "
                                    href="#"
                                    id="navbarDropdown"
                                    role="button"
                                    data-bs-toggle="dropdown"
                                    aria-expanded="false"
                                    style="background-color: #ADD8E6;"
                                    >
                                    <img
                                        src="assets/images/users/../la-configuracion-de-privacidad.png"
                                        alt="user"
                                        class="rounded-circle"
                                        width="31"
                                        /> <% out.print(sesion.getAttribute("user")); %>
                                </a>
                                <ul
                                    class="dropdown-menu dropdown-menu-end user-dd animated"
                                    aria-labelledby="navbarDropdown"
                                    >
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="jsp/logout.jsp"
                                       ><i class="fa fa-power-off me-1 ms-1"></i> Desconectarse</a
                                    >
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>

            </header>
            <!-- ============================================================== -->
            <!-- End Topbar header -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <!-- ============================================================== -->
            <aside class="left-sidebar" data-sidebarbg="skin5">
                <!-- Sidebar scroll-->
                <div class="scroll-sidebar">
                    <!-- Sidebar navigation-->
                    <nav class="sidebar-nav">
                        <ul id="sidebarnav" class="pt-4">

                            <% if (sesion.getAttribute("tipo").equals("ADMINISTRADOR")) { %>
                            <li class="sidebar-item">
                                <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false">
                                    <i class="mdi mdi-receipt"></i>
                                    <span class="hide-menu">Mantenimiento</span>
                                </a>
                                <ul aria-expanded="false" class="collapse first-level">

                                    <!-- Submenú de Ubicación -->
                                    <li class="sidebar-item has-arrow">
                                        <a href="javascript:void(0)" class="sidebar-link">
                                            <i class="mdi mdi-map-marker"></i>
                                            <span class="hide-menu">Ubicación</span>
                                        </a>
                                        <ul aria-expanded="false" class="collapse second-level">
                                            <li class="sidebar-item">
                                                <a href="ciudad.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-city"></i>
                                                    <span class="hide-menu">Ciudad</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>



                                    <!-- Submenú de Personas -->
                                    <li class="sidebar-item has-arrow">
                                        <a href="javascript:void(0)" class="sidebar-link">
                                            <i class="mdi mdi-account-multiple"></i>
                                            <span class="hide-menu">Personas</span>
                                        </a>
                                        <ul aria-expanded="false" class="collapse second-level">
                                            <li class="sidebar-item">
                                                <a href="clientes.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-account"></i>
                                                    <span class="hide-menu">Clientes</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="doctores.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-stethoscope"></i>
                                                    <span class="hide-menu">Doctores</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="personales.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-account"></i>
                                                    <span class="hide-menu">Personales</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="usuarios.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-account"></i>
                                                    <span class="hide-menu">Usuarios</span>
                                                </a>
                                            </li>

                                        </ul>
                                    </li>
                                    <!-- Submenú de Animales -->
                                    <li class="sidebar-item has-arrow">
                                        <a href="javascript:void(0)" class="sidebar-link">
                                            <i class="mdi mdi-paw"></i>
                                            <span class="hide-menu">Animales</span>
                                        </a>
                                        <ul aria-expanded="false" class="collapse second-level">
                                            <li class="sidebar-item">
                                                <a href="especie.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-medical-bag"></i>
                                                    <span class="hide-menu">Especie</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="raza.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-medical-bag"></i>
                                                    <span class="hide-menu">Raza</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="pacientes.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-cat"></i>
                                                    <span class="hide-menu">Pacientes</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <!-- Submenú de Servicios -->
                                    <li class="sidebar-item has-arrow">
                                        <a href="javascript:void(0)" class="sidebar-link">
                                            <i class="mdi mdi-hospital"></i>
                                            <span class="hide-menu">Horarios</span>
                                        </a>
                                        <ul aria-expanded="false" class="collapse second-level">

                                            <li class="sidebar-item">
                                                <a href="horarios.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-calendar-clock"></i>
                                                    <span class="hide-menu">Horarios</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>

                                    <!-- Submenú de Salud -->
                                    <li class="sidebar-item has-arrow">
                                        <a href="javascript:void(0)" class="sidebar-link">
                                            <i class="mdi mdi-medical-bag"></i>
                                            <span class="hide-menu">Salud</span>
                                        </a>
                                        <ul aria-expanded="false" class="collapse second-level">
                                            <li class="sidebar-item">
                                                <a href="sintomas.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-medical-bag"></i>
                                                    <span class="hide-menu">Síntomas</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="medicamentos.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-pill"></i>
                                                    <span class="hide-menu">Medicamentos</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <!-- Submenú de Finanza -->
                                    <li class="sidebar-item has-arrow">
                                        <a href="javascript:void(0)" class="sidebar-link">
                                            <i class="mdi mdi-medical-bag"></i>
                                            <span class="hide-menu">Finanza</span>
                                        </a>
                                        <ul aria-expanded="false" class="collapse second-level">
                                            <li class="sidebar-item">
                                                <a href="bancos.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-medical-bag"></i>
                                                    <span class="hide-menu">Bancos</span>
                                                </a>
                                            </li>
                                            <li class="sidebar-item">
                                                <a href="metodo.jsp" class="sidebar-link">
                                                    <i class="mdi mdi-pill"></i>
                                                    <span class="hide-menu">Metodo de pago</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>


                            <% } %>
                            <% if (sesion.getAttribute("tipo").equals("DOCTOR") || sesion.getAttribute("tipo").equals("ADMINISTRADOR")) { %>

                            <li class="sidebar-item">
                                <a
                                    class="sidebar-link has-arrow waves-effect waves-dark"
                                    href="javascript:void(0)"
                                    aria-expanded="false"
                                    ><i class="mdi mdi-clipboard-account"></i
                                    ><span class="hide-menu">Gestion de Consultas</span></a
                                >

                                <ul aria-expanded="false" class="collapse first-level">
                                    <!-- comment  <li class="sidebar-item">
                                      <a href="agendamientos.jsp" class="sidebar-link"
                                      ><i class="mdi mdi-emoticon"></i
                                      ><span class="hide-menu">Agendamiento </span></a
                                    >
                                  </li>
                                    -->
                                    <li class="sidebar-item">
                                        <a href="listadodecitas.jsp" class="sidebar-link"
                                           ><i class="mdi mdi-border-color"></i
                                            ><span class="hide-menu">Generar citas</span></a
                                        >
                                    </li>
                                    <li class="sidebar-item">
                                        <a href="citasfinalizadas.jsp" class="sidebar-link"
                                           ><i class="mdi mdi-border-color"></i
                                            ><span class="hide-menu">Citas Finalizadas</span></a
                                        >
                                    </li>
                                    <!-- comment  <li class="sidebar-item">
                                 <li class="sidebar-item">
                                      <a href="listadodeconsulta.jsp" class="sidebar-link"
                                      ><i class="mdi mdi-emoticon-cool"></i
                                      ><span class="hide-menu">Consulta</span></a
                                    >
                                  </li>
                                  
                                    -->
                                    <% } %>


                                </ul>

                            <li class="sidebar-item">
                                <a
                                    class="sidebar-link has-arrow waves-effect waves-dark"
                                    href="javascript:void(0)"
                                    aria-expanded="false"
                                    ><i class="mdi mdi-cash"></i>
                                    <span class="hide-menu">Gestión de Cobros</span></a
                                >

                                <ul aria-expanded="false" class="collapse first-level">
                                    <!-- comment 
                                    <li class="sidebar-item">
                                        <a href="aperturas.jsp" class="sidebar-link"
                                           ><i class="mdi mdi-cash-multiple"></i>
                                            <span class="hide-menu">Abrir Caja</span></a
                                        >
                                    </li>
                                    -->
                                    <li class="sidebar-item">
                                        <a href="cobrar.jsp" class="sidebar-link"
                                           ><i class="mdi mdi-cash"></i>
                                            <span class="hide-menu">Cobrar</span></a
                                        >
                                    </li>
                                    <!-- comment 
                                    <li class="sidebar-item">
                                        <a href="cierre.jsp" class="sidebar-link"
                                           ><i class="mdi mdi-cash-multiple"></i>
                                            <span class="hide-menu">Cerrar Caja</span></a
                                        >
                                    </li>
                                   
                                    <li class="sidebar-item">
                                        <a href="informeCaja.jsp" class="sidebar-link"
                                           ><i class="mdi mdi-file-document"></i>
                                            <span class="hide-menu">Informe de Caja</span></a
                                        >
                                    </li>
                                    -->
                                </ul>
                            </li>

                            <li class="sidebar-item" id="sidebar-item-informes">
                                <a
                                    class="sidebar-link has-arrow waves-effect waves-dark"
                                    href="javascript:void(0)"
                                    aria-expanded="false"
                                    id="sidebar-link-informes"
                                    >
                                    <i class="mdi mdi-file-document"></i>
                                    <span class="hide-menu"> Gestion de Informes</span>
                                </a>
                                <ul
                                    aria-expanded="false"
                                    class="collapse first-level"
                                    id="collapse-informes"
                                    >
                                    <li class="sidebar-item" id="sidebar-item-informe-ventas">
                                        <a href="informeVentas.jsp" class="sidebar-link" id="sidebar-link-ventas">
                                            <i class="mdi mdi-chart-bar"></i>
                                            <span class="hide-menu"> Consultas Resumido</span>
                                        </a>
                                    </li>
                                    <li class="sidebar-item" id="sidebar-item-informe-ventas-detallado">
                                        <a href="informeVentasDetallado.jsp" class="sidebar-link" id="sidebar-link-ventas-detallado">
                                            <i class="mdi mdi-chart-line"></i>
                                            <span class="hide-menu">Consultas Det Pacientes</span>
                                        </a>
                                    </li>
                                    <li class="sidebar-item" id="sidebar-item-informe-ventas-detallado">
                                        <a href="informeCobrosDetallado.jsp" class="sidebar-link" id="sidebar-link-ventas-detallado">
                                            <i class="mdi mdi-chart-line"></i>
                                            <span class="hide-menu">Cobros Informes</span>
                                        </a>
                                    </li>
                                      <!-- comment 
                                    <li class="sidebar-item" id="sidebar-item-informe-ventas-detallado">
                                        <a href="informeventasdet.jsp" class="sidebar-link" id="sidebar-link-ventas-detallado">
                                            <i class="mdi mdi-chart-line"></i>
                                            <span class="hide-menu">Consultas Det Doctores</span>
                                        </a>
                                    </li>
                                        -->
                                </ul>
                            </li>

                        </ul>
                    </nav>

                </div>
                <!-- End Sidebar scroll-->
            </aside>

            <!-- ============================================================== -->
            <!-- End Left Sidebar - style you can find in sidebar.scss  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Page wrapper  -->
            <!-- ============================================================== -->
            <div class="page-wrapper">

                <% }%>

