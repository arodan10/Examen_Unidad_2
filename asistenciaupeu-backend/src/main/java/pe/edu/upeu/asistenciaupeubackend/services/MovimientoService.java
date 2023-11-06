package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;
import pe.edu.upeu.asistenciaupeubackend.models.Movimiento;

public interface MovimientoService {
    
    Movimiento save(Movimiento movimiento);
    
    List<Movimiento> findAll();

    Map<String, Boolean> delete(Long id);

    Movimiento getMovimientoById(Long id);

    Movimiento update(Movimiento movimiento, Long id); 
}
