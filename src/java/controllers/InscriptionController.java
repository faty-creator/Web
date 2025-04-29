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

@WebServlet(name = "InscriptionController", urlPatterns = {"/InscriptionController"})
public class InscriptionController extends HttpServlet {

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
                if (cne == null || cne.trim().isEmpty()) {
                    // CNE vide -> Admin
                    Admin admin = new Admin(nom, prenom, email, password);
                    adminService.create(admin);
                } else {
                    // CNE non vide -> Etudiant
                    Etudiant etudiant = new Etudiant(nom, prenom, email, password, cne);
                    etudiantService.create(etudiant);
                }
            } else {
                // Mise à jour
                int userId = Integer.parseInt(id);

                if (cne == null || cne.trim().isEmpty()) {
                    // CNE vide -> Admin
                    Admin admin = adminService.findById(userId);
                    if (admin != null) {
                        admin.setNom(nom);
                        admin.setPrenom(prenom);
                        admin.setEmail(email);
                        admin.setpassword(password);
                        adminService.update(admin);
                    }
                } else {
                    // CNE non vide -> Etudiant
                    Etudiant etudiant = etudiantService.findById(userId);
                    if (etudiant != null) {
                        etudiant.setNom(nom);
                        etudiant.setPrenom(prenom);
                        etudiant.setEmail(email);
                        etudiant.setpassword(password);
                        etudiant.setCne(cne);
                        etudiantService.update(etudiant);
                    }
                }
            }

            response.sendRedirect("pages/Authentification.jsp");

        } else if (op.equals("delete")) {
            // Suppression
            String id = request.getParameter("id");
            int userId = Integer.parseInt(id);

            Etudiant etudiant = etudiantService.findById(userId);
            if (etudiant != null) {
                etudiantService.delete(etudiant);
            } else {
                Admin admin = adminService.findById(userId);
                if (admin != null) {
                    adminService.delete(admin);
                }
            }

            response.sendRedirect("users.jsp");

        } else if (op.equals("update")) {
            // Préparer la mise à jour
            String id = request.getParameter("id");
            int userId = Integer.parseInt(id);

            Etudiant etudiant = etudiantService.findById(userId);
            if (etudiant != null) {
                response.sendRedirect("pages/Authentification.jsp?id=" + etudiant.getId()
                        + "&nom=" + etudiant.getNom()
                        + "&prenom=" + etudiant.getPrenom()
                        + "&email=" + etudiant.getEmail()
                        + "&mdp=" + etudiant.getPassword()
                        + "&cne=" + etudiant.getCne());
            } else {
                Admin admin = adminService.findById(userId);
                if (admin != null) {
                    response.sendRedirect("pages/Authentification.jsp?id=" + admin.getId()
                            + "&nom=" + admin.getNom()
                            + "&prenom=" + admin.getPrenom()
                            + "&email=" + admin.getEmail()
                            + "&mdp=" + admin.getPassword()
                            + "&cne="); // CNE vide pour admin
                }
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
