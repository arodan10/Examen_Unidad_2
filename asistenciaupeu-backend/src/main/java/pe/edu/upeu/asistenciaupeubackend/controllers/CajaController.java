package pe.edu.upeu.asistenciaupeubackend.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import pe.edu.upeu.asistenciaupeubackend.dtos.CajaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Caja;
import pe.edu.upeu.asistenciaupeubackend.services.CajaService;

@RestController
@RequestMapping("/api/caja")
public class CajaController {

    @Autowired
    private CajaService cajaService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ResponseEntity<List<Caja>> listCaja() {
        List<Caja> actDto = cajaService.findAll();
        return ResponseEntity.ok(actDto);
    }

    @PostMapping("/crear")
    public ResponseEntity<Caja> createCaja(@RequestBody CajaDto.CajaCrearDto caja) {
        Caja data = cajaService.save(caja);
        return ResponseEntity.ok(data);
    }

    @GetMapping("/buscar/{id}")
    public ResponseEntity<Caja> getCajaById(@PathVariable Long id) {
        Caja caja = cajaService.getCajaById(id);
        return ResponseEntity.ok(caja);
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<Caja> updateCaja(@PathVariable("id") Long id,
    @RequestBody CajaDto.CajaCrearDto cajaDetails) {
        Caja updatedCaja = cajaService.update(cajaDetails, id);
        return ResponseEntity.ok(updatedCaja);
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Map<String, Boolean>> deletecaja(@PathVariable Long id) {
        Map<String, Boolean> result = cajaService.delete(id);
        return ResponseEntity.ok(result);
    }  
    
}
