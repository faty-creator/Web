package controllers;

import entities.ProjetEtudiant;
import services.ProjetEtudiantService;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "addProjet", urlPatterns = {"/addProjet"})
public class addProjet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ProjetEtudiantService projetService = new ProjetEtudiantService();

        String op = request.getParameter("op");

        if (op == null) {
            // Cas création ou mise à jour
            String id = request.getParameter("id");
            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String encadrent = request.getParameter("encadrent");
            String anneeStr = request.getParameter("annee");

            if (id == null || id.isEmpty()) {
                // Création
                if (titre != null && !titre.trim().isEmpty() && anneeStr != null && !anneeStr.trim().isEmpty()) {
                    int annee = Integer.parseInt(anneeStr);
                    ProjetEtudiant projet = new ProjetEtudiant(titre, description, encadrent, annee);
                    projetService.create(projet);
                }
            } else {
                // Mise à jour
                int projetId = Integer.parseInt(id);
                ProjetEtudiant projet = projetService.findById(projetId);
                if (projet != null) {
                    projet.setTitre(titre);
                    projet.setDescription(description);
                    projet.setEncadrent(encadrent);
                    projet.setAnnee(Integer.parseInt(anneeStr));
                    projetService.update(projet);
                }
            }

            response.sendRedirect("pages/affectation.jsp");

        } else if (op.equals("delete")) {
            // Suppression
            String id = request.getParameter("id");
            int projetId = Integer.parseInt(id);

            ProjetEtudiant projet = projetService.findById(projetId);
            if (projet != null) {
                projetService.delete(projet);
            }

            response.sendRedirect("pages/affectation.jsp");

        } else if (op.equals("update")) {
            // Préparer la mise à jour
            String id = request.getParameter("id");
            int projetId = Integer.parseInt(id);

            ProjetEtudiant projet = projetService.findById(projetId);
            if (projet != null) {
                response.sendRedirect("pages/affectation.jsp?id=" + projet.getIdPro()
                        + "&titre=" + projet.getTitre()
                        + "&description=" + projet.getDescription()
                        + "&encadrent=" + projet.getEncadrent()
                        + "&annee=" + projet.getAnnee());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Gestion des projets étudiants";
    }
} 