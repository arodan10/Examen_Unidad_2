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

import pe.edu.upeu.asistenciaupeubackend.models.Movimiento;
import pe.edu.upeu.asistenciaupeubackend.repositories.MovimientoRepository;

@RequiredArgsConstructor
@Service
@Transactional
public class MovimientoServiceImp implements MovimientoService {
    @Autowired
    private MovimientoRepository movimientoRepo;
    
    @Override
    public Movimiento save(Movimiento movimiento) {
        
        try {
            return movimientoRepo.save(movimiento);
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<Movimiento> findAll() {
        try {
            return movimientoRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-"+e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Movimiento movimientox = movimientoRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Movimiento not exist with id :" + id));

        movimientoRepo.delete(movimientox);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;        
    }

    @Override
    public Movimiento getMovimientoById(Long id) {
        Movimiento findMovimiento = movimientoRepo.findById(id).orElseThrow(() -> new ResourceNotFoundException("Movimiento not exist with id :" + id));
        return findMovimiento;        
    }

    @Override
    public Movimiento update(Movimiento movimiento, Long id) {
        Movimiento movimientox = movimientoRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
        movimientox.setMovimiento(movimiento.getMovimiento());
        return movimientoRepo.save(movimientox);        
    }
}
