package edu.usco.estacionamiento.modelo;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Entidad que representa un rol del sistema.
 * Valores posibles: GESTOR, OPERARIO, USUARIO
 */
@Data
@Entity
@Table(name = "rol")
public class Rol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Nombre del rol (ej: GESTOR, OPERARIO, USUARIO) */
    @Column(nullable = false, unique = true)
    private String nombre;
}
