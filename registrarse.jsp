<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Restaurante</title>
    <style>
        /* Estilos básicos para la página */
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
        .container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        h1, h2 {
            text-align: center;
            color: #000;
        }
        label {
            color: #000;
            font-weight: bold;
        }
        input[type="text"], input[type="password"], input[type="tel"], input[type="email"] {
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

        /* Estilos para el popup */
        .popup-container {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            justify-content: center;
            align-items: center;
        }

        .popup {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
            max-width: 400px;
            text-align: center;
            border-radius: 8px;
        }

        #acceptButton {
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
        }
        #acceptButton:hover {
            background-color: #333;
        }

        .error-message {
            display: none;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    Connection conn = null;
    boolean registroExitoso = false;

    try {
        // Cargar el driver JDBC de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Configurar la conexión
        String jdbcUrl = "jdbc:mysql://localhost:3306/restaurant?useSSL=false&serverTimezone=UTC";
        String jdbcUser = "root";
        String jdbcPassword = "";
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

        // Verificar si el formulario fue enviado
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String dni = request.getParameter("dni").trim();
            String nombre_apellido = request.getParameter("nombre_apellido").trim();
            String email = request.getParameter("email").trim();
            String direccion = request.getParameter("direccion").trim();
            String celular = request.getParameter("celular").trim();
            String password = request.getParameter("password").trim();

            // Cifrar la contraseña
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Verificar si el email ya está registrado
            String checkEmailSQL = "SELECT id FROM registrar WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(checkEmailSQL);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                out.println("<script>document.getElementById('errorMessage').style.display = 'block';</script>");
                response.setHeader("Refresh", "2; URL=registrarse.jsp"); // Redirigir después de 2 segundos
            } else {
                // Insertar los datos del nuevo registro
                String insertSQL = "INSERT INTO registrar (dni, nombre_apellido, email, direccion, celular, password) VALUES (?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertSQL);
                stmt.setString(1, dni);
                stmt.setString(2, nombre_apellido);
                stmt.setString(3, email);
                stmt.setString(4, direccion);
                stmt.setString(5, celular);
                stmt.setString(6, hashedPassword);

                if (stmt.executeUpdate() > 0) {
                    registroExitoso = true;
                } else {
                    out.println("<p>Error al registrar.</p>");
                }
            }

            stmt.close();
            rs.close();
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                out.println("<p>Error al cerrar la conexión: " + e.getMessage() + "</p>");
            }
        }
    }
%>

<!-- Popup de registro exitoso -->
<div class="popup-container" id="popupContainer">
    <div class="popup">
        <p>¡Registro completado exitosamente!</p>
        <button id="acceptButton">Aceptar</button>
    </div>
</div>

<!-- Mensaje de error -->
<div class="error-message" id="errorMessage">ERROR: El email ya está registrado.</div>

<div class="container">
    <h1>Restaurante Sabor Peruano</h1>
    <h2>Registrarse</h2>
    <form id="registerForm" method="POST" action="registrarse.jsp">
        <label for="dni">DNI:</label>
        <input type="text" id="dni" name="dni" required>
        <label for="nombre_apellido">Nombre y Apellido:</label>
        <input type="text" id="nombre_apellido" name="nombre_apellido" required>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name="direccion" required>
        <label for="celular">Celular:</label>
        <input type="tel" id="celular" name="celular" required>
        <label for="password">Crear Contraseña:</label>
        <input type="password" id="password" name="password" required>
        <input type="submit" value="Registrarse">
    </form>
</div>

<script>
    <% if (registroExitoso) { %>
        document.getElementById('popupContainer').style.display = 'flex';

        // Redirigir a login.jsp cuando se haga clic en "Aceptar"
        document.getElementById('acceptButton').addEventListener('click', function() {
            window.location.href = 'login.jsp';
        });
    <% } %>
</script>

</body>
</html>
