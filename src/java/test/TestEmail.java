package test;

import dao.EtudiantDao;
import entities.Etudiant;

/**
 * Test class for finding an Etudiant by email.
 * 
 * @author hibaa
 */
public class TestEmail {
    public static void main(String[] args) {
        EtudiantDao etudiantDao = new EtudiantDao();
        Etudiant etudiant = etudiantDao.findEtudiantByEmail("agourramfatimaezzahra0@gmail.com");
        
        if (etudiant != null) {
            System.out.println("Etudiant trouvé : " + etudiant.getNom() + " " + etudiant.getPrenom());
        } else {
            System.out.println("Aucun etudiant trouvé avec cet email.");
        }
    }
}