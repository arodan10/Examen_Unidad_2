package pe.edu.upeu.asistenciaupeubackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import pe.edu.upeu.asistenciaupeubackend.dtos.CajaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Caja;

@Mapper(componentModel = "spring")
public interface CajaMapper {

    CajaDto toVacaDto(Caja caja);

    // @Mapping(target = "unidadId", ignore = true)
    // @Mapping(target = "movimientoId", ignore = true)
    // @Mapping(target = "cuentaId", ignore = true)
    Caja cajaCrearDtoToCaja(CajaDto.CajaCrearDto cajaCrearDto);
    
}
