package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistenciaupeubackend.dtos.CajaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Caja;

public interface CajaService {
    Caja save(CajaDto.CajaCrearDto caja);

    List<Caja> findAll();

    Map<String, Boolean> delete(Long id);

    Caja getCajaById(Long id);

    Caja update(CajaDto.CajaCrearDto caja, Long id);
}