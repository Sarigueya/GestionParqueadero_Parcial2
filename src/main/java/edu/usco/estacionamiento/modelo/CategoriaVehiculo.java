package edu.usco.estacionamiento.modelo;

import jakarta.persistence.*;
import lombok.Data;

/**
 * Entidad que clasifica los vehículos según su tipo.
 * Ejemplos: Carro, Moto, Camión, Bicicleta
 */
@Data
@Entity
@Table(name = "categoria_vehiculo")
public class CategoriaVehiculo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** Nombre descriptivo de la categoría */
    @Column(nullable = false, unique = true)
    private String nombre;
}
