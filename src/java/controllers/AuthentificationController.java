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

        List<User> users = us.findByEmail(email);

        System.out.println("Email : " + email);
        System.out.println("Password : " + password);

        if (users != null && !users.isEmpty()) {
            User u = users.get(0);
            System.out.println(u.getNom());
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
                        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/dashboard.jsp");
                        dispatcher.forward(request, response);
                        System.out.println(admin.getNom()+" "+admin.getPrenom());
                        return;
                    }
                } catch (Exception e) {
                    System.out.println("Erreur lors de la recherche admin : " + e.getMessage());
                }

                try {
                    Etudiant etudiant = etudiantService.findById(u.getId());
                    if (etudiant != null) {
                        session.setAttribute("role", "etudiant");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/dashboardEtudiant.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                } catch (Exception e) {
                    System.out.println("Erreur lors de la recherche étudiant : " + e.getMessage());
                }

                // Aucun rôle trouvé
                response.sendRedirect("pages/Authentification.jsp?msg=Rôle non reconnu");
            } else {
                // Mot de passe incorrect
                response.sendRedirect("pages/Authentification.jsp?msg=Mot de passe incorrect");
            }
        } else {
            // Email introuvable
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
