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

import pe.edu.upeu.asistenciaupeubackend.models.Unidad;
import pe.edu.upeu.asistenciaupeubackend.repositories.UnidadRepository;

@RequiredArgsConstructor
@Service
@Transactional
public class UnidadServiceImp implements UnidadService {

    @Autowired
    private UnidadRepository unidadRepo;
    
    @Override
    public Unidad save(Unidad unidad) {
        
        try {
            return unidadRepo.save(unidad);
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<Unidad> findAll() {
        try {
            return unidadRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Unidad unidadx = unidadRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Unidad not exist with id :" + id));

        unidadRepo.delete(unidadx);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;        
    }

    @Override
    public Unidad getUnidadById(Long id) {
        Unidad findUnidad = unidadRepo.findById(id).orElseThrow(() -> new ResourceNotFoundException("Unidad not exist with id :" + id));
        return findUnidad;        
    }

    @Override
    public Unidad update(Unidad unidad, Long id) {
        Unidad unidadx = unidadRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
        unidadx.setUnidad(unidad.getUnidad());
        return unidadRepo.save(unidadx);        
    }
}
