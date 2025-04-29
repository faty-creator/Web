<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verification</title>
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

            table {
                width: 100%;
            }

            td {
                padding: 10px 0;
            }

            input[type="number"], input[type="submit"] {
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

            @media (max-width: 768px) {
                fieldset {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <fieldset>
            <legend>Verification</legend>
            <div class="container">
                <h2 class="mt-5">Vérification du code de réinitialisation</h2>
                <form action="Verfier" method="post">
                    <div class="form-group">
                        <label for="code">Code de vérification</label>
                        <input type="number" name="code" id="code" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Valider</button>
                </form>

                <br>
                <div class="alert alert-danger" style="<%= request.getParameter("msg") != null ? "display:block;" : "display:none;"%>">
                    <%= request.getParameter("msg") != null ? request.getParameter("msg") : ""%>
                </div>
            </div>
        </fieldset>

        <!-- Bootstrap JS and dependencies (optional) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>