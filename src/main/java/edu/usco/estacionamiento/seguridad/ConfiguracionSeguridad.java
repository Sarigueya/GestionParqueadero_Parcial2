package edu.usco.estacionamiento.seguridad;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Configuración central de Spring Security para el sistema de estacionamiento.
 * Define las reglas de acceso por rol, la página de login y el comportamiento
 * de cierre de sesión.
 *
 * Roles del sistema:
 *   - GESTOR   → administrador con acceso total
 *   - OPERARIO → encargado de actualizar ubicaciones
 *   - USUARIO  → consulta de registros en modo lectura
 */
@Configuration
@EnableWebSecurity
public class ConfiguracionSeguridad {

    @Autowired
    private AutorizacionServicio autorizacionServicio;

    /**
     * Codificador de contraseñas. Se usa NoOpPasswordEncoder para desarrollo.
     * NOTA: En producción debe reemplazarse por BCryptPasswordEncoder.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    /**
     * Cadena de filtros de seguridad HTTP.
     * Define rutas públicas, restricciones por rol, login y logout.
     */
    @Bean
    public SecurityFilterChain filtroSeguridad(HttpSecurity http) throws Exception {
        http
            /* Deshabilitar CSRF para entorno de desarrollo con JSP */
            .csrf(csrf -> csrf.disable())

            /* Definición de permisos por ruta y rol */
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/login",
                    "/WEB-INF/**",
                    "/static/**",
                    "/css/**",
                    "/js/**",
                    "/swagger-ui/**",
                    "/v3/api-docs/**"
                ).permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/acomodador/**").hasRole("ACOMODADOR")
                .requestMatchers("/cliente/**").hasRole("CLIENTE")
                .anyRequest().authenticated()
            )

            /* Configuración del formulario de autenticación */
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successHandler((request, response, authentication) -> {
                    /* Redirigir al panel correspondiente según el rol del usuario */
                    String rol = authentication.getAuthorities()
                            .iterator().next().getAuthority();
                    if (rol.equals("ROLE_ADMIN")) {
                        response.sendRedirect("/admin/vehiculos");
                    } else if (rol.equals("ROLE_ACOMODADOR")) {
                        response.sendRedirect("/acomodador/vehiculos");
                    } else {
                        response.sendRedirect("/cliente/vehiculos");
                    }
                })
                .failureUrl("/login?error=true")
                .permitAll()
            )

            /* Configuración del cierre de sesión */
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login")
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .permitAll()
            )

            /* Página personalizada de acceso denegado */
            .exceptionHandling(ex -> ex
                .accessDeniedPage("/sin-acceso")
            );

        return http.build();
    }

    /**
     * Construye el AuthenticationManager con el servicio de usuarios
     * y el codificador de contraseñas configurado.
     */
    @Bean
    public AuthenticationManager authManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder builder =
                http.getSharedObject(AuthenticationManagerBuilder.class);
        builder.userDetailsService(autorizacionServicio)
               .passwordEncoder(passwordEncoder());
        return builder.build();
    }
}
