/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

/**
 *
 * @author hibaa
 */
import entities.Etudiant;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import services.EtudiantService;

@WebServlet(name = "VerificationController", urlPatterns = {"/Verfier"})
public class VerificationController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer le code saisi par l'utilisateur
        String code = request.getParameter("code");

        // Récupérer le code de vérification stocké dans la session
        HttpSession session = request.getSession();
        String verificationCode = (String) session.getAttribute("verificationCode");

        // Vérifier si le code saisi par l'utilisateur correspond à celui stocké dans la session
        if (verificationCode != null && verificationCode.equals(code)) {
            // Le code est valide, rediriger vers la page de modification du mot de passe
            response.sendRedirect("updatePassword.jsp");
        } else {
            // Le code est incorrect, rediriger avec un message d'erreur
            response.sendRedirect("verification.jsp?msg=Code de vérification incorrect");
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
        return "Contrôleur de vérification du code de réinitialisation";
    }
}