package pe.edu.upeu.asistenciaupeubackend.repositories;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pe.edu.upeu.asistenciaupeubackend.models.Movimiento;

@Repository
public interface MovimientoRepository extends JpaRepository<Movimiento, Long> {
    Optional<Movimiento> findByMovimiento(String movimiento);  
}
