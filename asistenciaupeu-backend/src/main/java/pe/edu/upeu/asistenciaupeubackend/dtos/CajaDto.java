package pe.edu.upeu.asistenciaupeubackend.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.models.Cuenta;
import pe.edu.upeu.asistenciaupeubackend.models.Movimiento;
import pe.edu.upeu.asistenciaupeubackend.models.Unidad;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CajaDto {
    Long id;
    @JsonFormat(pattern = "yyyy-MM-dd")
    LocalDate fecha;
    String glosa;
    String cantidad;
    String precio;
    String subtotal;
    String unidad;
    String cuenta;
    String movimiento;
    //@JsonIgnoreProperties({ "cajas" })
    // Unidad unidadId;
    // Movimiento movimientoId;
    // Cuenta cuentaId;

    public record CajaCrearDto(Long id,LocalDate fecha, String glosa, String cantidad, String precio, String subtotal, String unidad, String cuenta, String movimiento) {
    }

    // public record CajaCrearDto(Long id,LocalDate fecha, String glosa, String cantidad, String precio, String subtotal, Long unidadId, Long movimientoId, Long cuentaId) {
    // }
}
