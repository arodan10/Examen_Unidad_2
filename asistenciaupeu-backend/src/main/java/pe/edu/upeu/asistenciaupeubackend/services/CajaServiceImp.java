package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.dtos.CajaDto;
import pe.edu.upeu.asistenciaupeubackend.exceptions.AppException;
import pe.edu.upeu.asistenciaupeubackend.exceptions.ResourceNotFoundException;
import pe.edu.upeu.asistenciaupeubackend.mappers.CajaMapper;
import pe.edu.upeu.asistenciaupeubackend.models.Caja;
import pe.edu.upeu.asistenciaupeubackend.repositories.CajaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
@Transactional

public class CajaServiceImp implements CajaService {

    @Autowired
    private CajaRepository cajaRepo;

    // @Autowired
    // private UnidadService unidadService;

    // @Autowired
    // private MovimientoService movimientoService;

    // @Autowired
    // private CuentaService cuentaService;

    private final CajaMapper cajaMapper;

    @Override
    public Caja save(CajaDto.CajaCrearDto caja) {

        Caja matEnt = cajaMapper.cajaCrearDtoToCaja(caja);
        // matEnt.setUnidadId(unidadService.getUnidadById(caja.unidadId()));
        // matEnt.setMovimientoId(movimientoService.getMovimientoById(caja.movimientoId()));
        // matEnt.setCuentaId(cuentaService.getCuentaById(caja.cuentaId()));
        System.out.println(caja.fecha());
        try {
            return cajaRepo.save(matEnt);
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<Caja> findAll() {
        try {
            return cajaRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Caja cajax = cajaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Caja not exist with id :" + id));
        cajaRepo.delete(cajax);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;        
    }

    @Override
    public Caja getCajaById(Long id) {
        Caja findCaja = cajaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Caja not exist with id :" + id));
        return findCaja;
    }

    @Override
    public Caja update(CajaDto.CajaCrearDto caja, Long id) {

        Caja cajax = cajaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
                cajax.setFecha(caja.fecha());
                cajax.setGlosa(caja.glosa());
                cajax.setCantidad(caja.cantidad());
                cajax.setPrecio(caja.precio());
                cajax.setSubtotal(caja.subtotal());
                cajax.setUnidad(caja.unidad());
                cajax.setCuenta(caja.cuenta());
                cajax.setMovimiento(caja.movimiento());
                // cajax.setUnidadId(unidadService.getUnidadById(caja.unidadId()));
                // cajax.setMovimientoId(movimientoService.getMovimientoById(caja.movimientoId()));
                // cajax.setCuentaId(cuentaService.getCuentaById(caja.cuentaId()));

        return cajaRepo.save(cajax);
    }
    
}
