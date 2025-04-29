<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projets Étudiants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
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
            padding: 2rem;
        }

        /* Navbar */
        .header {
            height: var(--header-height);
            background: linear-gradient(180deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
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
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--success);
        }

        .user-profile {
            display: flex;
            align-items: center;
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
            transition: background-color 0.3s ease;
        }

        .user-profile:hover .user-avatar {
            background-color: var(--secondary);
        }

        /* Dropdown menu */
        .profile-menu {
            display: none;
            position: absolute;
            top: 60px;
            right: 0;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            overflow: hidden;
            min-width: 150px;
            z-index: 99;
        }

        .profile-menu a {
            display: block;
            padding: 10px 15px;
            color: var(--dark);
            text-decoration: none;
            transition: background 0.3s;
        }

        .profile-menu a:hover {
            background: var(--light);
        }

        .card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .card h3 {
            color: var(--primary-dark);
            margin-bottom: 0.5rem;
        }

        .card p {
            color: var(--dark);
            margin-bottom: 1rem;
        }

        .btn-view {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-view:hover {
            background-color: var(--primary-dark);
        }
    </style>

    <script>
        function toggleMenu() {
            var menu = document.getElementById('profileMenu');
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }
    </script>
</head>
<body>
    <div class="main-content">
        <!-- Navbar -->
        <header class="header">
            <div class="nav-links">
                <a href="../Route?page=dashboardEtudiant">Accueil</a>
                <a href="#">Projets</a>
            </div>
            <div class="user-profile" onclick="toggleMenu()">
                <div class="user-avatar"><i class="bi bi-person"></i></div>
                <div id="profileMenu" class="profile-menu">
                    <a href="../Route?page=etudiantProfile">Mon Profil</a>
                    <a href="../Route?page=Authentification">Déconnexion</a>
                </div>
            </div>
        </header>

        <!-- Contenu des projets -->
        <div class="content">
            <h1 class="page-title">Mes Projets</h1>

            <div class="card">
                <h3>Projet 1</h3>
                <p>Description du projet 1. Ce projet vise à...</p>
                <button class="btn-view">Voir Détails</button>
            </div>

            <div class="card">
                <h3>Projet 2</h3>
                <p>Description du projet 2. Ce projet se concentre sur...</p>
                <button class="btn-view">Voir Détails</button>
            </div>

            <div class="card">
                <h3>Projet 3</h3>
                <p>Description du projet 3. L'objectif de ce projet est...</p>
                <button class="btn-view">Voir Détails</button>
            </div>
        </div>
    </div>
</body>
</html>