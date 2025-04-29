package entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "etudiants")
@NamedQueries({
    @NamedQuery(name = "findEtudiantByEmail", query = "FROM Etudiant  WHERE email = :email"),
    @NamedQuery(name = "findByCne", query = "FROM Etudiant WHERE cne = :cne")
})
public class Etudiant extends User {

    @Column(name = "cne", unique = true, length = 255)
    private String cne;

    @OneToMany(mappedBy = "etudiant", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<AffectationProjet> affectations;

    public Etudiant() {}

    public Etudiant(String nom, String prenom, String email, String motDePasse, String cne) {
        super(nom, prenom, email, motDePasse);
        this.cne = cne;
    }

   
    public String getCne() {
        return cne;
    }

    public void setCne(String cne) {
        this.cne = cne;
    }

    public List<AffectationProjet> getAffectations() {
        return affectations;
    }

    public void setAffectations(List<AffectationProjet> affectations) {
        this.affectations = affectations;
    }
}