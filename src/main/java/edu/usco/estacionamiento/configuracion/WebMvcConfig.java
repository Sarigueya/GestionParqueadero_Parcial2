package edu.usco.estacionamiento.configuracion;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Configuración de recursos estáticos (CSS, JS, imágenes).
 *
 * Mapea la URL /static/** a la carpeta física webapp/static/,
 * lo que permite que los JSP carguen hojas de estilo con:
 *   <link href="/static/css/login.css" rel="stylesheet"/>
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        /* Sirve todo lo que esté en /static/** desde la carpeta webapp/static/ */
        registry.addResourceHandler("/static/**")
                .addResourceLocations("/static/");
    }
}
