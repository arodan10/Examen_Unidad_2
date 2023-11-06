package pe.edu.upeu.asistenciaupeubackend.repositories;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.asistenciaupeubackend.models.Unidad;

@Repository
public interface UnidadRepository extends JpaRepository<Unidad, Long> {
    Optional<Unidad> findByUnidad(String unidad);    
}
