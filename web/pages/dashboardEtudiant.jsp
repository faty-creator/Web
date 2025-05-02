<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Vérification de la session étudiant
    if (session.getAttribute("id") == null || !"etudiant".equals(session.getAttribute("role"))) {
        response.sendRedirect("../pages/Authentification.jsp");
        return;
    }
    
    String nom = (String) session.getAttribute("nom");
    String prenom = (String) session.getAttribute("prenom");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord Étudiant</title>
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
            flex-direction: column;
            min-height: 100vh;
            background-color: #f5f7ff;
        }

        .main-content {
            flex: 1;
        }

        /* Header Styles */
        .header {
            height: var(--header-height);
            background: linear-gradient(180deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo-icon {
            color: var(--secondary);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-links a:hover {
            color: var(--success);
            transform: translateY(-2px);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            cursor: pointer;
            position: relative;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background-color: var(--success);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .user-name {
            font-weight: 500;
        }

        .user-profile:hover .user-avatar {
            background-color: var(--secondary);
            transform: scale(1.05);
        }

        /* Profile Dropdown */
        .profile-menu {
            display: none;
            position: absolute;
            top: 60px;
            right: 0;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            min-width: 200px;
            z-index: 1000;
            animation: fadeIn 0.3s ease-out;
        }

        .profile-menu.show {
            display: block;
        }

        .profile-menu a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.25rem;
            color: var(--dark);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .profile-menu a:hover {
            background: var(--light);
            color: var(--primary);
        }

        .profile-menu a i {
            width: 20px;
            text-align: center;
        }

        /* Main Content */
        .content {
            padding: 2rem;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-title i {
            color: var(--secondary);
        }

        .welcome-message {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.6s ease-out;
        }

        .welcome-text {
            font-size: 1.1rem;
            color: var(--dark);
            line-height: 1.6;
        }

        /* Stats Section */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .stat-icon {
            font-size: 1.8rem;
            margin-bottom: 0.75rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin: 0.5rem 0;
        }

        .stat-label {
            color: var(--dark);
            font-size: 0.95rem;
        }

        /* Cards Section */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            padding: 1.25rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card-header i {
            font-size: 1.4rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-text {
            color: var(--dark);
            margin-bottom: 1.25rem;
            line-height: 1.6;
        }

        .card-footer {
            padding: 0 1.5rem 1.5rem;
        }

        .btn-card {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-card:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }

        /* Special Card Headers */
        .card-projects .card-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
        }

        .card-tasks .card-header {
            background: linear-gradient(135deg, var(--success) 0%, #3a86ff 100%);
        }

        .card-documents .card-header {
            background: linear-gradient(135deg, var(--warning) 0%, #f3722c 100%);
        }

        .card-calendar .card-header {
            background: linear-gradient(135deg, var(--danger) 0%, #b5179e 100%);
        }

        .card-teams .card-header {
            background: linear-gradient(135deg, #7209b7 0%, #560bad 100%);
        }

        .card-resources .card-header {
            background: linear-gradient(135deg, #4cc9f0 0%, #4895ef 100%);
        }

        /* Special Card Buttons */
        .card-projects .btn-card {
            background-color: var(--primary);
        }

        .card-tasks .btn-card {
            background-color: var(--success);
        }

        .card-documents .btn-card {
            background-color: var(--warning);
        }

        .card-calendar .btn-card {
            background-color: var(--danger);
        }

        .card-teams .btn-card {
            background-color: #7209b7;
        }

        .card-resources .btn-card {
            background-color: #4cc9f0;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 992px) {
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .header {
                padding: 0 1rem;
            }
            
            .nav-links {
                gap: 1rem;
            }
            
            .user-name {
                display: none;
            }
            
            .stats-container,
            .cards-container {
                grid-template-columns: 1fr;
            }
            
            .content {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="main-content">
        <!-- Header -->
        <header class="header">
            <div class="logo">
                <i class="bi bi-journal-bookmark-fill logo-icon"></i>
                <span>Espace Étudiant</span>
            </div>
            
            <nav class="nav-links">
                <a href="dashboardEtudiant.jsp" class="active">
                    <i class="bi bi-house-door"></i>
                    <span>Accueil</span>
                </a>
                
            </nav>
            
            <div class="user-profile" id="userProfile">
                <div class="user-avatar"><%= prenom.charAt(0) %><%= nom.charAt(0) %></div>
                <span class="user-name"><%= prenom %></span>
                <div class="profile-menu" id="profileMenu">
                    <a href="etudiantProfile.jsp">
                        <i class="bi bi-person"></i>
                        <span>Mon Profil</span>
                    </a>
                    <a href="../DeconnexionController">
                        <i class="bi bi-box-arrow-right"></i>
                        <span>Déconnexion</span>
                    </a>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <div class="content">
            <h1 class="page-title">
                <i class="bi bi-house-door"></i>
                Tableau de Bord
            </h1>
            
            <div class="welcome-message animate__animated animate__fadeIn">
                <p class="welcome-text">
                    Bienvenue <strong><%= prenom %> <%= nom %></strong> dans votre espace étudiant. 
                    Consultez vos projets en cours, vos tâches assignées et les deadlines importantes.
                </p>
            </div>
            
            <!-- Stats Section -->
            <div class="stats-container">
                <div class="stat-card">
                    <i class="bi bi-folder stat-icon" style="color: var(--primary);"></i>
                    <div class="stat-value">3</div>
                    <div class="stat-label">Projets Actifs</div>
                </div>
                
                <div class="stat-card">
                    <i class="bi bi-list-check stat-icon" style="color: var(--success);"></i>
                    <div class="stat-value">5</div>
                    <div class="stat-label">Tâches Assignées</div>
                </div>
                
                <div class="stat-card">
                    <i class="bi bi-calendar-check stat-icon" style="color: var(--warning);"></i>
                    <div class="stat-value">2</div>
                    <div class="stat-label">Deadlines</div>
                </div>
                
                <div class="stat-card">
                    <i class="bi bi-people stat-icon" style="color: var(--secondary);"></i>
                    <div class="stat-value">4</div>
                    <div class="stat-label">Membres d'Équipe</div>
                </div>
            </div>
            
            <!-- Cards Section -->
            <div class="cards-container">
                <!-- Projets en cours -->
                <div class="card card-projects">
                    <div class="card-header">
                        <i class="bi bi-folder"></i>
                        <span>Mes Projets</span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Consultez la liste de vos projets actuellement en développement 
                            avec leurs statuts et deadlines.
                        </p>
                    </div>
                    <div class="card-footer">
                        <button class="btn-card">
                            <i class="bi bi-arrow-right"></i>
                            <span>Voir mes projets</span>
                        </button>
                    </div>
                </div>
                
                <!-- Tâches à faire -->
                <div class="card card-tasks">
                    <div class="card-header">
                        <i class="bi bi-list-check"></i>
                        <span>Mes Tâches</span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Retrouvez ici les tâches qui vous ont été assignées avec 
                            leurs priorités et dates d'échéance.
                        </p>
                    </div>
                    <div class="card-footer">
                        <button class="btn-card">
                            <i class="bi bi-arrow-right"></i>
                            <span>Voir mes tâches</span>
                        </button>
                    </div>
                </div>
                
                <!-- Dépôt de documents -->
                <div class="card card-documents">
                    <div class="card-header">
                        <i class="bi bi-upload"></i>
                        <span>Dépôt de Documents</span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Envoyez vos documents, rapports et livrables pour vos 
                            différents projets universitaires.
                        </p>
                    </div>
                    <div class="card-footer">
                        <button class="btn-card">
                            <i class="bi bi-arrow-right"></i>
                            <span>Déposer un document</span>
                        </button>
                    </div>
                </div>
                
                <!-- Calendrier -->
                <div class="card card-calendar">
                    <div class="card-header">
                        <i class="bi bi-calendar-event"></i>
                        <span>Mon Calendrier</span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Visualisez votre calendrier avec les dates importantes, 
                            réunions et deadlines de projets.
                        </p>
                    </div>
                    <div class="card-footer">
                        <button class="btn-card">
                            <i class="bi bi-arrow-right"></i>
                            <span>Accéder au calendrier</span>
                        </button>
                    </div>
                </div>
                
                <!-- Équipes -->
                <div class="card card-teams">
                    <div class="card-header">
                        <i class="bi bi-people-fill"></i>
                        <span>Mes Équipes</span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Gérez vos équipes de projet, contactez vos collaborateurs 
                            et coordonnez vos travaux.
                        </p>
                    </div>
                    <div class="card-footer">
                        <button class="btn-card">
                            <i class="bi bi-arrow-right"></i>
                            <span>Voir mes équipes</span>
                        </button>
                    </div>
                </div>
                
                <!-- Ressources -->
                <div class="card card-resources">
                    <div class="card-header">
                        <i class="bi bi-collection"></i>
                        <span>Ressources</span>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            Accédez aux ressources pédagogiques, modèles de documents 
                            et guides pour vos projets.
                        </p>
                    </div>
                    <div class="card-footer">
                        <button class="btn-card">
                            <i class="bi bi-arrow-right"></i>
                            <span>Accéder aux ressources</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle profile menu
        document.getElementById('userProfile').addEventListener('click', function(e) {
            e.stopPropagation();
            document.getElementById('profileMenu').classList.toggle('show');
        });
        
        // Close profile menu when clicking outside
        document.addEventListener('click', function() {
            document.getElementById('profileMenu').classList.remove('show');
        });
        
        // Card hover animations
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.1)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.05)';
            });
        });
        
        // Button hover animations
        document.querySelectorAll('.btn-card').forEach(btn => {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            
            btn.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>