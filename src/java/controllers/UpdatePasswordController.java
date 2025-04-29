package controllers;

import entities.Etudiant;
import entities.User;  // Assuming User is the base class for Client
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.EtudiantService;
import services.UserService;  // Change this if using a ClientService
import util.Util;

/**
 * UpdatePasswordController for managing password updates.
 *
 * @author hibaa
 */
@WebServlet(name = "UpdatePasswordController", urlPatterns = {"/UpdatePasswordController"})
public class UpdatePasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String password = request.getParameter("password");
        String passwordcnf = request.getParameter("passwordcnf");
        EtudiantService et = new EtudiantService();
        if (password.equals(passwordcnf)) {
            HttpSession session = request.getSession();
            Etudiant c = (Etudiant) session.getAttribute("Etudiant");
            c.setpassword(Util.md5(password));
            et.update(c);
            response.sendRedirect("Authentification.jsp?email=" + c.getEmail());
        } else {
            response.sendRedirect("updatemotdepasse.jsp?email=mot de passe incorrect");
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
        return "Controller for updating user password";
    }
}
