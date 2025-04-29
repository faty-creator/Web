<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mot de passe oublié</title>

        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                 background: url('images/liste.png') no-repeat center center fixed;
                background-size: cover;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            fieldset {
                border: none;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 500px;
            }

            legend {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
            }

            h3 {
                margin-bottom: 20px;
                font-weight: 500;
                text-align: center;
            }

            table {
                width: 100%;
            }

            td {
                padding: 10px;
            }

            input[type="email"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                width: 100%;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            .error-message {
                color: red;
                text-align: center;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <fieldset>
            <legend>Mot de passe oublié</legend>
            <form action="Mdob" method="post">
                <h3>Entrez votre adresse e-mail pour recevoir le code de réinitialisation</h3>
                <table>
                    <tr>
                        <td><label for="email">E-mail</label></td>
                        <td><input type="email" id="email" name="email" required></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Envoyer"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h4 class="error-message">
                                <%= request.getParameter("msg") != null ? request.getParameter("msg") : "" %>
                            </h4>

                        </td>
                    </tr>
                </table>
            </form>
        </fieldset>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>