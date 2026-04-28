<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"/>
    <title>ParkControl — Actualizar ubicación</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/static/css/acomodador.css" rel="stylesheet"/>
</head>
<body style="display:flex;flex-direction:column">

<header class="header">
    <div class="hdr-marca">
        <div class="hdr-marca-ico"><i class="bi bi-p-square-fill"></i></div>
        <span class="hdr-marca-txt">ParkControl</span>
    </div>
    <span class="badge-rol"><i class="bi bi-person-workspace"></i> ACOMODADOR</span>
    <a href="/logout" class="btn-hdr-salir"><i class="bi bi-power"></i> Salir</a>
</header>

<div class="main-form">
    <div class="caja-form">

        <!-- Resumen del vehículo seleccionado -->
        <div class="vehiculo-info">
            <div class="vi-placa-box">
                <div class="vi-placa">${vehiculo.placa}</div>
                <div class="vi-tipo">${vehiculo.tipoVehiculo.nombre}</div>
            </div>
            <div>
                <div class="vi-fila">
                    <i class="bi bi-clock-history" style="color:#22c55e"></i>
                    Ingresó a las <strong>${vehiculo.horaEntrada}</strong>
                </div>
                <div class="vi-fila">
                    <i class="bi bi-geo-alt"></i>
                    Ubicación actual: <strong>${vehiculo.ubicacion}</strong>
                </div>
            </div>
        </div>

        <!-- Formulario de actualización -->
        <div class="form-caja">
            <div class="form-titulo">Actualizar ubicación</div>
            <div class="form-sub">Escribe el nuevo código de espacio donde se ubica el vehículo</div>

            <form method="post" action="/acomodador/vehiculos/actualizar">
                <!-- Campos ocultos para conservar los datos del registro -->
                <input type="hidden" name="id"              value="${vehiculo.id}"/>
                <input type="hidden" name="placa"           value="${vehiculo.placa}"/>
                <input type="hidden" name="horaEntrada"     value="${vehiculo.horaEntrada}"/>
                <input type="hidden" name="horaSalida"      value="${vehiculo.horaSalida}"/>
                <input type="hidden" name="tipoVehiculo.id" value="${vehiculo.tipoVehiculo.id}"/>

                <div class="campo">
                    <label>Nueva ubicación</label>
                    <input type="text" name="ubicacion"
                           value="${vehiculo.ubicacion}"
                           placeholder="Ej: A-2, B-41, CS-875" required autofocus/>
                    <div class="hint">Formato sugerido: letra-número (ej: B-07)</div>
                </div>

                <div class="divisor"></div>

                <div class="acciones">
                    <button type="submit" class="btn-actualizar">
                        <i class="bi bi-check2-circle"></i> Actualizar
                    </button>
                    <a href="/acomodador/vehiculos" class="btn-cancelar">
                        <i class="bi bi-arrow-left"></i> Volver
                    </a>
                </div>
            </form>
        </div>

    </div>
</div>

</body>
</html>
