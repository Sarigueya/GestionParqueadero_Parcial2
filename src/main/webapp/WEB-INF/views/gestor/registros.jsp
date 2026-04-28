<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <title>ParkControl — Administrador</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/static/css/admin.css" rel="stylesheet"/>
</head>
<body>

<!-- Sidebar -->
<nav class="sidebar">
    <div class="sb-marca">
        <div class="sb-marca-ico"><i class="bi bi-p-square-fill"></i></div>
        <span class="sb-marca-txt">ParkControl</span>
    </div>
    <div class="sb-seccion">Panel</div>
    <a href="/admin/vehiculos" class="sb-item activo">
        <i class="bi bi-table"></i> Registros
    </a>
    <a href="/admin/vehiculos/nuevo" class="sb-item">
        <i class="bi bi-plus-square"></i> Nuevo registro
    </a>
    <div class="sb-abajo">
        <div class="sb-usuario">
            <strong><i class="bi bi-person-circle"></i> Administrador</strong>
            Acceso total al sistema
        </div>
        <a href="/logout" class="btn-salir"><i class="bi bi-power"></i> Cerrar sesión</a>
    </div>
</nav>

<!-- Contenido principal -->
<div class="contenido">
    <div class="topbar">
        <div>
            <div class="topbar-titulo">Vehículos registrados</div>
            <div class="topbar-bread">Inicio &rsaquo; Registros</div>
        </div>
        <span class="badge-rol"><i class="bi bi-shield-check"></i> ADMIN</span>
    </div>

    <div class="main">

        <!-- Tarjetas resumen -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-label">Total registros</div>
                <div class="stat-val">${fn:length(vehiculos)}</div>
                <div class="stat-sub">en el sistema</div>
            </div>
            <div class="stat-card verde">
                <div class="stat-label">Activos</div>
                <div class="stat-val">
                    <c:set var="activos" value="0"/>
                    <c:forEach var="v" items="${vehiculos}">
                        <c:if test="${v.horaSalida == null}"><c:set var="activos" value="${activos + 1}"/></c:if>
                    </c:forEach>
                    ${activos}
                </div>
                <div class="stat-sub">sin hora de salida</div>
            </div>
            <div class="stat-card rojo">
                <div class="stat-label">Completados</div>
                <div class="stat-val">
                    <c:set var="completados" value="0"/>
                    <c:forEach var="v" items="${vehiculos}">
                        <c:if test="${v.horaSalida != null}"><c:set var="completados" value="${completados + 1}"/></c:if>
                    </c:forEach>
                    ${completados}
                </div>
                <div class="stat-sub">ya salieron</div>
            </div>
        </div>

        <!-- Tabla de vehículos -->
        <div class="tabla-wrap">
            <div class="tabla-head">
                <div>
                    <div class="tabla-head-txt">Todos los vehículos</div>
                    <div class="tabla-head-sub">Gestión completa de entradas y salidas</div>
                </div>
                <a href="/admin/vehiculos/nuevo" class="btn-nuevo">
                    <i class="bi bi-plus"></i> Nuevo
                </a>
            </div>

            <c:choose>
                <c:when test="${empty vehiculos}">
                    <div class="vacio">
                        <i class="bi bi-inbox"></i>
                        <p>No hay vehículos registrados aún.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Placa</th>
                                <th>Hora entrada</th>
                                <th>Hora salida</th>
                                <th>Ubicación</th>
                                <th>Tipo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="v" items="${vehiculos}">
                            <tr>
                                <td style="color:#374151;font-size:12px">${v.id}</td>
                                <td><span class="placa-badge">${v.placa}</span></td>
                                <td>
                                    <span class="hora">
                                        <i class="bi bi-clock" style="color:#4ade80"></i> ${v.horaEntrada}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${v.horaSalida != null}">
                                            <span class="hora">
                                                <i class="bi bi-clock" style="color:#f87171"></i> ${v.horaSalida}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-activo">Activo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="color:#9ca3af">${v.ubicacion}</td>
                                <td><span class="tag-cat">${v.tipoVehiculo.nombre}</span></td>
                                <td>
                                    <div class="acciones">
                                        <a href="/admin/vehiculos/editar/${v.id}" class="btn-accion btn-editar">
                                            <i class="bi bi-pencil"></i> Editar
                                        </a>
                                        <a href="/admin/vehiculos/eliminar/${v.id}"
                                           class="btn-accion btn-borrar"
                                           onclick="return confirm('¿Eliminar este vehículo?')">
                                            <i class="bi bi-trash"></i> Borrar
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

</body>
</html>
