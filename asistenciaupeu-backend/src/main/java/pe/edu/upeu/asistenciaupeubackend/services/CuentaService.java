package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;
import pe.edu.upeu.asistenciaupeubackend.models.Cuenta;

public interface CuentaService {
    
    Cuenta save(Cuenta cuenta);
    
    List<Cuenta> findAll();

    Map<String, Boolean> delete(Long id);

    Cuenta getCuentaById(Long id);

    Cuenta update(Cuenta cuenta, Long id); 
}
