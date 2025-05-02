<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Accueil - Gestion de projets étudiants</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
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
        
        /* Dashboard Content */
        .dashboard-container {
            padding: 2rem;
        }
        
        .welcome-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.8s ease-out;
        }
        
        .welcome-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 1rem;
        }
        
        .welcome-text {
            color: #6c757d;
            margin-bottom: 1.5rem;
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .stat-card.students {
            border-left-color: var(--primary);
        }
        
        .stat-card.projects {
            border-left-color: var(--secondary);
        }
        
        .stat-card.active {
            border-left-color: var(--success);
        }
        
        .stat-card.completed {
            border-left-color: var(--warning);
        }
        
        .stat-title {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }
        
        .stat-change {
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .stat-change.up {
            color: var(--success);
        }
        
        .stat-change.down {
            color: var(--danger);
        }
        
        .projects-section {
            margin-top: 2rem;
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        
        .project-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .project-image {
            height: 180px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 3rem;
        }
        
        .project-content {
            padding: 1.5rem;
        }
        
        .project-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }
        
        .project-description {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .project-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
        }
        
        .project-status {
            padding: 0.3rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .status-active {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }
        
        .status-completed {
            background: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }
        
        .status-pending {
            background: rgba(108, 117, 125, 0.1);
            color: #6c757d;
        }
        
        .project-members {
            display: flex;
            align-items: center;
        }
        
        .member-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: -10px;
            border: 2px solid white;
        }
        
        .member-avatar:first-child {
            margin-left: 0;
        }
        
        .member-avatar.more {
            background: #e9ecef;
            color: #6c757d;
        }
        
        .view-all {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }
        
        .btn-view-all {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-view-all:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.4);
            color: white;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
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
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .projects-grid {
                grid-template-columns: 1fr;
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
                <div class="menu-title">Navigation</div>

                <a href="tableauBordAdmin.jsp" class="menu-item active">
                    <i class="bi bi-house-door menu-icon"></i>
                    <span class="menu-text">Tableau de bord</span>
                    <i class="bi bi-chevron-right menu-arrow"></i>
                </a>

                <a href="list.jsp" class="menu-item">
                    <i class="bi bi-people-fill menu-icon"></i>
                    <span class="menu-text">Gestion des Étudiants</span>
                    <i class="bi bi-chevron-right menu-arrow"></i>
                </a>

                <a href="affectation.jsp" class="menu-item">
                    <i class="bi bi-kanban-fill menu-icon"></i>
                    <span class="menu-text">Affectation des Projets</span>
                    <i class="bi bi-chevron-right menu-arrow"></i>
                </a>

                <div class="menu-title">Autres</div>



                <a href="../statistique/statistique.jsp" class="menu-item">
                    <i class="bi bi-graph-up menu-icon"></i>
                    <span class="menu-text">Statistiques</span>
                    <i class="bi bi-chevron-right menu-arrow"></i>
                </a>



                <a href="Authentification.jsp" class="menu-item">
                    <i class="bi bi-box-arrow-right menu-icon"></i>
                    <span class="menu-text">Déconnexion</span>
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
            <h1 class="page-title">Tableau de bord</h1>
            <div class="user-profile">
                <div class="user-avatar">AD</div>
            </div>
        </header>
        
        <div class="dashboard-container">
            <!-- Welcome Card -->
            <div class="welcome-card">
                <h1 class="welcome-title">Bienvenue sur la plateforme de gestion de projets étudiants</h1>
                <p class="welcome-text">
                    Gérez efficacement les projets de vos étudiants, suivez leur progression et facilitez la collaboration entre les différents acteurs.
                </p>
                <a href="affectation.jsp" class="btn btn-primary">
                    <i class="bi bi-kanban-fill me-2"></i>Voir les projets
                </a>
            </div>
            
            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card students">
                    <div class="stat-title">
                        <i class="bi bi-people-fill"></i> Étudiants
                    </div>
                    <div class="stat-value">142</div>
                    <div class="stat-change up">
                        <i class="bi bi-arrow-up"></i> 12% ce mois-ci
                    </div>
                </div>
                
                <div class="stat-card projects">
                    <div class="stat-title">
                        <i class="bi bi-kanban-fill"></i> Projets
                    </div>
                    <div class="stat-value">56</div>
                    <div class="stat-change up">
                        <i class="bi bi-arrow-up"></i> 8% ce mois-ci
                    </div>
                </div>
                
                <div class="stat-card active">
                    <div class="stat-title">
                        <i class="bi bi-clock-history"></i> Actifs
                    </div>
                    <div class="stat-value">38</div>
                    <div class="stat-change up">
                        <i class="bi bi-arrow-up"></i> 5% ce mois-ci
                    </div>
                </div>
                
                <div class="stat-card completed">
                    <div class="stat-title">
                        <i class="bi bi-check-circle-fill"></i> Terminés
                    </div>
                    <div class="stat-value">18</div>
                    <div class="stat-change down">
                        <i class="bi bi-arrow-down"></i> 2% ce mois-ci
                    </div>
                </div>
            </div>
            
            <!-- Projects Section -->
            <div class="projects-section">
                <h2 class="section-title">
                    <i class="bi bi-kanban-fill"></i> Projets récents
                </h2>
                
                <div class="projects-grid">
                    <!-- Project Card 1 -->
                    <div class="project-card animate__animated animate__fadeIn">
                        <div class="project-image">
                            <i class="bi bi-code-slash"></i>
                        </div>
                        <div class="project-content">
                            <h3 class="project-title">Système de gestion académique</h3>
                            <p class="project-description">
                                Développement d'une plateforme web pour la gestion des notes, absences et emplois du temps des étudiants.
                            </p>
                            <div class="project-meta">
                                <span class="project-status status-active">En cours</span>
                                <div class="project-members">
                                    <div class="member-avatar">AB</div>
                                    <div class="member-avatar">CD</div>
                                    <div class="member-avatar">EF</div>
                                    <div class="member-avatar more">+3</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Project Card 2 -->
                    <div class="project-card animate__animated animate__fadeIn">
                        <div class="project-image">
                            <i class="bi bi-phone"></i>
                        </div>
                        <div class="project-content">
                            <h3 class="project-title">Application mobile de bibliothèque</h3>
                            <p class="project-description">
                                Conception d'une application mobile permettant la recherche, la réservation et la gestion des emprunts de livres.
                            </p>
                            <div class="project-meta">
                                <span class="project-status status-active">En cours</span>
                                <div class="project-members">
                                    <div class="member-avatar">GH</div>
                                    <div class="member-avatar">IJ</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Project Card 3 -->
                    <div class="project-card animate__animated animate__fadeIn">
                        <div class="project-image">
                            <i class="bi bi-robot"></i>
                        </div>
                        <div class="project-content">
                            <h3 class="project-title">Système de recommandation IA</h3>
                            <p class="project-description">
                                Mise en place d'un algorithme de recommandation de cours basé sur les compétences et intérêts des étudiants.
                            </p>
                            <div class="project-meta">
                                <span class="project-status status-completed">Terminé</span>
                                <div class="project-members">
                                    <div class="member-avatar">KL</div>
                                    <div class="member-avatar">MN</div>
                                    <div class="member-avatar">OP</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="view-all">
                    <a href="affectation.jsp" class="btn btn-view-all">
                        <i class="bi bi-kanban-fill me-2"></i>Voir tous les projets
                    </a>
                </div>
            </div>
        </div>
    </div>

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
    </script>
</body>
</html>