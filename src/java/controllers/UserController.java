/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.EtudiantService;
import services.UserService;

/**
 *
 * @author hibaa
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UserService us;

    @Override
    public void init() throws ServletException {
        super.init();
        us = new UserService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        if (op == null) {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String pwd = request.getParameter("pwd");
                us.create(new User(nom, prenom, email, pwd) {});
                response.sendRedirect("Authentification.jsp");
            } else {
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String pwd = request.getParameter("pwd");
                User u = new User(nom, prenom, email, pwd) {};
                u.setId(Integer.parseInt(id));
                us.update(u);
                response.sendRedirect("users.jsp");
            }
        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            us.delete(us.findById(Integer.parseInt(id)));
            response.sendRedirect("users.jsp");
        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            User u = us.findById(Integer.parseInt(id));
            response.sendRedirect("Inscription.jsp?id=" + u.getId() + "&nom=" + u.getNom() + "&prenom=" + u.getPrenom() + "&email=" + u.getEmail() + "&pwd=" + u.getPassword());
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
        return "Short description";
    }

}