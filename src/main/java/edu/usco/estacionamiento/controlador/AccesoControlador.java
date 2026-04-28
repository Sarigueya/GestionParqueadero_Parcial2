package edu.usco.estacionamiento.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Controlador de autenticación y páginas de error de acceso.
 * Maneja el login, mensajes de error y la página de acceso denegado.
 */
@Controller
public class AccesoControlador {

    /** Redirige la raíz del sitio al login */
    @GetMapping("/")
    public String raiz() {
        return "redirect:/login";
    }

    /** Muestra la página de inicio de sesión */
    @GetMapping("/login")
    public String login(
            @RequestParam(value = "error", required = false) String error,
            Model model) {

        if (error != null) {
            model.addAttribute("mensajeError", "Credenciales incorrectas. Intenta de nuevo.");
        }
        return "login";
    }

    /** Muestra la página de acceso denegado cuando el rol no tiene permisos */
    @GetMapping("/sin-acceso")
    public String sinAcceso() {
        return "sin-acceso";
    }
}
