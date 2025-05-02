package controllers;

import com.google.gson.Gson;
import dao.ProjetEtudiantDao;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mapper.ProjetEtudiantCount;

@WebServlet(name = "ProjetParEtudiantController", urlPatterns = {"/ProjetParEtudiantController"})
public class ProjetParEtudiantController extends HttpServlet {

    private final ProjetEtudiantDao dao = new ProjetEtudiantDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Récupérer les résultats de la NamedQuery
        List<Object[]> resultats = dao.countEtudiantsByProjet();

        // 2. Transformer en liste de DTO
        // Dans ProjetParEtudiantController
        List<ProjetEtudiantCount> stats = new ArrayList<>();
        for (Object[] ligne : resultats) {
            String projetName = (String) ligne[0];
            Long count = (Long) ligne[1];
            stats.add(new ProjetEtudiantCount(projetName, count));
        }

        // 3. Sérialiser en JSON
        String json = new Gson().toJson(stats);

        // 4. Envoyer la réponse
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
        return "Statistiques de participation des étudiants aux projets";
    }
}
