package test;

import dao.AdminDao;
import dao.AffectationProjetDao;
import dao.EtudiantDao;
import dao.ProjetEtudiantDao;
import entities.AffectationProjet;
import entities.Etudiant;
import entities.ProjetEtudiant;
import util.HibernateUtil;

import java.util.Date;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        
        HibernateUtil.getSessionFactory();
        EtudiantDao etudiantDao = new EtudiantDao();
        ProjetEtudiantDao projetDao = new ProjetEtudiantDao();
        AffectationProjetDao affectationDao = new AffectationProjetDao();
        
        
        
       /*
        EtudiantDao etudiantDao = new EtudiantDao();
        ProjetEtudiantDao projetDao = new ProjetEtudiantDao();
        AffectationProjetDao affectationDao = new AffectationProjetDao();

        
        Etudiant etudiant = new Etudiant("Agourram", "Fatimaezzahra", "agourramfatimaezzahra0@gmail.com", "fati45123", "EE884424");
        etudiantDao.create(etudiant);
        System.out.println("Étudiant créé avec succès");

       
        ProjetEtudiant projet = new ProjetEtudiant("Système de gestion", "Développement d'un système de gestion scolaire", "Prof. Zahid", 2025);
        projetDao.create(projet);
        System.out.println("Projet créé avec succès");

       
        AffectationProjet affectation = new AffectationProjet(etudiant, projet, new Date(), null);
        affectationDao.create(affectation);
        System.out.println("Affectation créée avec succès");

        
        System.out.println("\nListe des affectations:");
        List<AffectationProjet> affectations = affectationDao.findAll();
        for (AffectationProjet a : affectations) {
            System.out.println("- " + a.getEtudiant().getNom() + " " + a.getEtudiant().getPrenom() + " -> " + a.getProjet().getTitre());
        }

        
        affectation.setDateFin(new Date()); 
        if (affectationDao.update(affectation)) {
            System.out.println("Affectation mise à jour avec succès");
        } else {
            System.out.println("Échec de la mise à jour de l'affectation");
        }

        
        // Delete the AffectationProjet
        if (affectationDao.delete(affectation)) {
            System.out.println("Affectation supprimée avec succès");
        } else {
            System.out.println("Échec de la suppression de l'affectation");
        }

        
        affectations = affectationDao.findAll();
        System.out.println("\nListe des affectations après suppression:");
        if (affectations.isEmpty()) {
            System.out.println("Aucune affectation trouvée.");
        } else {
            for (AffectationProjet a : affectations) {
                System.out.println("- " + a.getEtudiant().getNom() + " " + a.getEtudiant().getPrenom() + " -> " + a.getProjet().getTitre());
            }
        }
               */
    }
}