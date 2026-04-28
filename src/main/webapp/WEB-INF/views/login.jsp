<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>ParkControl — Ingresar</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/static/css/login.css" rel="stylesheet"/>
</head>
<body>

<div class="izq">
    <div class="marca">
        <div class="marca-icono"><i class="bi bi-p-square-fill"></i></div>
        <span class="marca-nombre">ParkControl</span>
    </div>
    <h1 class="titulo">Controla cada<br/><em>espacio</em>,<br/>cada vehículo.</h1>
    <p class="subtitulo">Plataforma de gestión vehicular para el estacionamiento de la Universidad Surcolombiana.</p>
    <div class="chips">
        <div class="chip"><span class="chip-dot"></span>Registro de ingresos y salidas</div>
        <div class="chip"><span class="chip-dot"></span>Control de espacios por acomodador</div>
        <div class="chip"><span class="chip-dot"></span>Acceso por roles diferenciados</div>
    </div>
</div>

<div class="der">
    <div class="caja">
        <p class="caja-titulo">Iniciar sesión</p>
        <p class="caja-sub">Ingresa tus credenciales para continuar</p>

        <% if (request.getParameter("error") != null) { %>
        <div class="error-caja">
            <i class="bi bi-exclamation-circle-fill"></i>
            Usuario o contraseña incorrectos
        </div>
        <% } %>

        <form method="post" action="/login">
            <div class="campo">
                <label>Usuario</label>
                <div class="wrap-input">
                    <i class="bi bi-person"></i>
                    <input type="text" name="username" placeholder="nombre de usuario" required autofocus/>
                </div>
            </div>
            <div class="campo">
                <label>Contraseña</label>
                <div class="wrap-input">
                    <i class="bi bi-lock"></i>
                    <input type="password" name="password" placeholder="••••••••" required/>
                </div>
            </div>
            <button type="submit" class="btn-enter">
                <i class="bi bi-box-arrow-in-right"></i> Entrar
            </button>
        </form>

        <div class="pie">USCO &bull; Neiva, Huila &bull; Colombia</div>
    </div>
</div>

</body>
</html>
