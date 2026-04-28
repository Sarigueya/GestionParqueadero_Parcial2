<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <title>ParkControl — Consulta</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/static/css/cliente.css" rel="stylesheet"/>
</head>
<body>

<header class="header">
    <div class="hdr-marca">
        <div class="hdr-marca-ico"><i class="bi bi-p-square-fill"></i></div>
        <span class="hdr-marca-txt">ParkControl</span>
    </div>
    <span class="badge-rol"><i class="bi bi-eye"></i> CLIENTE</span>
    <a href="/logout" class="btn-salir"><i class="bi bi-power"></i> Salir</a>
</header>

<div class="wrap">

    <div class="page-head">
        <div>
            <h1 class="page-titulo">Vehículos en el parqueadero</h1>
            <p class="page-sub">Vista de consulta — solo lectura</p>
        </div>
        <span class="total-pill">${fn:length(vehiculos)} registros</span>
    </div>

    <div class="aviso-readonly">
        <i class="bi bi-info-circle-fill"></i>
        Estás en modo consulta. Solo puedes visualizar la información del parqueadero.
    </div>

    <div class="busqueda">
        <i class="bi bi-search"></i>
        <span>Información de vehículos registrados...</span>
    </div>

    <div class="tabla-wrap">
        <c:choose>
            <c:when test="${empty vehiculos}">
                <div class="vacio">
                    <i class="bi bi-inbox"></i>
                    <p>No hay vehículos registrados en este momento</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Placa</th>
                            <th>Hora entrada</th>
                            <th>Estado / Salida</th>
                            <th>Ubicación</th>
                            <th>Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${vehiculos}">
                        <tr>
                            <td style="color:#cbd5e1;font-size:12px">${v.id}</td>
                            <td><span class="placa">${v.placa}</span></td>
                            <td>
                                <span class="hora">
                                    <i class="bi bi-clock" style="color:#22c55e"></i> ${v.horaEntrada}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.horaSalida != null}">
                                        <span class="badge-salida">${v.horaSalida}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-activo">En parqueadero</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><span class="espacio">${v.ubicacion}</span></td>
                            <td><span class="tag-cat">${v.tipoVehiculo.nombre}</span></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

</div>

</body>
</html>
