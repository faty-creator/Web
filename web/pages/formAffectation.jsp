<%@page import="java.util.List"%>
<%@page import="entities.Etudiant"%>
<%@page import="entities.ProjetEtudiant"%>
<%@page import="services.EtudiantService"%>
<%@page import="services.ProjetEtudiantService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // Vérification de la session admin
    if (session.getAttribute("id") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../pages/Authentification.jsp");
        return;
    }
    
    // Récupérer la liste des étudiants et projets
    EtudiantService es = new EtudiantService();
    ProjetEtudiantService ps = new ProjetEtudiantService();
    List<Etudiant> etudiants = es.findAll();
    List<ProjetEtudiant> projets = ps.findAll();
    
    request.setAttribute("etudiants", etudiants);
    request.setAttribute("projets", projets);
    
    String nom = (String) session.getAttribute("nom");
    String prenom = (String) session.getAttribute("prenom");
%>
<!DOCTYPE html>
<html>
<head>
    <title>${empty affectation ? 'Ajouter' : 'Modifier'} Affectation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

        /* Sidebar Styles */
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
        }
        
        .menu-item {
            display: flex;
            align-items: center;
            padding: 0.85rem 1.5rem;
            margin: 0.25rem 0;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
        }
        
        .menu-item.active {
            background: rgba(255, 255, 255, 0.15);
        }
        
        .menu-icon {
            font-size: 1.25rem;
            margin-right: 1rem;
        }
        
        .sidebar.collapsed .menu-icon {
            margin-right: 0;
            font-size: 1.4rem;
        }
        
        .menu-text {
            transition: all 0.3s ease;
        }
        
        .sidebar.collapsed .menu-text {
            display: none;
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
        
        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1);
            min-height: 100vh;
        }
        
        .admin-header {
            height: var(--header-height);
            background: white;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
        }
        
        .page-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-dark);
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

        /* Form Styles */
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .form-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }
        
        .form-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }
        
        .form-title {
            margin: 0;
            font-size: 1.75rem;
            font-weight: 700;
        }
        
        .form-body {
            padding: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--primary-dark);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            outline: none;
        }
        
        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 16px 12px;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            border: none;
        }
        
        /* Alert messages */
        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .alert-danger {
            background-color: rgba(249, 65, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(249, 65, 68, 0.3);
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
            
            .form-row {
                flex-direction: column;
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
            <a href="tableauBordAdmin.jsp" class="menu-item">
                <i class="bi bi-house-door menu-icon"></i>
                <span class="menu-text">Tableau de bord</span>
            </a>
            <a href="list.jsp" class="menu-item">
                <i class="bi bi-people-fill menu-icon"></i>
                <span class="menu-text">Gestion Étudiants</span>
            </a>
            <a href="affectation.jsp" class="menu-item active">
                <i class="bi bi-kanban-fill menu-icon"></i>
                <span class="menu-text">Affectation Projets</span>
            </a>
            
            <div class="menu-title">Autres</div>
            <a href="../statistique/statistique.jsp" class="menu-item">
                <i class="bi bi-graph-up menu-icon"></i>
                <span class="menu-text">Statistiques</span>
            </a>
            <a href="../DeconnexionController" class="menu-item">
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
            <h1 class="page-title">${empty affectation ? 'Ajouter' : 'Modifier'} Affectation</h1>
            <div class="user-profile">
                <div class="user-avatar"><%= prenom.charAt(0) %><%= nom.charAt(0) %></div>
                <span><%= prenom %></span>
            </div>
        </header>
        
        <div class="form-container">
            <div class="form-card">
                <div class="form-header">
                    <h1 class="form-title">${empty affectation ? 'Nouvelle' : 'Modifier'} Affectation</h1>
                </div>
                
                <div class="form-body">
                    <!-- Messages d'erreur -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                            ${error}
                        </div>
                    </c:if>
                    
                   <form action="${pageContext.request.contextPath}/AffectationController" method="POST">
    <input type="hidden" name="op" value="${empty affectation ? 'add' : 'update'}">
    
    <div class="form-group">
        <label class="form-label">Étudiant</label>
        <select name="etudiant" class="form-control" required>
            <option value="">Sélectionner un étudiant</option>
            <c:forEach items="${etudiants}" var="etudiant">
                <option value="${etudiant.id}" 
                    ${not empty affectation && affectation.etudiant.id == etudiant.id ? 'selected' : ''}>
                    ${etudiant.nom} ${etudiant.prenom} (${etudiant.cne})
                </option>
            </c:forEach>
        </select>
    </div>
    
    <div class="form-group">
        <label class="form-label">Projet</label>
        <select name="projet" class="form-control" required>
            <option value="">Sélectionner un projet</option>
            <c:forEach items="${projets}" var="projet">
                <option value="${projet.idPro}" 
                    ${not empty affectation && affectation.projet.idPro == projet.idPro ? 'selected' : ''}>
                    ${projet.titre} - ${projet.description}
                </option>
            </c:forEach>
        </select>
    </div>
    
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label class="form-label">Date de début</label>
                <input type="date" name="dateDebut" class="form-control" 
                       value="${not empty affectation ? affectation.dateDebut : ''}" required>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="form-label">Date de fin (optionnel)</label>
                <input type="date" name="dateFin" class="form-control" 
                       value="${not empty affectation ? affectation.dateFin : ''}">
            </div>
        </div>
    </div>
    
    <div class="d-flex justify-content-end mt-4">
        <a href="affectation.jsp" class="btn btn-secondary me-2">
            <i class="bi bi-arrow-left"></i> Annuler
        </a>
        <button type="submit" class="btn btn-primary">
            <i class="bi bi-save"></i> ${empty affectation ? 'Créer' : 'Mettre à jour'}
        </button>
    </div>
</form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
         document.querySelector('form').addEventListener('submit', function(e) {
        const etudiant = document.querySelector('select[name="etudiant"]').value;
        const projet = document.querySelector('select[name="projet"]').value;
        const dateDebut = document.querySelector('input[name="dateDebut"]').value;
        
        if (!etudiant || !projet || !dateDebut) {
            e.preventDefault();
            alert('Veuillez remplir tous les champs obligatoires');
        }
        
        console.log('Soumission du formulaire avec:',  {
            etudiant,
            projet,
            dateDebut,
            dateFin: document.querySelector('input[name="dateFin"]').value,
            op: document.querySelector('input[name="op"]').value
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        var form = document.querySelector('form');
        
        form.addEventListener('submit', function(e) {
            // Vérifiez que tous les champs requis sont remplis
            var etudiant = document.querySelector('select[name="etudiant"]').value;
            var projet = document.querySelector('select[name="projet"]').value;
            var dateDebut = document.querySelector('input[name="dateDebut"]').value;
            
            if (!etudiant || !projet || !dateDebut) {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires');
                return false;
            }
            
            console.log('Soumission du formulaire:');
            console.log('Action:', form.action);
            console.log('Méthode:', form.method);
            console.log('Étudiant:', etudiant);
            console.log('Projet:', projet);
            console.log('Date début:', dateDebut);
            console.log('Date fin:', document.querySelector('input[name="dateFin"]').value);
            console.log('Opération:', document.querySelector('input[name="op"]').value);
        });
    });
    </script>
</body>
</html>