<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${empty etudiant ? 'Ajouter' : 'Modifier'} Étudiant</title>
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a0ca3;
            --secondary: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f94144;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7ff;
            color: #333;
        }
        
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
            animation: fadeIn 0.8s ease-out;
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
            position: relative;
            display: inline-block;
        }
        
        .form-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: var(--secondary);
            border-radius: 2px;
        }
        
        .form-body {
            padding: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
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
            background-color: #f9f9f9;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            background-color: white;
            outline: none;
        }
        
        .form-row {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .form-col {
            flex: 1;
        }
        
        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-3px);
        }
        
        .password-strength {
            height: 5px;
            background: #e0e0e0;
            border-radius: 5px;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        
        .strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
        }
        
        .strength-weak {
            background: var(--danger);
            width: 30%;
        }
        
        .strength-medium {
            background: var(--warning);
            width: 60%;
        }
        
        .strength-strong {
            background: var(--success);
            width: 90%;
        }
        
        .strength-very-strong {
            background: #2ecc71;
            width: 100%;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Floating labels */
        .floating-label-group {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .floating-label {
            position: absolute;
            top: 0.75rem;
            left: 1rem;
            font-size: 0.9rem;
            color: #6c757d;
            transition: all 0.3s ease;
            pointer-events: none;
            background: white;
            padding: 0 0.25rem;
        }
        
        .form-control:focus + .floating-label,
        .form-control:not(:placeholder-shown) + .floating-label {
            top: -0.6rem;
            left: 0.8rem;
            font-size: 0.75rem;
            color: var(--primary);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 1rem;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-card">
            <div class="form-header">
                <h1 class="form-title">${empty etudiant ? 'Ajouter' : 'Modifier'} un Étudiant</h1>
            </div>
            <div class="form-body">
                <form action="${pageContext.request.contextPath}/AddEtudiant" method="POST" class="needs-validation" novalidate>
                    <c:if test="${not empty etudiant}">
                        <input type="hidden" name="id" value="${etudiant.id}">
                    </c:if>
                    
                    <div class="form-row">
                        <div class="form-col">
                            <div class="floating-label-group">
                                <input type="text" class="form-control" id="cne" name="cne" 
                                       placeholder=" " value="<%= request.getParameter("cne") != null ? request.getParameter("cne") : ""%>" required>
                                <label class="floating-label" for="cne">CNE</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-col">
                            <div class="floating-label-group">
                                <input type="text" class="form-control" id="nom" name="nom" 
                                       placeholder=" " value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : ""%>" required>
                                <label class="floating-label" for="nom">Nom</label>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="floating-label-group">
                                <input type="text" class="form-control" id="prenom" name="prenom" 
                                       placeholder=" " value="<%= request.getParameter("prenom") != null ? request.getParameter("prenom") : ""%>" required>
                                <label class="floating-label" for="prenom">Prénom</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder=" " value="<%= request.getParameter("email") != null ? request.getParameter("email") : ""%>" required>
                            <label class="floating-label" for="email">Email</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="password" class="form-control" id="password" name="mdp" 
                                   placeholder=" " ${empty etudiant ? 'required' : ''} value="<%= request.getParameter("mdp") != null ? request.getParameter("mdp") : ""%>">
                            <label class="floating-label" for="password">Mot de passe</label>
                        </div>
                        <div class="password-strength">
                            <div class="strength-bar" id="strengthBar"></div>
                        </div>
                        <small class="text-muted">
                            ${not empty etudiant ? 'Laissez vide pour ne pas modifier' : 'Minimum 8 caractères'}
                        </small>
                    </div>
                    
                    <div class="btn-group">
                        <a href="Route?page=list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Annuler
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Enregistrer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('strengthBar');
            let strength = 0;
            
            // Reset
            strengthBar.className = 'strength-bar';
            
            // Check length
            if (password.length >= 8) strength++;
            
            // Check uppercase
            if (/[A-Z]/.test(password)) strength++;
            
            // Check numbers
            if (/\d/.test(password)) strength++;
            
            // Check special chars
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            // Update strength bar
            switch(strength) {
                case 1:
                    strengthBar.classList.add('strength-weak');
                    break;
                case 2:
                    strengthBar.classList.add('strength-medium');
                    break;
                case 3:
                    strengthBar.classList.add('strength-strong');
                    break;
                case 4:
                    strengthBar.classList.add('strength-very-strong');
                    break;
            }
        });
        
        // Form validation
        (function() {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>