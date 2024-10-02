<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ include file="conection.jsp" %>
<%
    // Iniciar sesión
    session = request.getSession();
    Integer id_usuario = (Integer) session.getAttribute("cliente_id");

    // Verificar si el usuario no está logueado
    boolean usuarioLogueado = id_usuario != null;

    // Inicializar variables para los datos del usuario
    String nombre = "", email = "", celular = "";
    boolean registroExitoso = false;

    // Si el usuario está logueado, obtener sus datos
    if (usuarioLogueado) {
        PreparedStatement query = null;
        ResultSet result = null;
        try {
            // Cambia el query para usar MySQL
            query = conexion.prepareStatement("SELECT nombre_apellido, email, celular FROM registrar WHERE id = ?");
            query.setInt(1, id_usuario);
            result = query.executeQuery();

            if (result.next()) {
                nombre = result.getString("nombre_apellido");
                email = result.getString("email");
                celular = result.getString("celular");
            }

            // Procesar la reservación si el formulario fue enviado
            if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("reservar") != null) {
                String fecha_reserva = request.getParameter("fecha");
                String hora = request.getParameter("hora");
                int numero_personas = Integer.parseInt(request.getParameter("personas"));
                String comentarios = request.getParameter("comentarios");

                PreparedStatement insertQuery = null;
                try {
                    // Cambia el insert para usar MySQL
                    insertQuery = conexion.prepareStatement("INSERT INTO reservaciones (id, fecha_reserva, hora, numero_personas, comentarios) VALUES (?, ?, ?, ?, ?)");
                    insertQuery.setInt(1, id_usuario);
                    insertQuery.setString(2, fecha_reserva);
                    insertQuery.setString(3, hora);
                    insertQuery.setInt(4, numero_personas);
                    insertQuery.setString(5, comentarios);

                    int filasInsertadas = insertQuery.executeUpdate();
                    registroExitoso = filasInsertadas > 0;
                } finally {
                    if (insertQuery != null) insertQuery.close();
                }
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (result != null) result.close();
            if (query != null) query.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservaciones</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style.css" type="text/css"/>
    <style>
        /* Estilo del Popup */
        .popup-container {
            display: none; /* Ocultar por defecto */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            align-items: center;
            justify-content: center;
        }

        .popup {
            background-color: #fefefe;
            border: 1px solid #888;
            padding: 20px;
            text-align: center;
            width: 80%;
            max-width: 400px;
            margin: auto;
        }

        .popup p {
            margin: 0 0 15px;
        }

        .popup button {
            background-color: #4CAF50; /* Verde */
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }

        .popup button:hover {
            background-color: #45a049; /* Verde más oscuro */
        }

        /* Otros estilos existentes */
        .modal {
            display: none; /* Ocultar por defecto */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <header class="encabezado">
        <div class="contenedor-navegacion">
            <div class="contenido-navegacion contenedor">
                <div class="logo">
                    <a href="index.html" class="logo-icon">
                        <i class="fas fa-concierge-bell"></i>
                    </a>
                    <h2>Sabor Peruano</h2>
                </div>

                <!-- Contenedor para el ícono de sesión debajo del logo -->
                <div class="contenedor-icono-sesion">
                    <img src="https://c0.klipartz.com/pngpicture/782/114/gratis-png-icono-de-perfil-icono-de-usuario-en-un-circulo-thumbnail.png"
                         alt="Icono" class="icono-sesion">
                    <a href="login.jsp" class="btn-iniciar-sesion">Iniciar Sesión</a>
                </div>

                <nav class="navegacion">
                    <a href="index.html">Inicio</a>
                    <a href="Conocenos.html">Conócenos</a>
                    <a href="pedidos.html">Menú</a>
                    <a href="contactanos.php">Contáctanos</a>
                    <a href="proveedores.html">Proveedor</a>
                    <a href="reservaciones.jsp">Reservaciones</a>
                    <a href="ubicacion.html">Ubicaciones</a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Formulario de Reservaciones -->
    <div class="contenido-header">
        <div class="contenedor-encabezado">
            <img src="images/fondo.jpeg" alt="Imagen de fondo" class="imagen-fondo">
        </div>
    </div>
    <div class="contenedor-reservacion contenedor">
        <div class="informacion-reservacion">
            <h3>Reserva tu mesa</h3>
            <p><i class="fas fa-calendar-alt"></i> Elige la fecha y hora que prefieras</p>
            <p><i class="fas fa-users"></i> Indica el número de personas</p>
            <p><i class="fas fa-comments"></i> Deja tus comentarios o solicitudes especiales</p>
        </div>

        <% if (usuarioLogueado) { %>
        <form class="formulario-reservacion" action="reservaciones.jsp" method="post">
            <div class="input-formulario">
                <label for="nombre">Nombre y Apellido</label>
                <input type="text" id="nombre" name="nombre" value="<%= nombre %>" required>
            </div>
            <div class="input-formulario">
                <label for="correo">Correo</label>
                <input type="email" id="correo" name="correo" value="<%= email %>" required>
            </div>
            <div class="input-formulario">
                <label for="telefono">Teléfono</label>
                <input type="tel" id="telefono" name="telefono" value="<%= celular %>">
            </div>
            <div class="input-formulario">
                <label for="fecha">Fecha</label>
                <input type="date" id="fecha" name="fecha" required>
            </div>
            <div class="input-formulario">
                <label for="hora">Hora</label>
                <input type="time" id="hora" name="hora" required>
            </div>
            <div class="input-formulario">
                <label for="personas">Número de personas</label>
                <input type="number" id="personas" name="personas" min="1" required>
            </div>
            <div class="input-formulario">
                <label for="comentarios">Comentarios</label>
                <input type="text" id="comentarios" name="comentarios">
            </div>
            <div class="btn-formulario">
                <input type="submit" class="btn btn-rojo" value="Reservar" name="reservar">
            </div>
        </form>
        <% } else { %>
        <p>Por favor, <a href="login.jsp">inicia sesión</a> para realizar una reservación.</p>
        <% } %>
    </div>

    <!-- Popup de confirmación -->
    <div class="popup-container" id="popupContainer">
        <div class="popup">
            <p>¡Registro completado exitosamente!</p>
            <button id="acceptButton">Aceptar</button>
        </div>
    </div>

    <!-- Pie de Página -->
    <div class="contenedor-piepagina contenedor">
        <div class="info">
            <h3>Dirección</h3>
            <p>242 Av. El Sol</p>
        </div>
        <div class="info">
            <h3>Días especiales</h3>
            <p>Viernes y Sábados 7am - 11pm</p>
            <p>+987654321</p>
        </div>
        <div class="info">
            <h3>Horarios</h3>
            <p>Lunes - Domingo 7am - 11pm</p>
            <div class="redes-sociales redes-pie">
                <a href="https://www.facebook.com/profile.php?id=61565646991296"><i class="fab fa-facebook-square"></i></a>
                <a href="#"><i class="fab fa-twitter-square"></i></a>
                <a href="https://www.instagram.com/saborperuano731?utm_source=qr&igshid=NTEzNjA3cXdwZWQ="><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>Página de prueba &copy; 2024 Taller Web</p>
    </footer>

    <!-- Script para el Popup -->
    <% if (registroExitoso) { %>
    <script>
        document.getElementById('popupContainer').style.display = 'flex';

        // Redirigir a login.jsp cuando se haga clic en "Aceptar"
        document.getElementById('acceptButton').addEventListener('click', function() {
            window.location.href = 'reservaciones.jsp'; // Asegúrate de que la URL sea correcta
        });

        // Opcional: Puedes añadir lógica para cerrar el popup si se hace clic fuera de él
        window.onclick = function(event) {
            if (event.target == document.getElementById('popupContainer')) {
                document.getElementById('popupContainer').style.display = 'none';
                window.location.href = 'login.jsp'; // Redirigir a la página de inicio de sesión
            }
        };
    </script>
    <% } %>
</body>
</html>
