package entities;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "projet_etudiant")
@NamedQueries({
    @NamedQuery(name = "ProjetEtudiant.findAll", query = "FROM ProjetEtudiant"),
    @NamedQuery(name = "ProjetEtudiant.findByTitre", query = "FROM ProjetEtudiant WHERE titre = :titre"),
    @NamedQuery(name = "ProjetEtudiant.findByEncadrent", query = "FROM ProjetEtudiant WHERE encadrent = :encadrent")
})
public class ProjetEtudiant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pro")
    private int idPro;

    private String titre;
    private String description;
    private String encadrent;

    @Column(nullable = false) 
    private int annee; 

    @OneToMany(mappedBy = "projet", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AffectationProjet> affectations = new ArrayList<>();

    public ProjetEtudiant() {}

    public ProjetEtudiant(String titre, String description, String encadrent, int annee) {
        this.titre = titre;
        this.description = description;
        this.encadrent = encadrent;
        this.annee = annee; 
    }

    public int getIdPro() {
        return idPro;
    }

    public void setIdPro(int idPro) {
        this.idPro = idPro;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEncadrent() {
        return encadrent;
    }

    public void setEncadrent(String encadrent) {
        this.encadrent = encadrent;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) { 
        this.annee = annee;
    }

    public List<AffectationProjet> getAffectations() {
        return affectations;
    }

    public void addAffectation(AffectationProjet affectation) {
        affectations.add(affectation);
        affectation.setProjet(this);
    }

    public void removeAffectation(AffectationProjet affectation) {
        affectations.remove(affectation);
        affectation.setProjet(null);
    }
}