package edu.usco.estacionamiento.controlador;

import edu.usco.estacionamiento.servicio.RegistroServicio;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Controlador para el panel del Cliente.
 * Solo permite visualizar los vehículos en modo lectura.
 * Accesible únicamente para usuarios con rol CLIENTE.
 */
@Controller
@RequestMapping("/cliente")
@Tag(name = "Cliente", description = "Consulta de vehículos para el cliente")
public class UsuarioControlador {

    @Autowired
    private RegistroServicio registroServicio;

    /** Muestra los vehículos registrados en modo solo lectura */
    @Operation(summary = "Consultar vehículos del parqueadero")
    @GetMapping("/vehiculos")
    public String listar(Model model) {
        model.addAttribute("vehiculos", registroServicio.listarTodos());
        return "usuario/registros";
    }
}
