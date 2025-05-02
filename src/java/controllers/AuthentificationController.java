package controllers;

import entities.Admin;
import entities.Etudiant;
import entities.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.AdminService;
import services.EtudiantService;
import services.UserService;

@WebServlet(name = "AuthentificationController", urlPatterns = {"/AuthentificationController"})
public class AuthentificationController extends HttpServlet {

    private UserService us;
    private AdminService adminService;
    private EtudiantService etudiantService;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
        adminService = new AdminService();
        etudiantService = new EtudiantService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("pages/Authentification.jsp?msg=Veuillez remplir tous les champs");
            return;
        }

        List<User> users = us.findByEmail(email);

        if (users != null && !users.isEmpty()) {
            User u = users.get(0);
            
            if (u.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("id", u.getId());
                session.setAttribute("nom", u.getNom());
                session.setAttribute("prenom", u.getPrenom());
                session.setAttribute("email", u.getEmail());

                try {
                    Admin admin = adminService.findById(u.getId());
                    if (admin != null) {
                        session.setAttribute("role", "admin");
                        response.sendRedirect("pages/tableauBordAdmin.jsp");
                        return;
                    }
                } catch (Exception e) {
                    System.out.println("Erreur admin: " + e.getMessage());
                }

                try {
                    Etudiant etudiant = etudiantService.findById(u.getId());
                    if (etudiant != null) {
                        session.setAttribute("role", "etudiant");
                        session.setAttribute("cne", etudiant.getCne());
                        response.sendRedirect("pages/dashboardEtudiant.jsp");
                        return;
                    }
                } catch (Exception e) {
                    System.out.println("Erreur étudiant: " + e.getMessage());
                }

                response.sendRedirect("pages/Authentification.jsp?msg=Rôle non reconnu");
            } else {
                response.sendRedirect("pages/Authentification.jsp?msg=Mot de passe incorrect");
            }
        } else {
            response.sendRedirect("pages/Authentification.jsp?msg=Email introuvable");
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
}