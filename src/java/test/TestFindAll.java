package test;

import dao.EtudiantDao;
import entities.Etudiant;

import java.util.List;

public class TestFindAll {
     public static void main(String[] args) {
        EtudiantDao etudiantDao = new EtudiantDao();

        List<Etudiant> etudiants = etudiantDao.findAll();
        
        System.out.println("Liste des étudiants :");
        if (etudiants != null && !etudiants.isEmpty()) {
            for (Etudiant etudiant : etudiants) {
                System.out.println(etudiant.getNom() + " " + etudiant.getPrenom() + " - CNE: " + etudiant.getCne());
            }
        } else {
            System.out.println("Aucun étudiant trouvé.");
        }
    }
}