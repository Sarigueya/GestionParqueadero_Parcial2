<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <title>ParkControl — Acomodador</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/static/css/acomodador.css" rel="stylesheet"/>
</head>
<body>

<header class="header">
    <div class="hdr-marca">
        <div class="hdr-marca-ico"><i class="bi bi-p-square-fill"></i></div>
        <span class="hdr-marca-txt">ParkControl</span>
    </div>
    <div class="hdr-sep"></div>
    <span class="hdr-titulo">Panel de Acomodador</span>
    <span class="badge-rol"><i class="bi bi-person-workspace"></i> ACOMODADOR</span>
    <a href="/logout" class="btn-hdr-salir"><i class="bi bi-power"></i> Salir</a>
</header>

<div class="contenido">
    <div class="page-head">
        <h1 class="page-titulo">Control de espacios</h1>
        <p class="page-sub">Selecciona un vehículo para actualizar su ubicación en el parqueadero</p>
    </div>

    <div class="grid">
        <c:forEach var="v" items="${vehiculos}">
        <div class="v-card">
            <div class="v-card-top">
                <div class="v-placa">${v.placa}</div>
                <span class="v-cat">${v.tipoVehiculo.nombre}</span>
            </div>
            <div class="v-card-body">
                <div class="v-fila">
                    <i class="bi bi-clock-history" style="color:#22c55e"></i>
                    Ingresó a las <strong>${v.horaEntrada}</strong>
                </div>
                <div class="v-fila">
                    <i class="bi bi-geo-alt"></i>
                    Espacio actual: <strong>${v.ubicacion}</strong>
                </div>
                <div class="v-fila">
                    <i class="bi bi-circle-fill"
                       style="font-size:8px;color:${v.horaSalida == null ? '#22c55e' : '#f87171'}"></i>
                    <c:choose>
                        <c:when test="${v.horaSalida == null}">En el parqueadero</c:when>
                        <c:otherwise>Salió a las ${v.horaSalida}</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="v-card-footer">
                <a href="/acomodador/vehiculos/editar/${v.id}" class="btn-espacio">
                    <i class="bi bi-arrow-repeat"></i> Actualizar ubicación
                </a>
            </div>
        </div>
        </c:forEach>

        <c:if test="${empty vehiculos}">
            <div class="vacio">
                <i class="bi bi-inbox"></i>
                <p>No hay vehículos registrados aún.</p>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>
