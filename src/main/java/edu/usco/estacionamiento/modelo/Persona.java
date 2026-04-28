package edu.usco.estacionamiento.modelo;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Entidad que representa a un usuario del sistema de estacionamiento.
 * Cada persona tiene un nombre de acceso único y un rol asignado.
 */
@Data
@Entity
@Table(name = "persona")
public class Persona {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Nombre de inicio de sesión (único en el sistema) */
    @Column(nullable = false, unique = true)
    private String username;

    /** Contraseña de acceso */
    @Column(nullable = false)
    private String password;

    /** Rol asignado que determina los permisos del usuario */
    @ManyToOne
    @JoinColumn(name = "rol_id", nullable = false)
    private Rol rol;
}
