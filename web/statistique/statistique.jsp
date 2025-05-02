<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Etudiant"%>
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
    <title>Statistiques des Projets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
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

        /* Charts Container */
        .dashboard-container {
            padding: 2rem;
        }
        
        .charts-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 30px;
            margin-top: 20px;
        }
        
        .chart-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(0, 0, 0, 0.08);
        }
        
        .chart-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .chart-title {
            text-align: center;
            margin-bottom: 25px;
            color: var(--primary-dark);
            font-size: 1.3rem;
            font-weight: 600;
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .chart-title:after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 3px;
        }
        
        .chart-wrapper {
            position: relative;
            height: 350px;
            width: 100%;
        }
        
        .alert-modern {
            border-radius: 16px;
            padding: 18px 25px;
            margin-bottom: 30px;
            border: none;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            font-weight: 500;
            display: flex;
            align-items: center;
        }
        
        .alert-modern i {
            margin-right: 12px;
            font-size: 1.2rem;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .menu-item {
            animation: slideIn 0.4s ease-out forwards;
        }

        .menu-item:nth-child(1) { animation-delay: 0.1s; }
        .menu-item:nth-child(2) { animation-delay: 0.2s; }
        .menu-item:nth-child(3) { animation-delay: 0.3s; }
        .menu-item:nth-child(4) { animation-delay: 0.4s; }
        .menu-item:nth-child(5) { animation-delay: 0.5s; }
        .menu-item:nth-child(6) { animation-delay: 0.6s; }
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
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>

            <a href="list.jsp" class="menu-item">
                <i class="bi bi-people-fill menu-icon"></i>
                <span class="menu-text">Gestion Étudiants</span>
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>

            <a href="affectation.jsp" class="menu-item">
                <i class="bi bi-kanban-fill menu-icon"></i>
                <span class="menu-text">Affectation Projets</span>
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>

            <div class="menu-title">Autres</div>

            <a href="../statistique/statistique.jsp" class="menu-item active">
                <i class="bi bi-graph-up menu-icon"></i>
                <span class="menu-text">Statistiques</span>
                <i class="bi bi-chevron-right menu-arrow"></i>
            </a>

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
        <header class="admin-header">
            <h1 class="page-title" id="pageTitle">Statistiques des Projets</h1>
            <div class="user-profile">
                <div class="user-avatar"><%= prenom.charAt(0) %><%= nom.charAt(0) %></div>
                <span><%= prenom %></span>
            </div>
        </header>
        
        <div class="dashboard-container">
            <div class="alert alert-danger alert-modern" style="display:none;" id="error-alert">
                <i class="bi bi-exclamation-circle"></i>
                <span id="error-message"></span>
            </div>
            
            <div class="charts-container">
                <!-- Bar Chart Card -->
                <div class="chart-card">
                    <h2 class="chart-title">Participation aux Projets</h2>
                    <div class="chart-wrapper">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>
                
                <!-- Line Chart Card -->
                <div class="chart-card">
                    <h2 class="chart-title">Tendance de Participation</h2>
                    <div class="chart-wrapper">
                        <canvas id="lineChart"></canvas>
                    </div>
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
        
        // Update page title based on active menu item
        document.querySelectorAll('.menu-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
                document.getElementById('pageTitle').textContent = this.querySelector('.menu-text').textContent;
            });
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
        
        // Load data from your controller
        document.addEventListener('DOMContentLoaded', () => {
            fetch('${pageContext.request.contextPath}/ProjetParEtudiantController')
                .then(response => {
                    if (!response.ok) throw new Error(`Erreur HTTP! Statut: ${response.status}`);
                    return response.json();
                })
                .then(data => {
                    console.log("Données reçues:", data);
                    
                    if (!data || data.length === 0) {
                        throw new Error("Aucune donnée disponible");
                    }

                    const labels = data.map(item => item.projet || "Projet sans nom");
                    const values = data.map(item => item.etudiantCount || 0);
                    
                    createBarChart(labels, values);
                    createLineChart(labels, values);
                })
                .catch(err => {
                    console.error('Erreur:', err);
                    const errorMsg = document.getElementById('error-message');
                    errorMsg.textContent = `Erreur: ${err.message}`;
                    document.getElementById('error-alert').style.display = 'flex';
                    
                    // Affichez un graphique vide en cas d'erreur
                    createBarChart([], []);
                    createLineChart([], []);
                });
        });

        function createBarChart(labels, values) {
            const ctx = document.getElementById('barChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Nombre d\'étudiants',
                        data: values,
                        backgroundColor: 'rgba(67, 97, 238, 0.7)',
                        borderColor: 'rgba(67, 97, 238, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Nombre d\'étudiants'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Projets'
                            }
                        }
                    }
                }
            });
        }

        function createLineChart(labels, values) {
            const ctx = document.getElementById('lineChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Nombre d\'étudiants',
                        data: values,
                        fill: false,
                        borderColor: 'rgba(247, 37, 133, 1)',
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Nombre d\'étudiants'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Projets'
                            }
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>