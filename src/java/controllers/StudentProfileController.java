package controllers;

import dao.ProjetEtudiantDao;
import entities.AffectationProjet;
import entities.Etudiant;
import entities.ProjetEtudiant;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import entities.User;
import java.util.ArrayList;

@WebServlet(name = "studentProfileController", urlPatterns = {"/studentProfileController"})
public class StudentProfileController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Etudiant et = (Etudiant) session.getAttribute("etudiant");

        if (et != null) {
            ProjetEtudiantDao projetdao = new ProjetEtudiantDao();
            List<ProjetEtudiant> projets = new ArrayList<>();
            for (AffectationProjet affectation : et.getAffectations()) {
                projets.add(affectation.getProjet());
            }
            request.setAttribute("Projets", projets);
            request.getRequestDispatcher("profil.jsp").forward(request, response);
        } else {
            response.sendRedirect("Authentification.jsp?msg=Session expirée");
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
