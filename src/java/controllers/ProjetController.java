//package controllers;
//
//import dao.ProjetEtudiantDao;
//import entities.ProjetEtudiant;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/ProjetServlet")
//public class ProjetServlet extends HttpServlet {
//
//    private ProjetEtudiantDao projetDao;
//
//    @Override
//    public void init() throws ServletException {
//        projetDao = new ProjetEtudiantDao();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        String action = request.getParameter("action");
//
//        if (action == null || action.equals("list")) {
//            listProjets(request, response);
//        } else {
//            response.sendRedirect("error.jsp");
//        }
//    }
//
//    private void listProjets(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            List<ProjetEtudiant> projets = projetDao.findAll();
//            request.setAttribute("projets", projets);
//            request.getRequestDispatcher("listeProjets.jsp").forward(request, response);
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("error.jsp");
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//}


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;
import dao.ProjetEtudiantDao;
import entities.ProjetEtudiant;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author hibaa
 */

@WebServlet(name = "VoitureController", urlPatterns = {"/VoitureController"})
public class ProjetController extends HttpServlet {

    private ProjetEtudiant projetdao;

    @Override
    public void init() throws ServletException {
        projetdao = new ProjetEtudiant();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String projetList = projetdao.getTitre();

        request.setAttribute("liste Projet", projetList);

        request.getRequestDispatcher("/etudiants.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); 
    }
}
