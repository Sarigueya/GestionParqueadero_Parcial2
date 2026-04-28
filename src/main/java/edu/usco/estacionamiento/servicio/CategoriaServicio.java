package edu.usco.estacionamiento.servicio;

import edu.usco.estacionamiento.modelo.CategoriaVehiculo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Servicio para consultar las categorías de vehículos disponibles.
 * Provee los datos necesarios para los formularios de registro.
 */
@Service
@Transactional
public class CategoriaServicio {

    @PersistenceContext
    private EntityManager em;

    /** Devuelve todas las categorías de vehículos registradas */
    public List<CategoriaVehiculo> listarTodos() {
        return em.createQuery(
            "SELECT c FROM CategoriaVehiculo c", CategoriaVehiculo.class)
            .getResultList();
    }
}
