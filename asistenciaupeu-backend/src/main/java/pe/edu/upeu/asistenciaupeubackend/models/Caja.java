package pe.edu.upeu.asistenciaupeubackend.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "cajas")
public class Caja {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonFormat(pattern = "yyyy-MM-dd")    
    @Basic(optional = false)
    @Column(name = "fecha", nullable = false)
    @Temporal(TemporalType.DATE)
    private LocalDate fecha;

    @Column(name = "glosa", nullable = false)
    @Size(max = 100)
    private String glosa;
    
    @Column(name = "cantidad", nullable = false)
    @Size(max = 100)
    private String cantidad;

    @Column(name = "precio", nullable = false)
    @Size(max = 100)
    private String precio;

    @Column(name = "subtotal", nullable = false)
    @Size(max = 100)
    private String subtotal;

    @Column(name = "unidad", nullable = false)
    @Size(max = 100)
    private String unidad;

    @Column(name = "cuenta", nullable = false)
    @Size(max = 100)
    private String cuenta;

    @Column(name = "movimiento", nullable = false)
    @Size(max = 100)
    private String movimiento;

    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    @PreUpdate
    public void prePersistAndUpdate() {
        LocalDateTime now = LocalDateTime.now().truncatedTo(ChronoUnit.SECONDS);
        if (fechaCreacion == null) {
            fechaCreacion = now;
        }
        fechaActualizacion = now;
    }

    // @JoinColumn(name = "unidad_id", referencedColumnName = "id")
    // @ManyToOne(optional = false)
    // @JsonIgnoreProperties({"cajas"})
    // private Unidad unidadId; 

    // @JoinColumn(name = "movimiento_id", referencedColumnName = "id")
    // @ManyToOne(optional = false)
    // @JsonIgnoreProperties({"cajas"})
    // private Movimiento movimientoId; 

    // @JoinColumn(name = "cuenta_id", referencedColumnName = "id")
    // @ManyToOne(optional = false)
    // @JsonIgnoreProperties({"cajas"})
    // private Cuenta cuentaId; 
}
