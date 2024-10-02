<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Restaurante</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://www.lima2019.pe/sites/default/files/2019-08/PORTADAFINAL.jpg');
            background-size: cover;
            background-position: center;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            position: relative;
        }
        h1 {
            text-align: center;
            color: #000;
            margin-bottom: 20px;
        }
        h2 {
            text-align: center;
            color: #000;
        }
        label {
            color: #000;
            font-weight: bold;
        }
        input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #000;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #333;
        }
        .help-section {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .help-section button {
            background-color: transparent;
            border: none;
            color: #000;
            font-size: 14px;
            cursor: pointer;
            text-decoration: underline;
        }
        .help-section button:hover {
            color: #333;
        }
        .error-message {
            color: red;
            font-size: 11px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<%
    String errorMessage = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null && password != null && !email.isEmpty() && !password.isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Cambiamos el driver a MySQL
                String url = "jdbc:mysql://localhost:3306/restaurant?useSSL=false&serverTimezone=UTC";
                String user = "root";
                String pass = "";
                conn = DriverManager.getConnection(url, user, pass);

                String query = "SELECT id, password FROM registrar WHERE email = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String hashedPassword = rs.getString("password");

                    if (BCrypt.checkpw(password, hashedPassword)) {
                        session.setAttribute("cliente_id", rs.getInt("id"));
                        response.sendRedirect("index.html");
                        return;
                    } else {
                        errorMessage = "Contraseña incorrecta.";
                    }
                } else {
                    errorMessage = "Correo electrónico no encontrado.";
                }
            } catch (Exception e) {
                errorMessage = "Error al conectar con la base de datos: " + e.getMessage();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { /* Ignorar */ }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { /* Ignorar */ }
                try { if (conn != null) conn.close(); } catch (Exception e) { /* Ignorar */ }
            }
        } else {
            errorMessage = "Por favor, ingresa tu correo y contraseña.";
        }
    }
%>

<div class="login-container">
    <h1>Restaurante Sabor Peruano</h1>
    <h2>Iniciar Sesión</h2>
    <form id="loginForm" method="POST" action="">
        <label for="email">Correo Electrónico:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" required>

        <div class="help-section">
            <button type="button" onclick="window.location.href='registrarse.jsp'">Registrarse</button>
            <button type="button" onclick="window.location.href='necesitasayuda.html'">¿Necesitas ayuda?</button>
        </div>

        <input type="submit" value="Iniciar Sesión">
    </form>

    <!-- Mostrar mensaje de error si existe -->
    <% if (!errorMessage.isEmpty()) { %>
        <div class="error-message"><%= errorMessage %></div>
    <% } %>
</div>

</body>
</html>
