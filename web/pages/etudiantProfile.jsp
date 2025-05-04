<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<html>
    <head>
       <title>Profil Étudiant</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
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

            .student-badge {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                animation: fadeIn 0.8s ease-out;
            }

            .sidebar.collapsed .student-badge {
                justify-content: center;
            }

            .student-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(255, 255, 255, 0.2);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.25rem;
            }

            .student-text {
                font-weight: 600;
                font-size: 1.1rem;
            }

            .sidebar.collapsed .student-text {
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

            .student-header {
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

            /* Back Arrow */
            .back-arrow {
                position: absolute;
                top: 1.5rem;
                left: 1.5rem;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: var(--primary);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                z-index: 10;
            }

            .back-arrow:hover {
                background-color: var(--primary-dark);
                transform: translateX(-3px);
            }

            /* Profile Content */
            .profile-container {
                padding: 2rem;
                position: relative;
            }

            .profile-header {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                animation: fadeIn 0.8s ease-out;
                position: relative;
            }

            .profile-pic-container {
                position: relative;
                width: 150px;
                height: 150px;
                margin: 0 auto 1.5rem;
            }

            .profile-pic {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 50%;
                border: 5px solid white;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .edit-profile-btn {
                position: absolute;
                bottom: 10px;
                right: 10px;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: var(--primary);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                border: none;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .edit-profile-btn:hover {
                background: var(--primary-dark);
                transform: scale(1.1);
            }

            .profile-name {
                text-align: center;
                margin-bottom: 1rem;
            }

            .profile-name h2 {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--primary-dark);
                margin-bottom: 0.5rem;
            }

            .profile-name p {
                color: #6c757d;
                font-size: 1.1rem;
            }

            .social-links {
                display: flex;
                justify-content: center;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .social-links a {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: var(--light);
                color: var(--primary);
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .social-links a:hover {
                background: var(--primary);
                color: white;
                transform: translateY(-3px);
            }

            .profile-info {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            }

            .info-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: var(--primary-dark);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .info-item {
                display: flex;
                margin-bottom: 1rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid #eee;
            }

            .info-item:last-child {
                margin-bottom: 0;
                padding-bottom: 0;
                border-bottom: none;
            }

            .info-label {
                flex: 0 0 150px;
                font-weight: 600;
                color: var(--dark);
            }

            .info-value {
                flex: 1;
                color: #6c757d;
            }

            /* Styles pour le formulaire de modification */
            .form-edit {
                display: none;
            }
            
            .form-control-edit {
                background: transparent;
                border: none;
                border-bottom: 1px solid #dee2e6;
                color: #6c757d;
                padding: 0.25rem 0;
                width: 100%;
            }
            
            .form-control-edit:focus {
                outline: none;
                border-color: var(--primary);
            }
            
            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
                margin-top: 1.5rem;
            }

            /* Projects Section */
            .projects-section {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
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

            .project-header {
                padding: 1rem;
                background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
                color: white;
                font-weight: 600;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .project-badge {
                background: white;
                color: var(--primary);
                padding: 0.25rem 0.75rem;
                border-radius: 50px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .project-content {
                padding: 1.5rem;
            }

            .project-description {
                color: #6c757d;
                margin-bottom: 1rem;
            }

            .project-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
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

            .view-details-btn {
                background: var(--primary);
                color: white;
                border: none;
                border-radius: 5px;
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
                transition: all 0.3s ease;
            }

            .view-details-btn:hover {
                background: var(--primary-dark);
            }

            .skills-section {
                margin-top: 2rem;
            }

            .skills-container {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .skill-badge {
                background: var(--light);
                color: var(--primary-dark);
                padding: 0.5rem 1rem;
                border-radius: 50px;
                font-size: 0.85rem;
                transition: all 0.3s ease;
            }

            .skill-badge:hover {
                background: var(--primary);
                color: white;
                transform: translateY(-2px);
            }

            /* Alertes */
            .alert-fixed {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1100;
                max-width: 400px;
                animation: fadeIn 0.3s ease-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Responsive */
            @media (max-width: 992px) {
                .projects-grid {
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

                .projects-grid {
                    grid-template-columns: 1fr;
                }

                .info-item {
                    flex-direction: column;
                }

                .info-label {
                    flex: 1;
                    margin-bottom: 0.5rem;
                }

                .back-arrow {
                    top: 1rem;
                    left: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="student-badge">
                    <div class="student-icon">
                        <i class="bi bi-person-circle"></i>
                    </div>
                    <span class="student-text">Étudiant - <%= prenom.charAt(0)%>.<%= nom%></span>
                </div>
            </div>

            <div class="sidebar-menu">
                <div class="menu-title">Navigation</div>

                <a href="etudiantProfile.jsp" class="menu-item active">
                    <i class="bi bi-person menu-icon"></i>
                    <span class="menu-text">Mon Profil</span>
                    <i class="bi bi-chevron-right menu-arrow"></i>
                </a>
                
                <div class="menu-title">Autres</div>
                <a href="../DeconnexionController" class="menu-item">
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
            <header class="student-header">
                <h1 class="page-title">Mon Profil</h1>
                <div class="user-profile">
                    <div class="user-avatar"><%= prenom.charAt(0)%><%= nom.charAt(0)%></div>
                    <span><%= prenom%></span>
                </div>
            </header>

            <div class="profile-container">
                <!-- Flèche de retour vers l'accueil -->
                <a href="dashboardEtudiant.jsp" class="back-arrow animate__animated animate__fadeIn">
                    <i class="bi bi-arrow-left"></i>
                </a>

                <!-- Container pour les alertes AJAX -->
                <div id="ajaxAlerts" style="position: fixed; top: 20px; right: 20px; z-index: 1100;"></div>
                <!-- Messages d'erreur/succès -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show alert-fixed">
                        <i class="bi bi-check-circle me-2"></i>${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="success" scope="session" />
                </c:if>
                
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show alert-fixed">
                        <i class="bi bi-exclamation-triangle me-2"></i>${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session" />
                </c:if>

                <!-- Profile Header -->
                <div class="profile-header animate__animated animate__fadeIn">
                    <div class="profile-pic-container">
                        <img src="../images/profileEtudiant.jpeg" alt="Photo de profil" class="profile-pic">
                        <button class="edit-profile-btn" onclick="toggleEdit()" title="Modifier le profil">
                            <i class="bi bi-pencil"></i>
                        </button>
                    </div>
                    <div class="profile-name">
                        <h2 id="profileFullName">${etudiant.prenom} ${etudiant.nom}</h2>
                        <p>${etudiant.cne}</p>
                    </div>
                    <div class="social-links">
                        <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                        <a href="#" title="GitHub"><i class="bi bi-github"></i></a>
                        <a href="#" title="Twitter"><i class="bi bi-twitter"></i></a>
                        <a href="#" title="Portfolio"><i class="bi bi-globe2"></i></a>
                    </div>
                </div>

                <!-- Personal Info -->
                <div class="profile-info animate__animated animate__fadeIn">
                    <h3 class="info-title"><i class="bi bi-person-lines-fill"></i> Informations personnelles</h3>
                    
                    <!-- Mode visualisation -->
                    <div id="viewMode">
                        
                        <div class="info-item">
                            <div class="info-label">Nom:</div>
                            <div class="info-value" id="viewNom">${etudiant.nom}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Prénom:</div>
                            <div class="info-value" id="viewPrenom">${etudiant.prenom}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email:</div>
                            <div class="info-value" id="viewEmail">${etudiant.email}</div>
                        </div>
                    </div>
                    
                    <!-- Mode édition -->
                    <form id="editMode" class="form-edit" 
                          action="${pageContext.request.contextPath}/ModifierProfilEtudiantController" 
                          method="POST" 
                          onsubmit="submitForm(event)">
                        <input type="hidden" name="cne" value="${etudiant.cne}">

                        <div class="info-item">
                            <div class="info-label">Nom:</div>
                            <div class="info-value">
                                <input type="text" name="nom" value="${etudiant.nom}" class="form-control-edit" required>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Prénom:</div>
                            <div class="info-value">
                                <input type="text" name="prenom" value="${etudiant.prenom}" class="form-control-edit" required>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email:</div>
                            <div class="info-value">
                                <input type="email" name="email" value="${etudiant.email}" class="form-control-edit" required>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" class="btn btn-outline-secondary" onclick="toggleEdit()">Annuler</button>
                            <button type="submit" class="btn btn-primary" id="submitBtn">Enregistrer</button>
                        </div>
                    </form>
                </div>

                <!-- Projects Section -->
                <div class="projects-section animate__animated animate__fadeIn">
                    <h3 class="section-title"><i class="bi bi-folder"></i> Mes Projets</h3>

                    <c:choose>
                        <c:when test="${not empty Projets}">
                            <div class="projects-grid">
                                <c:forEach items="${Projets}" var="projet">
                                    <div class="project-card">
                                        <div class="project-header">
                                            ${projet.titre}
                                            <span class="project-badge">${projet.annee}</span>
                                        </div>
                                        <div class="project-content">
                                            <p class="project-description">${projet.description}</p>
                                            <div class="project-meta">
                                                <span class="project-status ${projet.statut == 'En cours' ? 'status-active' : projet.statut == 'Terminé' ? 'status-completed' : 'status-pending'}">
                                                    ${projet.statut}
                                                </span>
                                                <button class="view-details-btn">
                                                    <i class="bi bi-arrow-right"></i> Détails
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle"></i> Aucun projet trouvé pour cet étudiant.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Skills Section -->
                <div class="skills-section animate__animated animate__fadeIn">
                    <h3 class="section-title"><i class="bi bi-tools"></i> Mes Compétences</h3>

                    <div class="skills-container">
                        <span class="skill-badge">Java</span>
                        <span class="skill-badge">JEE</span>
                        <span class="skill-badge">Spring Boot</span>
                        <span class="skill-badge">HTML/CSS</span>
                        <span class="skill-badge">JavaScript</span>
                        <span class="skill-badge">SQL</span>
                        <span class="skill-badge">Git</span>
                        <span class="skill-badge">Bootstrap</span>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Toggle sidebar
            document.getElementById('sidebarToggle').addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('collapsed');
            });
            
            // Toggle edit mode
            function toggleEdit() {
                const viewMode = document.getElementById('viewMode');
                const editMode = document.getElementById('editMode');
                
                if (viewMode.style.display === 'none') {
                    viewMode.style.display = 'block';
                    editMode.style.display = 'none';
                } else {
                    viewMode.style.display = 'none';
                    editMode.style.display = 'block';
                }
            }

            // Soumission du formulaire
           function submitForm(event) {
    event.preventDefault();
    
    const submitBtn = document.getElementById('submitBtn');
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Enregistrement...';
    submitBtn.disabled = true;
    
    const form = event.target;
    const formData = new FormData(form);
    
    fetch(form.action, {
        method: 'POST',
        body: new URLSearchParams(formData),
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
    .then(response => {
        if (!response.ok) throw new Error('Erreur réseau');
        return response.json();
    })
    .then(data => {
        console.log("Réponse reçue:", data); // Pour déboguer
        
        if (data.success) {
            // Récupérer les valeurs du formulaire
            const newNom = formData.get('nom');
            const newPrenom = formData.get('prenom');
            const newEmail = formData.get('email');
            
            // Mettre à jour les champs dans la section "Informations personnelles"
            document.getElementById('viewNom').textContent = newNom;
            document.getElementById('viewPrenom').textContent = newPrenom;
            document.getElementById('viewEmail').textContent = newEmail;
            
            // Mettre à jour le header
            document.getElementById('profileFullName').textContent = 
                newPrenom + ' ' + newNom;
                
            // Mise à jour des initiales dans l'avatar
            document.querySelector('.user-avatar').textContent = 
                newPrenom.charAt(0) + newNom.charAt(0);
            document.querySelector('.user-profile span').textContent = newPrenom;
            
            // Mettre à jour les valeurs dans le formulaire aussi
            form.elements['nom'].value = newNom;
            form.elements['prenom'].value = newPrenom;
            form.elements['email'].value = newEmail;
            
            // Afficher un message de succès
            showAlert('success', data.message || 'Profil mis à jour avec succès');
            
            // Revenir au mode visualisation
            toggleEdit();
        } else {
            showAlert('danger', data.message || 'Échec de la mise à jour');
        }
    })
    .catch(error => {
        console.error("Erreur:", error); // Pour déboguer
        showAlert('danger', 'Erreur: ' + error.message);
    })
    .finally(() => {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    });
}

</script>

    </body>
</html>