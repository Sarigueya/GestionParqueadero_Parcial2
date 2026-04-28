<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <title>Sin permiso — ParkControl</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/static/css/sin-acceso.css" rel="stylesheet"/>
</head>
<body>
    <div class="caja">
        <div class="num">403</div>
        <div class="icono"><i class="bi bi-shield-lock-fill"></i></div>
        <h2>Sin permiso de acceso</h2>
        <p>Tu cuenta no tiene autorización para ver esta sección. Contacta al administrador si crees que es un error.</p>
        <a href="/login" class="btn-volver">
            <i class="bi bi-arrow-left"></i> Volver al inicio
        </a>
    </div>
</body>
</html>
