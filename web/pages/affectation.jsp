<%@page import="java.util.List"%>
<%@page import="entities.AffectationProjet"%>
<%@page import="entities.Etudiant"%>
<%@page import="entities.ProjetEtudiant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // Vérification de la session admin
    if (session.getAttribute("id") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../pages/Authentification.jsp");
        return;
    }
    
    String nom = (String) session.getAttribute("nom");
    String prenom = (String) session.getAttribute("prenom");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Affectation des Projets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a0ca3;
            --secondary: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f94144;
            --warning: #f8961e;
            --sidebar-width: 280px;
            --sidebar-collapsed-width: 80px;
            --header-height: 70px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f5f7ff;
            transition: all 0.3s ease;
        }

        /* Sidebar Styles - Identique à tableauBordAdmin */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(180deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            box-shadow: 5px 0 30px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        
        .sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }
        
        .sidebar-header {
            height: var(--header-height);
            display: flex;
            align-items: center;
            padding: 0 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }
        
        .sidebar.collapsed .sidebar-header {
            justify-content: center;
            padding: 0;
        }
        
        .admin-badge {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: fadeIn 0.8s ease-out;
        }
        
        .sidebar.collapsed .admin-badge {
            justify-content: center;
        }
        
        .admin-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }
        
        .admin-text {
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .sidebar.collapsed .admin-text {
            display: none;
        }
        
        .sidebar-menu {
            padding: 1.5rem 0;
            height: calc(100vh - var(--header-height));
            overflow-y: auto;
            scrollbar-width: thin;
        }
        
        .sidebar-menu::-webkit-scrollbar {
            width: 5px;
        }
        
        .sidebar-menu::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
        }
        
        .menu-title {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0 1.5rem 0.75rem;
            margin-top: 1rem;
            animation: fadeIn 0.8s ease-out;
        }
        
        .sidebar.collapsed .menu-title {
            display: none;
        }
        
        .menu-item {
            display: flex;
            align-items: center;
            padding: 0.85rem 1.5rem;
            margin: 0.25rem 0;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
        }
        
        .menu-item.active {
            background: rgba(255, 255, 255, 0.15);
        }
        
        .menu-item.active:before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: var(--secondary);
        }
        
        .menu-icon {
            font-size: 1.25rem;
            margin-right: 1rem;
            min-width: 24px;
            transition: all 0.3s ease;
        }
        
        .sidebar.collapsed .menu-icon {
            margin-right: 0;
            font-size: 1.4rem;
        }
        
        .menu-text {
            transition: all 0.3s ease;
        }
        
        .sidebar.collapsed .menu-text {
            opacity: 0;
            width: 0;
            height: 0;
            overflow: hidden;
        }
        
        .menu-arrow {
            margin-left: auto;
            transition: transform 0.3s ease;
        }
        
        .sidebar.collapsed .menu-arrow {
            display: none;
        }
        
        .menu-item.active .menu-arrow {
            transform: rotate(90deg);
        }
        
        .toggle-btn {
            position: absolute;
            bottom: 1.5rem;
            right: 1.5rem;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
            border: none;
        }
        
        .toggle-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(180deg);
        }
        
        .sidebar.collapsed .toggle-btn {
            right: 50%;
            transform: translateX(50%);
        }
        
        .sidebar.collapsed .toggle-btn:hover {
            transform: translateX(50%) rotate(180deg);
        }
        
        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            min-height: 100vh;
        }
        
        .sidebar.collapsed ~ .main-content {
            margin-left: var(--sidebar-collapsed-width);
        }
        
        .admin-header {
            height: var(--header-height);
            background: white;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .page-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-dark);
            position: relative;
            padding-left: 1rem;
        }
        
        .page-title:before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            height: 60%;
            width: 4px;
            background: var(--secondary);
            border-radius: 2px;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        /* Student List Styles - Identique à list.jsp */
        .student-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            width: 100%;
        }

        .student-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            animation: fadeIn 0.8s ease-out;
        }

        .student-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-dark);
            position: relative;
            padding-bottom: 0.5rem;
        }

        .student-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--secondary);
            border-radius: 2px;
        }

        .add-btn {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
        }

        .add-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.4);
        }

        .student-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 0.75rem;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            animation: slideUp 0.6s ease-out;
        }

        .student-table thead th {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 1.25rem 1.5rem;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .student-table tbody tr {
            background: white;
            transition: all 0.3s ease;
            border-radius: 10px;
        }

        .student-table tbody tr:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .student-table td {
            padding: 1.25rem 1.5rem;
            vertical-align: middle;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .empty-message {
            text-align: center;
            color: #999;
            font-style: italic;
            padding: 2rem 0;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
            }

            .student-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="admin-badge">
                <div class="admin-icon">
                    <i class="bi bi-shield-lock"></i>
                </div>
                <span class="admin-text">Admin - <%= prenom.charAt(0) %>.<%= nom %></span>
            </div>
        </div>

        <div class="sidebar-menu">
            <div class="menu-title">Navigation</div>

           <a href="${pageContext.request.contextPath}/pages/tableauBordAdmin.jsp" class="menu-item">
    <i class="bi bi-house-door menu-icon"></i>
    <span class="menu-text">Tableau de bord</span>
</a>
<a href="${pageContext.request.contextPath}/pages/list.jsp" class="menu-item">
    <i class="bi bi-people-fill menu-icon"></i>
    <span class="menu-text">Gestion Étudiants</span>
</a>
<a href="${pageContext.request.contextPath}/pages/affectation.jsp" class="menu-item active">
    <i class="bi bi-kanban-fill menu-icon"></i>
    <span class="menu-text">Affectation Projets</span>
</a>
<a href="${pageContext.request.contextPath}/statistique/statistique.jsp" class="menu-item">
    <i class="bi bi-graph-up menu-icon"></i>
    <span class="menu-text">Statistiques</span>
</a>
<a href="${pageContext.request.contextPath}/DeconnexionController" class="menu-item">
    <i class="bi bi-box-arrow-right menu-icon"></i>
    <span class="menu-text">Déconnexion</span>
</a>

            <button class="toggle-btn" id="sidebarToggle">
                <i class="bi bi-arrow-left-circle-fill"></i>
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <header class="admin-header">
            <h1 class="page-title">Affectation des Projets</h1>
            <div class="user-profile">
                <div class="user-avatar"><%= prenom.charAt(0) %><%= nom.charAt(0) %></div>
                <span><%= prenom %></span>
            </div>
        </header>

        <div class="student-container">
            <div class="student-header">
                <h1 class="student-title">Liste des Affectations</h1>
                <a href="formAffectation.jsp" class="add-btn">
                    <i class="bi bi-plus-lg"></i> Nouvelle Affectation
                </a>
            </div>

            <table class="student-table" id="affectationsTable">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Projet</th>
                        <th>Date Début</th>
                        <th>Date Fin</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<AffectationProjet> affectations = (List<AffectationProjet>) request.getAttribute("affectations");
                        if (affectations != null && !affectations.isEmpty()) {
                            for (AffectationProjet aff : affectations) {
                                Etudiant etu = aff.getEtudiant();
                                ProjetEtudiant proj = aff.getProjet();
                    %>
                    <tr>
                        <td><%= etu.getNom()%></td>
                        <td><%= etu.getPrenom()%></td>
                        <td><%= proj.getDescription()%></td>
                        <td><%= aff.getDateDebut()%></td>
                        <td><%= aff.getDateFin()%></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="empty-message">Aucune affectation trouvée.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- jQuery and DataTables -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle sidebar
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
        });
        
        // Animation for menu items on hover
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(5px)';
            });
            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });
        
        // Initialize DataTable
        $(document).ready(function() {
            $('#affectationsTable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json'
                },
                responsive: true
            });
        });
    </script>
</body>
</html>