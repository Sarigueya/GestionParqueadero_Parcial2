package edu.usco.estacionamiento.servicio;

import edu.usco.estacionamiento.modelo.Registro;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Servicio encargado de las operaciones CRUD sobre los registros de vehículos.
 * Incluye validación de placa duplicada: no permite registrar un vehículo
 * que ya tenga un registro activo (sin hora de salida) en el parqueadero.
 */
@Service
@Transactional
public class RegistroServicio {

    @PersistenceContext
    private EntityManager em;

    /** Retorna la lista completa de registros en el sistema */
    public List<Registro> listarTodos() {
        return em.createQuery("SELECT r FROM Registro r", Registro.class)
                 .getResultList();
    }

    /**
     * Busca un registro por su identificador único.
     * @param id clave primaria del registro
     * @return el registro encontrado o null si no existe
     */
    public Registro buscarPorId(Long id) {
        return em.find(Registro.class, id);
    }

    /**
     * Verifica si una placa ya tiene un registro activo en el parqueadero.
     * Un registro se considera activo cuando su hora de salida es null.
     * Se excluye el id actual para que la edición de un registro no se bloquee a sí misma.
     *
     * @param placa placa a verificar
     * @param idExcluir id del registro a excluir (null si es un registro nuevo)
     * @return true si la placa ya está activa en el parqueadero
     */
    public boolean placaActivaEnParqueadero(String placa, Long idExcluir) {
        String jpql = idExcluir == null
            ? "SELECT COUNT(r) FROM Registro r WHERE r.placa = :placa AND r.horaSalida IS NULL"
            : "SELECT COUNT(r) FROM Registro r WHERE r.placa = :placa AND r.horaSalida IS NULL AND r.id <> :id";

        var query = em.createQuery(jpql, Long.class)
                      .setParameter("placa", placa.toUpperCase());

        if (idExcluir != null) {
            query.setParameter("id", idExcluir);
        }

        return query.getSingleResult() > 0;
    }

    /**
     * Persiste un nuevo registro en la base de datos.
     * Lanza excepción si la placa ya está activa en el parqueadero.
     *
     * @param registro objeto a almacenar
     * @throws IllegalStateException si la placa ya tiene un registro activo
     */
    public void guardar(Registro registro) {
        registro.setPlaca(registro.getPlaca().toUpperCase());
        if (placaActivaEnParqueadero(registro.getPlaca(), null)) {
            throw new IllegalStateException(
                "El vehículo con placa " + registro.getPlaca() + " ya se encuentra en el parqueadero."
            );
        }
        em.persist(registro);
    }

    /**
     * Actualiza un registro existente con nuevos datos.
     * Valida placa duplicada excluyendo el propio registro editado.
     *
     * @param registro objeto con los cambios aplicados
     * @throws IllegalStateException si la nueva placa ya está activa en otro registro
     */
    public void actualizar(Registro registro) {
        registro.setPlaca(registro.getPlaca().toUpperCase());
        if (placaActivaEnParqueadero(registro.getPlaca(), registro.getId())) {
            throw new IllegalStateException(
                "El vehículo con placa " + registro.getPlaca() + " ya se encuentra en el parqueadero."
            );
        }
        em.merge(registro);
    }

    /**
     * Elimina un registro del sistema de forma permanente.
     * Si el ID no existe, la operación se ignora de forma segura.
     *
     * @param id clave primaria del registro a eliminar
     */
    public void eliminar(Long id) {
        Registro registro = em.find(Registro.class, id);
        if (registro != null) {
            em.remove(registro);
        }
    }
}
