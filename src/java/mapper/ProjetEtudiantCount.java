package mapper;

public class ProjetEtudiantCount {
    private String projet;  // Changé de projetName à projet
    private long etudiantCount;

    public ProjetEtudiantCount(String projetName, long etudiantCount) {
        this.projet = projetName;
        this.etudiantCount = etudiantCount;
    }

    // Modifiez les getters pour correspondre aux noms utilisés dans le JavaScript
     public String getProjet() {
        return projet;
    }

    public long getEtudiantCount() {
        return etudiantCount;
    }
}