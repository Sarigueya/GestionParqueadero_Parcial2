package edu.usco.estacionamiento.modelo;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalTime;

/**
 * Entidad que representa el registro de un vehículo
 * dentro del sistema de estacionamiento.
 * Almacena la placa, tiempos de entrada/salida, ubicación y categoría.
 */
@Data
@Entity
@Table(name = "registro_vehiculo")
public class Registro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Placa del vehículo (máximo 6 caracteres) */
    @Column(nullable = false, length = 6)
    private String placa;

    /** Hora de ingreso al estacionamiento */
    @Column(name = "hora_ingreso", nullable = false)
    private LocalTime horaEntrada;

    /** Hora de salida (null si el vehículo sigue en el parqueadero) */
    @Column(name = "hora_salida")
    private LocalTime horaSalida;

    /** Espacio asignado dentro del estacionamiento (ej: A-2, B-15) */
    @Column(nullable = false)
    private String ubicacion;

    /** Categoría del vehículo registrado */
    @ManyToOne
    @JoinColumn(name = "categoria_vehiculo_id", nullable = false)
    private CategoriaVehiculo tipoVehiculo;
}
