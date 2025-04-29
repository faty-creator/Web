//package controllers;
//
//import entities.Etudiant;  // Assurez-vous que cela correspond au package réel de votre entité
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import services.EtudiantService;  // Assurez-vous que cela correspond au package réel de votre service
//
//@WebServlet(name = "StudentController", urlPatterns = {"/StudentController"})
//public class StudentController extends HttpServlet {
//
//    private EtudiantService etudiantService;
//
//    @Override
//    public void init() throws ServletException {
//        super.init();
//        etudiantService = new EtudiantService(); // Initialisation du service Etudiant
//    }
//
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String op = request.getParameter("op");  // Récupère l'opération (create, update, delete)
//        
//        if (op == null) {
//            // Si aucune opération spécifique n'est définie, créer ou modifier un étudiant
//            String id = request.getParameter("id");
//            if (id == null) {
//                // Création d'un nouvel étudiant
//                String cne = request.getParameter("cne");
//                String nom = request.getParameter("nom");
//                String prenom = request.getParameter("prenom");
//                String email = request.getParameter("email");
//                String password = request.getParameter("password");
//                Etudiant etudiant = new Etudiant(nom, prenom, email, password, cne);
//                etudiantService.create(etudiant);  // Création de l'étudiant via le service
//                response.sendRedirect("students/page.jsp");  // Redirection vers la page des étudiants
//            } else {
//                // Mise à jour d'un étudiant existant
//                String cne = request.getParameter("cne");
//                String nom = request.getParameter("nom");
//                String prenom = request.getParameter("prenom");
//                String email = request.getParameter("email");
//                String password = request.getParameter("password");
//                Etudiant etudiant = new Etudiant(nom, prenom, email, password, cne);
//                etudiant.setId(Integer.parseInt(id));  // Affectation de l'ID à l'étudiant
//                etudiantService.update(etudiant);  // Mise à jour via le service
//                response.sendRedirect("students/page.jsp");  // Redirection vers la page des étudiants
//            }
//        } else if (op.equals("delete")) {
//            // Suppression d'un étudiant
//            String id = request.getParameter("id");
//            Etudiant etudiant = etudiantService.findById(Integer.parseInt(id));
//            etudiantService.delete(etudiant);  // Suppression via le service
//            response.sendRedirect("students/page.jsp");  // Redirection vers la page des étudiants
//        } else if (op.equals("update")) {
//            // Affichage des informations d'un étudiant pour modification
//            String id = request.getParameter("id");
//            Etudiant etudiant = etudiantService.findById(Integer.parseInt(id));
//            // Redirection vers la page avec les informations de l'étudiant à modifier
//            response.sendRedirect("students/page.jsp?id=" + etudiant.getId() + 
//                                 "&nom=" + etudiant.getNom() + 
//                                 "&prenom=" + etudiant.getPrenom() + 
//                                 "&email=" + etudiant.getEmail() + 
//                                 "&cne=" + etudiant.getCne());
//        }
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "Student Controller for managing Etudiant operations";
//    }
//}


package controllers;

import entities.Etudiant;
import services.EtudiantService;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "StudentController", urlPatterns = {"/app/etudiants/*"})
public class StudentController extends HttpServlet {

    private EtudiantService etudiantService = new EtudiantService();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            action = "/list";
        }

        try {
            switch (action) {
                case "/list":
                    listStudents(request, response);
                    break;
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/create":
                    createStudent(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateStudent(request, response);
                    break;
                case "/delete":
                    deleteStudent(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("etudiants", etudiantService.findAll());
        request.setAttribute("contentPage", "/WEB-INF/views/etudiant/list.jsp");
        request.getRequestDispatcher("/WEB-INF/views/template.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("contentPage", "/WEB-INF/views/etudiant/form.jsp");
        request.getRequestDispatcher("/WEB-INF/views/template.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Etudiant etudiant = etudiantService.findById(id);
        request.setAttribute("etudiant", etudiant);
        request.setAttribute("contentPage", "/WEB-INF/views/etudiant/form.jsp");
        request.getRequestDispatcher("/WEB-INF/views/template.jsp").forward(request, response);
    }

    private void createStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String cne = request.getParameter("cne");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Etudiant newEtudiant = new Etudiant(nom, prenom, email, password, cne);
        etudiantService.create(newEtudiant);
        response.sendRedirect("list");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String cne = request.getParameter("cne");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Etudiant etudiant = new Etudiant(nom, prenom, email, password, cne);
        etudiant.setId(id);
        etudiantService.update(etudiant);
        response.sendRedirect("list");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        etudiantService.delete(etudiantService.findById(id));
        response.sendRedirect("list");
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