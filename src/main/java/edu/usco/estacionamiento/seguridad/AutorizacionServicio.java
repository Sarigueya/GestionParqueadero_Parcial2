package edu.usco.estacionamiento.seguridad;

import edu.usco.estacionamiento.modelo.Persona;
import edu.usco.estacionamiento.servicio.PersonaServicio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

/**
 * Implementación de UserDetailsService para la autenticación con Spring Security.
 * Carga los datos de una persona y construye los roles de autorización correspondientes.
 */
@Service
public class AutorizacionServicio implements UserDetailsService {

    @Autowired
    private PersonaServicio personaServicio;

    /**
     * Carga los detalles de autenticación de un usuario por su nombre de acceso.
     * El prefijo "ROLE_" es requerido por Spring Security para el mapeo de roles.
     *
     * @param username nombre del usuario que intenta autenticarse
     * @return objeto UserDetails con credenciales y autoridades
     * @throws UsernameNotFoundException si el usuario no existe en el sistema
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Persona persona = personaServicio.buscarPorUsername(username);

        if (persona == null) {
            throw new UsernameNotFoundException("No existe el usuario: " + username);
        }

        return new User(
            persona.getUsername(),
            persona.getPassword(),
            Collections.singletonList(
                new SimpleGrantedAuthority("ROLE_" + persona.getRol().getNombre())
            )
        );
    }
}
