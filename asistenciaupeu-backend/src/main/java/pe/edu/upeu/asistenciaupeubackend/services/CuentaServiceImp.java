package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.exceptions.AppException;
import pe.edu.upeu.asistenciaupeubackend.exceptions.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pe.edu.upeu.asistenciaupeubackend.models.Cuenta;
import pe.edu.upeu.asistenciaupeubackend.repositories.CuentaRepository;

@RequiredArgsConstructor
@Service
@Transactional
public class CuentaServiceImp implements CuentaService {

    @Autowired
    private CuentaRepository cuentaRepo;
    
    @Override
    public Cuenta save(Cuenta cuenta) {
        
        try {
            return cuentaRepo.save(cuenta);
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<Cuenta> findAll() {
        try {
            return cuentaRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Cuenta cuentax = cuentaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Cuenta not exist with id :" + id));

        cuentaRepo.delete(cuentax);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;        
    }

    @Override
    public Cuenta getCuentaById(Long id) {
        Cuenta findCuenta = cuentaRepo.findById(id).orElseThrow(() -> new ResourceNotFoundException("Cuenta not exist with id :" + id));
        return findCuenta;        
    }

    @Override
    public Cuenta update(Cuenta cuenta, Long id) {
        Cuenta cuentax = cuentaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
        cuentax.setNombre(cuenta.getNombre());
        return cuentaRepo.save(cuentax);        
    }
}

