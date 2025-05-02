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

        // Création des étudiants
        Etudiant e1 = new Etudiant("Zidane", "Hiba", "hiba@example.com", "12345678", "CNE123");
        Etudiant e2 = new Etudiant("Ahmed", "Ali", "ahmed@example.com", "23456789", "CNE234");
        Etudiant e3 = new Etudiant("Fatima", "Zahra", "fatima@example.com", "34567890", "CNE345");
        Etudiant e4 = new Etudiant("Mohamed", "Kamal", "mohamed@example.com", "45678901", "CNE456");
        Etudiant e5 = new Etudiant("Salma", "Youssef", "salma@example.com", "56789012", "CNE567");

        etudiantDao.create(e1);
        etudiantDao.create(e2);
        etudiantDao.create(e3);
        etudiantDao.create(e4);
        etudiantDao.create(e5);

        // Création des projets
        ProjetEtudiant p1 = new ProjetEtudiant("Chatbot", "Chatbot intelligent pour l'assistance", "Prof. Stitini", 2025);
        ProjetEtudiant p2 = new ProjetEtudiant("E-Learning", "Plateforme d'apprentissage en ligne", "Dr. Naji", 2025);
        ProjetEtudiant p3 = new ProjetEtudiant("Analyse des sentiments", "Projet d'analyse des avis étudiants", "Prof. Latifa", 2025);
        ProjetEtudiant p4 = new ProjetEtudiant("Gestion de notes", "Système de gestion des notes des étudiants", "Dr. El Amrani", 2025);
        ProjetEtudiant p5 = new ProjetEtudiant("Planification des cours", "Outil pour planifier les cours", "Prof. Adil", 2025);

        projetDao.create(p1);
        projetDao.create(p2);
        projetDao.create(p3);
        projetDao.create(p4);
        projetDao.create(p5);

        // Affectations
        affectationDao.create(new AffectationProjet(e1, p1, new Date(), null));
        affectationDao.create(new AffectationProjet(e2, p2, new Date(), null));
        affectationDao.create(new AffectationProjet(e3, p3, new Date(), null));
        affectationDao.create(new AffectationProjet(e4, p3, new Date(), null)); // projet p3 a 2 étudiants
        affectationDao.create(new AffectationProjet(e5, p4, new Date(), null));

        // Affichage pour vérification
        List<AffectationProjet> affectations = affectationDao.findAll();
        System.out.println("Affectations:");
        for (AffectationProjet a : affectations) {
            System.out.println(a.getEtudiant().getNom() + " -> " + a.getProjet().getTitre());
        }
    }
}
