package controllers;

import entities.Admin;
import services.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    private AdminService as;

    @Override
    public void init() throws ServletException {
        super.init();
        as = new AdminService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {
            // Créer ou modifier un admin
            String id = request.getParameter("id");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Admin admin = new Admin(nom, prenom, email, password);

            if (id == null || id.isEmpty()) {
                as.create(admin);
            } else {
                admin.setId(Integer.parseInt(id));
                as.update(admin);
            }

            response.sendRedirect("admin/page.jsp");

        } else if (op.equals("delete")) {
            String id = request.getParameter("id");
            as.delete(as.findById(Integer.parseInt(id)));
            response.sendRedirect("admin/page.jsp");

        } else if (op.equals("update")) {
            String id = request.getParameter("id");
            Admin a = as.findById(Integer.parseInt(id));
            response.sendRedirect("admin/page.jsp?id=" + a.getId() + "&nom=" + a.getNom()
                    + "&prenom=" + a.getPrenom() + "&email=" + a.getEmail()
                    + "&password=" + a.getPassword());
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
