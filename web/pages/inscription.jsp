<%@page import="entities.User"%>
<%@page import="services.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --error-color: #ef233c;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
        }
        
        .registration-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .registration-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.5s ease;
            background: white;
        }
        
        .registration-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .registration-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .registration-body {
            padding: 3rem;
        }
        
        .registration-title {
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            display: inline-block;
        }
        
        .registration-title:after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background: white;
            bottom: -10px;
            left: 25%;
            border-radius: 2px;
        }
        
        .registration-subtitle {
            font-size: 1rem;
            opacity: 0.9;
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
        
        .btn-register {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
            width: 100%;
            margin-top: 1rem;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.4);
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }
        
        .input-group-text {
            background-color: transparent;
            border-right: none;
        }
        
        .form-floating>.form-control:not(:placeholder-shown)~label {
            color: var(--primary-color);
        }
        
        .password-strength {
            height: 5px;
            background: #e9ecef;
            border-radius: 5px;
            margin-top: 5px;
            overflow: hidden;
        }
        
        .strength-bar {
            height: 100%;
            width: 0;
            background: var(--error-color);
            transition: all 0.3s;
        }
        
        .strength-weak {
            background: #ef233c;
        }
        
        .strength-medium {
            background: #f77f00;
        }
        
        .strength-strong {
            background: #2ec4b6;
        }
        
        .strength-very-strong {
            background: #2ecc71;
        }
        
        .password-hints {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .password-hints ul {
            padding-left: 1.5rem;
            margin-bottom: 0;
        }
        
        .registration-footer {
            text-align: center;
            margin-top: 2rem;
            color: #6c757d;
        }
        
        .registration-footer a {
            color: var(--primary-color);
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .registration-footer a:hover {
            color: var(--secondary-color);
            text-decoration: none;
        }
        
        /* Animation for form elements */
        .form-group {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.5s ease;
        }
        
        .form-group.show {
            opacity: 1;
            transform: translateY(0);
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .registration-container {
                padding: 1rem;
            }
            .registration-body {
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="registration-container animate__animated animate__fadeIn">
        <div class="registration-card">
            <div class="registration-header">
                <h2 class="registration-title animate__animated animate__fadeInDown">Créer un compte</h2>
                <p class="registration-subtitle animate__animated animate__fadeInDown animate__delay-1s">Rejoignez notre communauté dès maintenant</p>
            </div>
            
            <div class="registration-body">
                <form method="POST" action="../InscriptionController" class="needs-validation" novalidate>
                    <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" />
                    
                    <div class="row g-3">
                        <!-- Nom -->
                        <div class="col-md-6 form-group animate__animated animate__fadeIn" style="animation-delay: 0.2s">
                            <label for="nom" class="form-label">Nom</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="nom" name="nom" 
                                       value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : "" %>" 
                                       placeholder="Votre nom" required>
                            </div>
                            <div class="invalid-feedback">
                                Veuillez entrer votre nom.
                            </div>
                        </div>
                        
                        <!-- Prénom -->
                        <div class="col-md-6 form-group animate__animated animate__fadeIn" style="animation-delay: 0.3s">
                            <label for="prenom" class="form-label">Prénom</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="prenom" name="prenom" 
                                       value="<%= request.getParameter("prenom") != null ? request.getParameter("prenom") : "" %>" 
                                       placeholder="Votre prénom" required>
                            </div>
                            <div class="invalid-feedback">
                                Veuillez entrer votre prénom.
                            </div>
                        </div>
                         <!-- cne -->
                        <div class="col-md-6 form-group animate__animated animate__fadeIn" style="animation-delay: 0.3s">
                            <label for="cne" class="form-label">Cne</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="prenom" name="cne" 
                                       value="<%= request.getParameter("cne") != null ? request.getParameter("cne") : "" %>" 
                                       placeholder="Votre cne" >
                            </div>
                            <div class="invalid-feedback">
                                Veuillez entrer votre prénom.
                            </div>
                        </div>
                        
                        <!-- Email -->
                        <div class="col-12 form-group animate__animated animate__fadeIn" style="animation-delay: 0.4s">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" 
                                       placeholder="votre@email.com" required>
                            </div>
                            <div class="invalid-feedback">
                                Veuillez entrer une adresse email valide.
                            </div>
                        </div>
                        
                        <!-- Mot de passe -->
                        <div class="col-12 form-group animate__animated animate__fadeIn" style="animation-delay: 0.5s">
                            <label for="mdp" class="form-label">Mot de passe</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="mdp" name="mdp" 
                                       placeholder="••••••••" required
                                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                                       oninput="checkPasswordStrength(this.value)">
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                            <div class="password-strength mt-2">
                                <div class="strength-bar" id="strengthBar"></div>
                            </div>
                            <div class="password-hints">
                                <small>Le mot de passe doit contenir :</small>
                                <ul>
                                    <li id="lengthHint">Au moins 8 caractères</li>
                                    <li id="uppercaseHint">Une majuscule</li>
                                    <li id="numberHint">Un chiffre</li>
                                </ul>
                            </div>
                            <div class="invalid-feedback">
                                Le mot de passe doit contenir au moins 8 caractères, dont une majuscule et un chiffre.
                            </div>
                        </div>
                        
                        <!-- Bouton d'enregistrement -->
                        <div class="col-12 form-group animate__animated animate__fadeIn" style="animation-delay: 0.6s">
                            <button type="submit" class="btn btn-register">
                                <i class="bi bi-person-plus me-2"></i>S'inscrire
                            </button>
                        </div>
                    </div>
                </form>
                
                <div class="registration-footer animate__animated animate__fadeIn" style="animation-delay: 0.7s">
                    Vous avez déjà un compte ? <a href="Authentification.jsp" class="fw-bold">Se connecter</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
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
            const passwordInput = document.getElementById('mdp');
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
        
        // Password strength checker
        function checkPasswordStrength(password) {
            const strengthBar = document.getElementById('strengthBar');
            const lengthHint = document.getElementById('lengthHint');
            const uppercaseHint = document.getElementById('uppercaseHint');
            const numberHint = document.getElementById('numberHint');
            
            let strength = 0;
            
            // Check length
            if (password.length >= 8) {
                strength += 1;
                lengthHint.style.color = '#2ecc71';
            } else {
                lengthHint.style.color = '#ef233c';
            }
            
            // Check uppercase letters
            if (/[A-Z]/.test(password)) {
                strength += 1;
                uppercaseHint.style.color = '#2ecc71';
            } else {
                uppercaseHint.style.color = '#ef233c';
            }
            
            // Check numbers
            if (/\d/.test(password)) {
                strength += 1;
                numberHint.style.color = '#2ecc71';
            } else {
                numberHint.style.color = '#ef233c';
            }
            
            // Update strength bar
            switch(strength) {
                case 0:
                    strengthBar.style.width = '0%';
                    strengthBar.className = 'strength-bar';
                    break;
                case 1:
                    strengthBar.style.width = '33%';
                    strengthBar.className = 'strength-bar strength-weak';
                    break;
                case 2:
                    strengthBar.style.width = '66%';
                    strengthBar.className = 'strength-bar strength-medium';
                    break;
                case 3:
                    strengthBar.style.width = '100%';
                    strengthBar.className = 'strength-bar strength-strong';
                    break;
            }
        }
        
        // Animate form groups on load
        document.addEventListener('DOMContentLoaded', function() {
            const formGroups = document.querySelectorAll('.form-group');
            
            formGroups.forEach((group, index) => {
                setTimeout(() => {
                    group.classList.add('show');
                }, 200 + (index * 100));
            });
        });
    </script>
</body>
</html>