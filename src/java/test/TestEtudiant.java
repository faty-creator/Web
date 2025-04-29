package test;

import dao.EtudiantDao;
import entities.Etudiant;

import java.util.List;

public class TestEtudiant {
    public static void main(String[] args) {
        EtudiantDao dao = new EtudiantDao();

        
        List<Etudiant> etudiants = dao.findAll();
        System.out.println("Etudiants:");
        for (Etudiant e : etudiants) {
            System.out.println(e.getNom() + " " + e.getPrenom() + " - CNE: " + e.getCne());
        }
    }
}