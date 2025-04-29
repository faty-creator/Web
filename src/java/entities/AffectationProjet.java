package entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "affectation_projet")
@NamedQueries({
    @NamedQuery(name = "AffectationProjet.findAll", query = "FROM AffectationProjet"),
    @NamedQuery(name = "AffectationProjet.findByEtudiantAndProjet", query = "FROM AffectationProjet WHERE etudiant.id = :etudiantId AND projet.idPro = :projetId")
})
public class AffectationProjet implements Serializable {

    @EmbeddedId
    private AffectationId id;

    @ManyToOne
    @MapsId("etudiantId")
    @JoinColumn(name = "etudiant_id")
    private Etudiant etudiant;

    @ManyToOne
    @MapsId("projetId")
    @JoinColumn(name = "projet_id")
    private ProjetEtudiant projet;

    @Column(name = "date_debut")
    @Temporal(TemporalType.DATE)
    private Date dateDebut;

    @Column(name = "date_fin")
    @Temporal(TemporalType.DATE)
    private Date dateFin;

    public AffectationProjet() {}

    public AffectationProjet(Etudiant etudiant, ProjetEtudiant projet, Date dateDebut, Date dateFin) {
        this.id = new AffectationId(etudiant.getId(), projet.getIdPro());
        this.etudiant = etudiant;
        this.projet = projet;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public AffectationId getId() {
        return id;
    }

    public void setId(AffectationId id) {
        this.id = id;
    }

    public Etudiant getEtudiant() {
        return etudiant;
    }

    public void setEtudiant(Etudiant etudiant) {
        this.etudiant = etudiant;
    }

    public ProjetEtudiant getProjet() {
        return projet;
    }

    public void setProjet(ProjetEtudiant projet) {
        this.projet = projet;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }
}