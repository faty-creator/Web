<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .back-arrow {
            margin: 1rem;
            display: inline-block;
            font-size: 1.5rem;
            color: var(--secondary-color);
            text-decoration: none;
        }

        .back-arrow:hover {
            color: var(--accent-color);
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .profile-pic {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .project-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 1.5rem;
            overflow: hidden;
        }

        .project-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .project-card .card-header {
            background-color: var(--primary-color);
            color: white;
            font-weight: bold;
            padding: 1rem;
        }

        .badge-custom {
            background-color: var(--accent-color);
            font-size: 0.8rem;
            padding: 0.35em 0.65em;
        }

        .social-links a {
            color: white;
            font-size: 1.2rem;
            margin: 0 0.5rem;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: var(--accent-color);
        }

        .section-title {
            color: var(--secondary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
            display: inline-block;
        }
        .back-arrow {
    margin: 1rem;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 45px;
    height: 45px;
    font-size: 1.5rem;
    color: white;
    background-color: var(--secondary-color);
    border-radius: 50%;
    text-decoration: none;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    transition: all 0.3s ease;
}

.back-arrow:hover {
    background-color: var(--accent-color);
    transform: scale(1.1);
    color: white;
}

    </style>
</head>
<body>

<!-- Flèche retour -->
<a href="../Route?page=dashboardEtudiant" class="back-arrow" title="Retour"> 
    <i class="fas fa-arrow-left"></i>
</a>

<div class="container py-3">
    <!-- Header du profil -->
    <div class="profile-header text-center">
        <div class="row align-items-center">
            <div class="col-md-2">
                <a href="modifierProfil.jsp" title="Modifier le profil">
                    <img src="https://ui-avatars.com/api/?name=${etudiant.nom}+${etudiant.prenom}&background=random" 
                         alt="Photo de profil" class="profile-pic rounded-circle">
                </a>
            </div>
            <div class="col-md-8">
                <h1 class="display-5 d-inline">${etudiant.prenom} ${etudiant.nom}</h1>
                
                <p class="lead mb-1">${etudiant.cne}</p>
                <p class="mb-3">${etudiant.email}</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                    <a href="#"><i class="fab fa-github"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
            <div class="col-md-2 text-end">
                <a href="modifierProfil.jsp" class="btn btn-outline-light btn-sm" title="Modifier le profil">
                    <i class="fas fa-edit"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- Section des projets -->
    <div class="row">
        <div class="col-12">
            <h3 class="section-title">
                <i class="fas fa-project-diagram me-2"></i>Mes Projets
            </h3>
            
            <c:choose>
                <c:when test="${not empty Projets}">
                    <div class="row">
                        <c:forEach items="${Projets}" var="projet">
                            <div class="col-md-6 col-lg-4">
                                <div class="project-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <span>${projet.titre}</span>
                                        <span class="badge badge-custom">${projet.annee}</span>
                                    </div>
                                    <div class="card-body">
                                        <p class="card-text">${projet.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <i class="fas fa-user-tie me-1"></i> ${projet.encadrent}
                                            </small>
                                            <a href="projetDetails?id=${projet.idPro}" class="btn btn-sm btn-primary">
                                                Voir détails <i class="fas fa-arrow-right ms-1"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i> Aucun projet trouvé pour cet étudiant.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Section des compétences -->
    <div class="row mt-5">
        <div class="col-12">
            <h3 class="section-title">
                <i class="fas fa-code me-2"></i>Compétences
            </h3>
            <div class="d-flex flex-wrap gap-2">
                <span class="badge bg-primary">Java</span>
                <span class="badge bg-primary">JEE</span>
                <span class="badge bg-primary">Spring Boot</span>
                <span class="badge bg-primary">HTML/CSS</span>
                <span class="badge bg-primary">JavaScript</span>
                <span class="badge bg-primary">SQL</span>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Animation pour les cartes de projet
    document.querySelectorAll('.project-card').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.querySelector('.card-header').style.backgroundColor = '#e74c3c';
        });

        card.addEventListener('mouseleave', () => {
            card.querySelector('.card-header').style.backgroundColor = '#3498db';
        });
    });
</script>
</body>
</html>
