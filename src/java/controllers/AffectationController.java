package controllers;

import entities.AffectationProjet;
import entities.Etudiant;
import entities.ProjetEtudiant;
import services.AffectationProjetService;
import services.EtudiantService;
import services.ProjetEtudiantService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AffectationController", urlPatterns = {"/AffectationController"})
public class AffectationController extends HttpServlet {
    
    private final AffectationProjetService affectationService = new AffectationProjetService();
    private final EtudiantService etudiantService = new EtudiantService();
    private final ProjetEtudiantService projetService = new ProjetEtudiantService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            // Gestion de la suppression
            if ("delete".equals(action)) {
                int etudiantId = Integer.parseInt(request.getParameter("etudiantId"));
                int projetId = Integer.parseInt(request.getParameter("projetId"));
                
                AffectationProjet affectation = affectationService.findById(etudiantId, projetId);
                if (affectation != null) {
                    affectationService.delete(affectation);
                    request.setAttribute("success", "Affectation supprimée avec succès");
                }
            }
            
            // Chargement des données pour l'affichage
            loadAffectationData(request);
            
            // Redirection vers la page d'affectation
            request.getRequestDispatcher("pages/affectation.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des données: " + e.getMessage());
            request.getRequestDispatcher("pages/affectation.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String op = request.getParameter("op");
        
        try {
            // Log des paramètres pour débogage
            System.out.println("Operation: " + op);
            System.out.println("Etudiant ID: " + request.getParameter("etudiant"));
            System.out.println("Projet ID: " + request.getParameter("projet"));
            System.out.println("Date Début: " + request.getParameter("dateDebut"));
            System.out.println("Date Fin: " + request.getParameter("dateFin"));
            
            // Validation des paramètres
            if (request.getParameter("etudiant") == null || request.getParameter("projet") == null || 
                request.getParameter("dateDebut") == null) {
                throw new IllegalArgumentException("Tous les champs obligatoires doivent être remplis");
            }
            
            int etudiantId = Integer.parseInt(request.getParameter("etudiant"));
            int projetId = Integer.parseInt(request.getParameter("projet"));
            Date dateDebut = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateDebut"));
            
            // Date fin est optionnelle
            Date dateFin = null;
            if (request.getParameter("dateFin") != null && !request.getParameter("dateFin").isEmpty()) {
                dateFin = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dateFin"));
            }
            
            // Récupération des entités
            Etudiant etudiant = etudiantService.findById(etudiantId);
            ProjetEtudiant projet = projetService.findById(projetId);
            
            if (etudiant == null || projet == null) {
                throw new IllegalArgumentException("Étudiant ou projet introuvable");
            }
            
            // Gestion des opérations
            if ("add".equals(op)) {
                AffectationProjet newAffectation = new AffectationProjet(etudiant, projet, dateDebut, dateFin);
                if (affectationService.create(newAffectation)) {
                    request.setAttribute("success", "Affectation créée avec succès");
                } else {
                    throw new Exception("Échec de la création de l'affectation");
                }
            } else if ("update".equals(op)) {
                AffectationProjet existingAffectation = affectationService.findById(etudiantId, projetId);
                if (existingAffectation != null) {
                    existingAffectation.setDateDebut(dateDebut);
                    existingAffectation.setDateFin(dateFin);
                    affectationService.update(existingAffectation);
                    request.setAttribute("success", "Affectation mise à jour avec succès");
                } else {
                    throw new IllegalArgumentException("Affectation introuvable pour mise à jour");
                }
            }
            
            // Rechargement des données après modification
            loadAffectationData(request);
            
            // Redirection vers la page d'affectation
            request.getRequestDispatcher("pages/affectation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            handleError(request, response, "Format de numéro invalide", e);
        } catch (ParseException e) {
            handleError(request, response, "Format de date invalide (utilisez YYYY-MM-DD)", e);
        } catch (IllegalArgumentException e) {
            handleError(request, response, e.getMessage(), e);
        } catch (Exception e) {
            handleError(request, response, "Une erreur s'est produite", e);
        }
    }
    
    private void loadAffectationData(HttpServletRequest request) {
        // Chargement de toutes les affectations
        List<AffectationProjet> affectations = affectationService.findAll();
        request.setAttribute("affectations", affectations);
        
        // Chargement des étudiants et projets (pour les formulaires)
        request.setAttribute("etudiants", etudiantService.findAll());
        request.setAttribute("projets", projetService.findAll());
    }
    
    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                            String message, Exception e) throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("error", message + ": " + e.getMessage());
        
        // Rechargement des données nécessaires pour le formulaire
        loadAffectationData(request);
        
        // Retour vers le formulaire avec le message d'erreur
        if (request.getRequestURI().contains("formAffectation")) {
            request.getRequestDispatcher("pages/formAffectation.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("pages/affectation.jsp").forward(request, response);
        }
    }
}