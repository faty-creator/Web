<%-- 
    Document   : updateMotdePasse
    Created on : 27 avr. 2025, 02:00:03
    Author     : hibaa
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modifier le Mot de Passe</title>
        <!-- Bootstrap CSS link -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: url('images/liste.png') no-repeat center center fixed;
                background-size: cover;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            fieldset {
                border: none;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 500px;
            }

            legend {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                padding: 0 10px;
                margin-bottom: 20px;
                position: relative;
            }

            legend::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: #4CAF50;
                margin-top: 8px;
            }

            h3 {
                color: #333;
                font-weight: 500;
                margin-bottom: 20px;
            }

            input[type="password"], input[type="submit"] {
                width: 100%;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ddd;
                font-size: 16px;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            .error-message {
                color: #ff5252;
                text-align: center;
                margin-top: 10px;
            }

            .success-message {
                color: #4CAF50;
                text-align: center;
                margin-top: 10px;
            }

            @media (max-width: 768px) {
                fieldset {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <fieldset>
            <legend>Modifier le Mot de Passe</legend>
            <form action="UpdatePasswordController" method="post">
                <h3>Entrez votre nouveau mot de passe:</h3>
                <div class="container">
                    <h2 class="mt-5">Modification du mot de passe</h2>
                    <form action="UpdatePasswordController" method="post">
                        <div class="form-group">
                            <label for="password">Nouveau mot de passe</label>
                            <input type="password" name="password" id="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="passwordcnf">Confirmer le mot de passe</label>
                            <input type="password" name="passwordcnf" id="passwordcnf" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Mettre à jour</button>
                    </form>
                </div>

                <!-- Affichage des messages d'erreur ou de succès -->
                <div>
                    <%
                        String error = request.getParameter("error");
                        String success = request.getParameter("success");
                        if ("password_mismatch".equals(error)) {
                    %>
                    <div class="alert alert-danger">Les mots de passe ne correspondent pas. Veuillez réessayer.</div>
                    <% } else if ("empty_fields".equals(error)) { %>
                    <div class="alert alert-warning">Tous les champs doivent être remplis.</div>
                    <% } else if ("not_logged_in".equals(error)) { %>
                    <div class="alert alert-danger">Vous devez être connecté pour modifier votre mot de passe.</div>
                    <% } else if ("password_updated".equals(success)) { %>
                    <div class="alert alert-success">Votre mot de passe a été mis à jour avec succès.</div>
                    <% }%>
                </div>
            </form>
        </fieldset>

        <!-- Bootstrap JS and dependencies (optional) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>