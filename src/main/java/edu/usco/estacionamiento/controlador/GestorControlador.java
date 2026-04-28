package edu.usco.estacionamiento.controlador;

import edu.usco.estacionamiento.modelo.Registro;
import edu.usco.estacionamiento.servicio.CategoriaServicio;
import edu.usco.estacionamiento.servicio.RegistroServicio;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controlador para el panel del Administrador.
 * Permite crear, editar, actualizar y eliminar registros de vehículos.
 * Incluye manejo de error por placa duplicada activa en el parqueadero.
 * Accesible únicamente para usuarios con rol ADMIN.
 */
@Controller
@RequestMapping("/admin")
@Tag(name = "Administrador", description = "Operaciones administrativas")
public class GestorControlador {

    @Autowired
    private RegistroServicio registroServicio;

    @Autowired
    private CategoriaServicio categoriaServicio;

    /** Muestra el listado completo de vehículos registrados */
    @Operation(summary = "Listar todos los vehículos")
    @GetMapping("/vehiculos")
    public String listar(Model model) {
        model.addAttribute("vehiculos", registroServicio.listarTodos());
        model.addAttribute("tipos", categoriaServicio.listarTodos());
        return "gestor/registros";
    }

    /** Muestra el formulario para registrar un nuevo vehículo */
    @Operation(summary = "Formulario de nuevo vehículo")
    @GetMapping("/vehiculos/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("vehiculo", new Registro());
        model.addAttribute("tipos", categoriaServicio.listarTodos());
        return "gestor/formulario";
    }

    /**
     * Procesa el guardado de un nuevo vehículo.
     * Si la placa ya está activa en el parqueadero, muestra un mensaje de error
     * en el formulario sin perder los datos ingresados.
     */
    @Operation(summary = "Guardar nuevo vehículo")
    @PostMapping("/vehiculos/guardar")
    public String guardar(@ModelAttribute Registro vehiculo, Model model) {
        try {
            registroServicio.guardar(vehiculo);
            return "redirect:/admin/vehiculos";
        } catch (IllegalStateException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("vehiculo", vehiculo);
            model.addAttribute("tipos", categoriaServicio.listarTodos());
            return "gestor/formulario";
        }
    }

    /** Muestra el formulario para editar un vehículo existente */
    @Operation(summary = "Formulario de edición de vehículo")
    @GetMapping("/vehiculos/editar/{id}")
    public String editar(@PathVariable Long id, Model model) {
        model.addAttribute("vehiculo", registroServicio.buscarPorId(id));
        model.addAttribute("tipos", categoriaServicio.listarTodos());
        return "gestor/formulario";
    }

    /**
     * Procesa la actualización de un vehículo.
     * Valida que la placa no esté activa en otro registro distinto.
     */
    @Operation(summary = "Actualizar vehículo")
    @PostMapping("/vehiculos/actualizar")
    public String actualizar(@ModelAttribute Registro vehiculo, Model model) {
        try {
            registroServicio.actualizar(vehiculo);
            return "redirect:/admin/vehiculos";
        } catch (IllegalStateException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("vehiculo", vehiculo);
            model.addAttribute("tipos", categoriaServicio.listarTodos());
            return "gestor/formulario";
        }
    }

    /** Elimina un vehículo del sistema */
    @Operation(summary = "Eliminar vehículo")
    @GetMapping("/vehiculos/eliminar/{id}")
    public String eliminar(@PathVariable Long id) {
        registroServicio.eliminar(id);
        return "redirect:/admin/vehiculos";
    }
}