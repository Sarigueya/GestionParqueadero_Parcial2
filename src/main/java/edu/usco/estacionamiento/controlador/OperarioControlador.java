package edu.usco.estacionamiento.controlador;

import edu.usco.estacionamiento.modelo.Registro;
import edu.usco.estacionamiento.servicio.RegistroServicio;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador para el panel del Acomodador.
 * Puede visualizar vehículos y actualizar su ubicación.
 * Accesible únicamente para usuarios con rol ACOMODADOR.
 */
@Controller
@RequestMapping("/acomodador")
@Tag(name = "Acomodador", description = "Gestión de espacios por el acomodador")
public class OperarioControlador {

    @Autowired
    private RegistroServicio registroServicio;

    /** Lista todos los vehículos en el parqueadero */
    @Operation(summary = "Listar vehículos")
    @GetMapping("/vehiculos")
    public String listar(Model model) {
        model.addAttribute("vehiculos", registroServicio.listarTodos());
        return "operario/registros";
    }

    /** Muestra el formulario para cambiar la ubicación de un vehículo */
    @Operation(summary = "Formulario de actualización de ubicación")
    @GetMapping("/vehiculos/editar/{id}")
    public String editar(@PathVariable Long id, Model model) {
        model.addAttribute("vehiculo", registroServicio.buscarPorId(id));
        return "operario/formulario";
    }

    /** Aplica el cambio de ubicación */
    @Operation(summary = "Actualizar ubicación del vehículo")
    @PostMapping("/vehiculos/actualizar")
    public String actualizar(@ModelAttribute Registro vehiculo) {
        registroServicio.actualizar(vehiculo);
        return "redirect:/acomodador/vehiculos";
    }
}
