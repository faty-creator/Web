package controllers;

import entities.ProjetEtudiant;
import entities.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.ProjetEtudiantService;
import services.UserService;

/**
 *
 * @author pc
 */
@WebServlet(name = "Route", urlPatterns = {"/Route"})
public class Route extends HttpServlet {

    ProjetEtudiantService pes = new ProjetEtudiantService();
    UserService us = new UserService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String page = request.getParameter("page");

        if (page != null) {
            switch (page) {
                case "form":
                    request.getRequestDispatcher("pages/form.jsp").forward(request, response);
                    break;
                case "list":
                    List<User> users = us.findAll();
                    request.setAttribute("users", users);
                    request.getRequestDispatcher("pages/list.jsp").forward(request, response);
                    break;
                case "formAffectation":
                    request.getRequestDispatcher("pages/formAffectation.jsp").forward(request, response);
                    break;
                case "dashboard":
                    request.getRequestDispatcher("pages/dashboard.jsp").forward(request, response);
                    break;

                case "dashboardEtudiant":
                    request.getRequestDispatcher("pages/dashboardEtudiant.jsp").forward(request, response);
                    break;
                case "etudiantProfile":
                    request.getRequestDispatcher("pages/etudiantProfile.jsp").forward(request, response);
                    break;
                case "Authentification":
                    request.getRequestDispatcher("pages/Authentification.jsp").forward(request, response);
                    break;
                case "affectation":
                    request.getRequestDispatcher("pages/affectation.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } else {
            response.sendRedirect("error.jsp");
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
        return "Route servlet that handles different page redirections.";
    }
}
