<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <title>ParkControl — Formulario</title>
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
    <a href="/admin/vehiculos" class="sb-item">
        <i class="bi bi-table"></i> Registros
    </a>
    <a href="/admin/vehiculos/nuevo" class="sb-item activo">
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

<div class="contenido">
    <div class="topbar">
        <div>
            <div class="topbar-titulo">
                ${vehiculo.id == null ? 'Nuevo vehículo' : 'Editar vehículo'}
            </div>
            <div class="topbar-bread">Registros &rsaquo;
                ${vehiculo.id == null ? 'Nuevo' : 'Editar #'}${vehiculo.id}
            </div>
        </div>
        <span class="badge-rol"><i class="bi bi-shield-check"></i> ADMIN</span>
    </div>

    <div class="main" style="display:flex;align-items:flex-start;justify-content:center">
        <div class="form-card">

            <div class="form-head">
                <c:choose>
                    <c:when test="${vehiculo.id == null}">
                        <div class="modo-badge"><i class="bi bi-plus-circle"></i> Nuevo vehículo</div>
                    </c:when>
                    <c:otherwise>
                        <div class="modo-badge"><i class="bi bi-pencil"></i> Editando #${vehiculo.id}</div>
                    </c:otherwise>
                </c:choose>
                <div class="form-head-titulo">Datos del vehículo</div>
                <div class="form-head-sub">Completa todos los campos obligatorios</div>
            </div>

            <%-- Mensaje de error por placa duplicada --%>
            <c:if test="${not empty error}">
                <div style="background:#1c1010;border:1px solid #450a0a;border-radius:9px;padding:10px 14px;font-size:13px;color:#fca5a5;display:flex;align-items:center;gap:8px;margin-bottom:1.2rem">
                    <i class="bi bi-exclamation-circle-fill"></i> ${error}
                </div>
            </c:if>

            <form method="post"
                  action="${vehiculo.id == null ? '/admin/vehiculos/guardar' : '/admin/vehiculos/actualizar'}">
                <input type="hidden" name="id" value="${vehiculo.id}"/>

                <div class="campo">
                    <label>Placa <span style="color:#f87171">*</span></label>
                    <input type="text" name="placa" maxlength="6"
                           value="${vehiculo.placa}" placeholder="Ej: HUI451"
                           required style="text-transform:uppercase"/>
                    <div class="hint">Máximo 6 caracteres alfanuméricos</div>
                </div>

                <div class="fila-2">
                    <div class="campo">
                        <label>Hora de entrada <span style="color:#f87171">*</span></label>
                        <input type="time" name="horaEntrada" value="${vehiculo.horaEntrada}" required/>
                    </div>
                    <div class="campo">
                        <label>Hora de salida</label>
                        <input type="time" name="horaSalida" value="${vehiculo.horaSalida}"/>
                        <div class="hint">Vacío si aún está adentro</div>
                    </div>
                </div>

                <div class="campo">
                    <label>Ubicación <span style="color:#f87171">*</span></label>
                    <input type="text" name="ubicacion"
                           value="${vehiculo.ubicacion}"
                           placeholder="Ej: A-2, B-41, CS-875" required/>
                </div>

                <div class="campo">
                    <label>Tipo de vehículo <span style="color:#f87171">*</span></label>
                    <select name="tipoVehiculo.id">
                        <c:forEach var="t" items="${tipos}">
                            <option value="${t.id}"
                                ${vehiculo.tipoVehiculo != null && vehiculo.tipoVehiculo.id == t.id ? 'selected' : ''}>
                                ${t.nombre}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="divisor"></div>

                <div class="acciones-form">
                    <button type="submit" class="btn-guardar">
                        <i class="bi bi-check2-circle"></i> Guardar
                    </button>
                    <a href="/admin/vehiculos" class="btn-cancelar">
                        <i class="bi bi-x-circle"></i> Cancelar
                    </a>
                </div>
            </form>

        </div>
    </div>
</div>

</body>
</html>
