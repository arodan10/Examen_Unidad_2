package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;
import pe.edu.upeu.asistenciaupeubackend.models.Unidad;

public interface UnidadService {

    Unidad save(Unidad unidad);
    
    List<Unidad> findAll();

    Map<String, Boolean> delete(Long id);

    Unidad getUnidadById(Long id);

    Unidad update(Unidad unidad, Long id); 
    
}
