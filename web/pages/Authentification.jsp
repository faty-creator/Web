<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Gestion des Projets</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4cc9f0;
            --warning-color: #f8961e;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
        }
        
        .auth-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .auth-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.5s ease;
            background: white;
            animation: fadeIn 0.8s ease-out;
        }
        
        .auth-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .auth-left {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .auth-left::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            animation: pulse 8s infinite linear;
        }
        
        .auth-right {
            padding: 3rem;
        }
        
        .logo-container {
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .app-logo {
            width: 100px;
            height: 100px;
            background: white;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            animation: bounce 2s infinite, float 6s ease-in-out infinite;
            transition: all 0.3s ease;
        }
        
        .app-logo i {
            font-size: 3rem;
            color: var(--primary-color);
            animation: colorChange 8s infinite;
        }
        
        .auth-title {
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            display: inline-block;
            color: var(--primary-color);
        }
        
        .auth-title::after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background: var(--primary-color);
            bottom: -10px;
            left: 25%;
            border-radius: 2px;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }
        
        .btn-auth {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
            color: white;
        }
        
        .btn-auth:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.4);
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
            color: white;
        }
        
        .auth-features {
            margin-top: 2rem;
        }
        
        .auth-features .feature {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.5rem;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .auth-features .feature:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }
        
        .auth-features .feature i {
            margin-right: 10px;
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .auth-divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: #6c757d;
        }
        
        .auth-divider::before,
        .auth-divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #dee2e6;
        }
        
        .auth-divider::before {
            margin-right: 1rem;
        }
        
        .auth-divider::after {
            margin-left: 1rem;
        }
        
        .social-auth .btn {
            border-radius: 10px;
            padding: 10px;
            font-weight: 500;
            margin: 0 5px;
            transition: all 0.3s;
        }
        
        .social-auth .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-google {
            background: #fff;
            color: #db4437;
            border: 1px solid #ddd;
        }
        
        .btn-facebook {
            background: #3b5998;
            color: white;
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 2rem;
            color: #6c757d;
        }
        
        .auth-footer a {
            color: var(--primary-color);
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .auth-footer a:hover {
            color: var(--secondary-color);
            text-decoration: none;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            25% { transform: translateY(-5px) rotate(2deg); }
            75% { transform: translateY(5px) rotate(-2deg); }
        }
        
        @keyframes colorChange {
            0% { color: var(--primary-color); }
            25% { color: var(--secondary-color); }
            50% { color: var(--accent-color); }
            75% { color: var(--success-color); }
            100% { color: var(--primary-color); }
        }
        
        @keyframes pulse {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Responsive adjustments */
        @media (max-width: 992px) {
            .auth-left {
                padding: 2rem;
            }
            .auth-right {
                padding: 2rem;
            }
        }
        
        @media (max-width: 768px) {
            .auth-container {
                padding: 1rem;
            }
            .auth-card {
                flex-direction: column;
            }
            .auth-left, .auth-right {
                padding: 1.5rem;
            }
            
            .app-logo {
                width: 80px;
                height: 80px;
            }
            
            .app-logo i {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container animate__animated animate__fadeIn">
        <div class="auth-card row g-0">
            <!-- Left side with illustration and features -->
            <div class="col-lg-6 auth-left animate__animated animate__fadeInLeft">
                <div class="logo-container">
                    <div class="app-logo">
                        <i class="bi bi-kanban"></i>
                    </div>
                    <h2 class="mt-3 fw-bold">GestionPro</h2>
                    <p class="mb-4">La plateforme ultime pour gérer vos projets académiques</p>
                </div>
                
                <div class="auth-features">
                    <div class="feature animate__animated animate__fadeInUp animate__delay-1s">
                        <i class="bi bi-check-circle"></i>
                        <span>Suivi simplifié de vos projets</span>
                    </div>
                    <div class="feature animate__animated animate__fadeInUp animate__delay-2s">
                        <i class="bi bi-check-circle"></i>
                        <span>Accès à l'historique et aux livrables</span>
                    </div>
                    <div class="feature animate__animated animate__fadeInUp animate__delay-3s">
                        <i class="bi bi-check-circle"></i>
                        <span>Collaboration avec les encadrants</span>
                    </div>
                </div>
            </div>
            
            <!-- Right side with login form -->
            <div class="col-lg-6 auth-right animate__animated animate__fadeInRight">
                <h3 class="auth-title">Connexion</h3>
                
                <form action="${pageContext.request.contextPath}/AuthentificationController" method="POST" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="email" class="form-label">Adresse email</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" placeholder="votre@email.com" required>
                            <div class="invalid-feedback">
                                Veuillez entrer une adresse email valide.
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Mot de passe</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="bi bi-eye"></i>
                            </button>
                            <div class="invalid-feedback">
                                Veuillez entrer votre mot de passe.
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe">
                                Se souvenir de moi
                            </label>
                        </div>
                        <a href="forgot-password.jsp" class="text-decoration-none">Mot de passe oublié ?</a>
                    </div>
                    
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-auth">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Se connecter
                        </button>
                    </div>
                    
                    <div class="auth-divider">OU</div>
                    
                    
                    <div class="auth-footer">
                        Vous n'avez pas de compte ? <a href="inscription.jsp" class="fw-bold">S'inscrire</a>
                    </div>
                    
                    <% if (request.getParameter("msg") != null) { %>
                    <div class="alert alert-danger mt-3 animate__animated animate__shakeX">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><%= request.getParameter("msg") %>
                    </div>
                    <% } %>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Form validation
        (function () {
            'use strict'
            
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.querySelectorAll('.needs-validation')
            
            // Loop over them and prevent submission
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
        
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });
        
        // Add animation to elements when they come into view
        document.addEventListener('DOMContentLoaded', function() {
            const animateElements = document.querySelectorAll('.feature');
            
            animateElements.forEach((element, index) => {
                setTimeout(() => {
                    element.style.opacity = '1';
                }, (index + 1) * 300);
            });
        });
    </script>
</body>
</html>