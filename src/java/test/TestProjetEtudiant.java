package test;

import dao.ProjetEtudiantDao;
import entities.ProjetEtudiant;

import java.util.List;

public class TestProjetEtudiant {
    public static void main(String[] args) {
        ProjetEtudiantDao projetEtudiantDao = new ProjetEtudiantDao();

        String titreRecherche = "Système de gestion";
        List<ProjetEtudiant> projetsParTitre = projetEtudiantDao.findByTitre(titreRecherche);
        System.out.println("Projets trouvés avec le titre '" + titreRecherche + "':");
        for (ProjetEtudiant p : projetsParTitre) {
            System.out.println("ID: " + p.getIdPro() + ", Titre: " + p.getTitre());
        }

        String encadrentRecherche = "Prof. Zahid";
        List<ProjetEtudiant> projetsParEncadrent = projetEtudiantDao.findByEncadrent(encadrentRecherche);
        System.out.println("Projets trouvés avec l'encadrant '" + encadrentRecherche + "':");
        for (ProjetEtudiant p : projetsParEncadrent) {
            System.out.println("ID: " + p.getIdPro() + ", Titre: " + p.getTitre());
        }
    }
}