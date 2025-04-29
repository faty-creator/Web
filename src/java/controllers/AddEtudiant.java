package controllers;

import entities.Admin;
import entities.Etudiant;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.AdminService;
import services.EtudiantService;

@WebServlet(name = "AddEtudiant", urlPatterns = {"/AddEtudiant"})
public class AddEtudiant extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        EtudiantService etudiantService = new EtudiantService();
        AdminService adminService = new AdminService();

        String op = request.getParameter("op");

        if (op == null) {
            // Cas création ou mise à jour
            String id = request.getParameter("id");
            String cne = request.getParameter("cne");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String password = request.getParameter("mdp");

            if (id == null || id.isEmpty()) {
                // Création
                if (cne != null || !cne.trim().isEmpty()) {
                    // CNE non vide -> Etudiant
                    Etudiant etudiant = new Etudiant(nom, prenom, email, password, cne);
                    etudiantService.create(etudiant);
                }
            } else {
                // Mise à jour
                int userId = Integer.parseInt(id);

                if (cne != null || !cne.trim().isEmpty()) {
                    // CNE non vide -> Etudiant
                    Etudiant etudiant = etudiantService.findById(userId);
                    if (etudiant != null) {
                        etudiant.setNom(nom);
                        etudiant.setPrenom(prenom);
                        etudiant.setEmail(email);
                        etudiant.setpassword(password);
                        etudiant.setCne(cne);
                        etudiant.setId(userId);
                        etudiantService.update(etudiant);
                    }
                }
            }

            response.sendRedirect("pages/list.jsp");

        } else if (op.equals("delete")) {
            // Suppression
            String id = request.getParameter("id");
            int userId = Integer.parseInt(id);

            Etudiant etudiant = etudiantService.findById(userId);
            if (etudiant != null) {
                etudiantService.delete(etudiant);
            } 

            response.sendRedirect("pages/list.jsp");

        } else if (op.equals("update")) {
            // Préparer la mise à jour
            String id = request.getParameter("id");
            int userId = Integer.parseInt(id);

            Etudiant etudiant = etudiantService.findById(userId);
            if (etudiant != null) {
                response.sendRedirect("pages/form.jsp?id=" + etudiant.getId()
                        + "&nom=" + etudiant.getNom()
                        + "&prenom=" + etudiant.getPrenom()
                        + "&email=" + etudiant.getEmail()
                        + "&mdp=" + etudiant.getPassword()
                        + "&cne=" + etudiant.getCne());
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
        return "InscriptionController for Etudiant and Admin registration and management";
    }
}
