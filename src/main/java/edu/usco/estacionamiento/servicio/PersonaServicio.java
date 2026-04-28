package edu.usco.estacionamiento.servicio;

import edu.usco.estacionamiento.modelo.Persona;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

/**
 * Servicio responsable de la búsqueda de usuarios (personas)
 * registrados en el sistema. Utilizado principalmente por el módulo de seguridad.
 */
@Service
@Transactional
public class PersonaServicio {

    @PersistenceContext
    private EntityManager em;

    /**
     * Busca una persona por su nombre de usuario.
     * Retorna null si no existe ningún registro coincidente.
     *
     * @param username nombre de usuario a buscar
     * @return la persona encontrada o null
     */
    public Persona buscarPorUsername(String username) {
        try {
            return em.createQuery(
                "SELECT p FROM Persona p WHERE p.username = :username",
                Persona.class)
                .setParameter("username", username)
                .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
