package entities;

import javax.persistence.Column;
import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Embeddable;

@Embeddable
public class AffectationId implements Serializable {

    @Column(name = "etudiant_id")
    private int etudiantId;

    @Column(name = "projet_id")
    private int projetId;

    public AffectationId() {}

    public AffectationId(int etudiantId, int projetId) {
        this.etudiantId = etudiantId;
        this.projetId = projetId;
    }

    public int getEtudiantId() {
        return etudiantId;
    }

    public void setEtudiantId(int etudiantId) {
        this.etudiantId = etudiantId;
    }

    public int getProjetId() {
        return projetId;
    }

    public void setProjetId(int projetId) {
        this.projetId = projetId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AffectationId that = (AffectationId) o;
        return projetId == that.projetId && etudiantId == that.etudiantId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(etudiantId, projetId);
    }
}