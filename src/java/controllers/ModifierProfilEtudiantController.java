package controllers;

import com.google.gson.Gson;
import entities.Etudiant;
import services.EtudiantService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ModifierProfilEtudiantController")
public class ModifierProfilEtudiantController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EtudiantService etudiantService;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        etudiantService = new EtudiantService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Créer un objet pour la réponse JSON
        Map<String, Object> jsonResponse = new HashMap<>();
        
        try {
            HttpSession session = request.getSession();
            String cne = request.getParameter("cne");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");

            // Validation
            if (cne == null || nom == null || prenom == null || email == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Tous les champs sont obligatoires");
                sendJsonResponse(response, jsonResponse);
                return;
            }

            // Mettre à jour l'étudiant
            Etudiant etudiant = etudiantService.findEtudiantByCne(cne);
            if (etudiant != null) {
                etudiant.setNom(nom);
                etudiant.setPrenom(prenom);
                etudiant.setEmail(email);
                
                if (etudiantService.update(etudiant)) {
                    // Mise à jour de la session
                    session.setAttribute("etudiant", etudiant);
                    session.setAttribute("nom", nom);
                    session.setAttribute("prenom", prenom);
                    
                    // Préparer la réponse
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Profil mis à jour avec succès");
                    jsonResponse.put("etudiant", etudiant);
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Échec de la mise à jour");
                }
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Étudiant introuvable");
            }
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Erreur technique: " + e.getMessage());
        }

        sendJsonResponse(response, jsonResponse);
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> data) 
            throws IOException {
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(data));
        out.flush();
    }
}
    // Classe interne pour la réponse JSON
    class JsonResponse {
        boolean success;
        String message;
        Etudiant etudiant;
        
        // Getters nécessaires pour la sérialisation JSON
        public boolean isSuccess() {
            return success;
        }
        
        public String getMessage() {
            return message;
        }
        
        public Etudiant getEtudiant() {
            return etudiant;
        }
    }
