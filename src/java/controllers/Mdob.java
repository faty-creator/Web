package controllers;

import entities.Etudiant;
import entities.Admin;
import services.EtudiantService;
import services.AdminService;
import services.SendMail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling password recovery by sending a verification code to the user's email.
 */
@WebServlet(name = "Mdob", urlPatterns = {"/Mdob"})
public class Mdob extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        EtudiantService es = new EtudiantService();
        Etudiant e = es.findEtudiantByEmail(email);
        if (e != null) {
            String code = String.format("%06d", (int) (Math.random() * 1000000));

            HttpSession session = request.getSession();
            session.setAttribute("Etudiant", e);
            session.setAttribute("code_verification", code);

            SendMail sed = new SendMail();
            sed.send(code, email);

            response.sendRedirect("verification.jsp");
        } else {
            response.sendRedirect("forgotPassword.jsp?msg=Email n’existe pas");
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
        return "Servlet for handling password recovery and sending verification codes.";
    }
}