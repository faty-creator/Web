package test;

import dao.AffectationProjetDao;
import dao.EtudiantDao;
import dao.ProjetEtudiantDao;
import entities.AffectationProjet;
import entities.Etudiant;
import entities.ProjetEtudiant;
import util.HibernateUtil;

import java.util.Date;
import java.util.List;

public class TestAffectationProjet {
    public static void main(String[] args) {
        HibernateUtil.getSessionFactory();
        AffectationProjetDao affectationDao = new AffectationProjetDao();
        EtudiantDao etudiantDao = new EtudiantDao();
        ProjetEtudiantDao projetDao = new ProjetEtudiantDao();

        Etudiant etudiant = new Etudiant("zidane", "hiba", "hiba@example.com", "12345678", "CNE123");
        etudiantDao.create(etudiant);

ProjetEtudiant projet = new ProjetEtudiant("chatbot", "chatbot intelligent pour l'assistance aux étudiants", "Prof. Stitini", 2025);        projetDao.create(projet);

        AffectationProjet affectation = new AffectationProjet(etudiant, projet, new Date(), null);
        affectationDao.create(affectation);

        List<AffectationProjet> affectations = affectationDao.findAll();
        System.out.println("Affectations:");
        for (AffectationProjet a : affectations) {
            System.out.println(a.getEtudiant().getNom() + " -> " + a.getProjet().getTitre());
        }

        int etudiantId = etudiant.getId();
        int projetId = projet.getIdPro();

        System.out.println("ID Étudiant: " + etudiantId);
        System.out.println("ID Projet: " + projetId);

        AffectationProjet retrievedAffectation = affectationDao.findByEtudiantAndProjet(etudiantId, projetId);

        if (retrievedAffectation != null) {
            System.out.println("Affectation récupérée: " + retrievedAffectation.getEtudiant().getNom() + " -> " + retrievedAffectation.getProjet().getTitre());
        } else {
            System.out.println("Affectation non trouvée.");
        }
    }
}