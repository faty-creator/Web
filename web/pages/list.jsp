<%@page import="entities.Etudiant"%>
<%@page import="services.EtudiantService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Étudiants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        /* Styles du sidebar - identiques à votre demande */
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
        
        /* Styles existants de list.jsp inchangés */
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
        }
        
        .action-btns {
            display: flex;
            gap: 0.5rem;
        }
        
        .edit-btn, .delete-btn {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .edit-btn {
            background: rgba(255, 193, 7, 0.1);
            color: #d39e00;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }
        
        .edit-btn:hover {
            background: #ffc107;
            color: var(--dark);
            transform: translateY(-2px);
        }
        
        .delete-btn {
            background: rgba(249, 65, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(249, 65, 68, 0.3);
        }
        
        .delete-btn:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .student-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .action-btns {
                flex-direction: column;
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
                <span class="admin-text">Espace Admin</span>
            </div>
        </div>
        
        <div class="sidebar-menu">
            <div class="menu-title">Gestion</div>
            
            <a href="../Route?page=list" class="menu-item active">
                <i class="bi bi-people-fill menu-icon"></i>
                <span class="menu-text">Gestion des Étudiants</span>
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>
            
            <a href="../Route?page=listAffectation" class="menu-item">
                <i class="bi bi-kanban-fill menu-icon"></i>
                <span class="menu-text">Affectation des Projets</span>
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>
            
            <div class="menu-title">Autres</div>
            
            <a href="#" class="menu-item">
                <i class="bi bi-gear-fill menu-icon"></i>
                <span class="menu-text">Paramètres</span>
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>
            
            <button class="toggle-btn" id="sidebarToggle">
                <i class="bi bi-arrow-left-circle-fill"></i>
            </button>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <header class="admin-header">
            <h1 class="page-title">Gestion des Étudiants</h1>
            <div class="user-profile">
                <div class="user-avatar">AD</div>
            </div>
        </header>
        
        <div class="student-container">
            <div class="student-header">
                <h1 class="student-title">Liste des Étudiants</h1>
                <a href="../Route?page=form" class="add-btn">
                    <i class="bi bi-plus-lg"></i> Nouvel Étudiant
                </a>
            </div>
            
            <table class="student-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>CNE</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% EtudiantService es = new EtudiantService();
                            java.util.List<Etudiant> etudiants = es.findAll();
                            if(etudiants != null && !etudiants.isEmpty()) {
                                for(Etudiant e : etudiants){ %>
                    <tr>
                        <td><%= e.getId() %></td>
                        <td><%= e.getCne() %></td>
                        <td><%= e.getNom() %></td>
                        <td><%= e.getPrenom() %></td>
                        <td><%= e.getEmail() %></td>
                        <td>
                            <div class="action-btns">
                                <a href="${pageContext.request.contextPath}/AddEtudiant?id=<%= e.getId() %>&op=update" class="edit-btn">
                                    <i class="bi bi-pencil-square"></i> Modifier
                                </a>
                                <button class="delete-btn" onclick="confirmDelete(<%= e.getId() %>)">
                                    <i class="bi bi-trash"></i> Supprimer
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="empty-message">Aucun étudiant trouvé</td>
                        </tr>
                        <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function confirmDelete(id) {
            if (confirm("Êtes-vous sûr de vouloir supprimer cet étudiant ?")) {
                window.location.href = "${pageContext.request.contextPath}/AddEtudiant?id=" + id + "&op=delete";
            }
        }
        
        // Toggle sidebar
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
        });
        
        // Initialisation DataTable
        document.addEventListener('DOMContentLoaded', function() {
            $('.student-table').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/fr-FR.json'
                },
                responsive: true
            });
        });
    </script>
</body>
</html>