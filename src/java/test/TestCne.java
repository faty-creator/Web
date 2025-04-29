package test;

import dao.EtudiantDao;
import entities.Etudiant;

public class TestCne {
    public static void main(String[] args) {
        EtudiantDao etudiantDao = new EtudiantDao();
        String cneToTest = "EE884424"; 
        Etudiant etudiant = etudiantDao.findByCne(cneToTest);
        
        if (etudiant != null) {
            System.out.println("Étudiant trouvé : " + etudiant.getNom() + " " + etudiant.getPrenom());
        } else {
            System.out.println("Aucun étudiant trouvé avec CNE : " + cneToTest);
        }
    }
}