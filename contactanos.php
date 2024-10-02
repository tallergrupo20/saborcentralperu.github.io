<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contactanos</title>
    <link rel="stylesheet" href="styles.css">
    <!-- link del Font Awesome para los íconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
    <!-- Encabezado -->
    <header class="encabezado">
        <div class="contenedor-navegacion">
            <div class="contenido-navegacion contenedor">
                <div class="logo">
                    <a href="index.html" class="logo-icon"><i class="fas fa-concierge-bell"></i></a>
                    <h2>Sabor Peruano</h2>
                </div>
                <nav class="navegacion">
                    <a href="index.html">Inicio</a>
                    <a href="conocenos.html">Conócenos</a>
                    <a href="pedidos.html">Menú</a>
                    <a href="contactanos.php">Contáctanos</a>
                    <a href="proveedores.html">Proveedor</a>
                    <a href="reservaciones.html">Reservaciones</a>
                    <a href="ubicacion.html">Ubicaciones</a>
                    <a href="login.html" class="btn-iniciar-sesion">Cerrar Sesión</a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Formulario de Contacto -->
    <div class="formulario-contacto contenedor">
        <div class="informacion-contacto">
            <h3>Contáctanos</h3>
            <p><i class="fas fa-map-marker-alt"></i> 242 Av. El Sol</p>
            <p><i class="fas fa-envelope"></i> TallerWeb@utp.edu.pe</p>
            <p><i class="fas fa-phone-alt"></i> +987654321</p>
            <div class="redes-sociales">
                <a href="https://www.facebook.com/profile.php?id=61565646991296" aria-label="Facebook"><i class="fab fa-facebook-square"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter-square"></i></a>
                <a href="https://www.instagram.com/saborperuano731?utm_source=qr&igsh=NTEzNjA3cXdwZWQ=" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
            </div>
        </div>

        <form class="formulario" action="contactanos.php" method="post">
            <div class="input-formulario">
                <label for="nombre">Nombre</label>
                <input type="text" placeholder="Tu nombre" id="nombre" name="nombre" required>
            </div>
            <div class="input-formulario">
                <label for="apellidos">Apellido</label>
                <input type="text" placeholder="Tu apellido" id="apellidos" name="apellidos" required>
            </div>
            <div class="input-formulario">
                <label for="correo">Correo</label>
                <input type="email" placeholder="tucorreo@gmail.com" id="correo" name="correo" required>
            </div>
            <div class="input-formulario">
                <label for="telefono">Teléfono</label>
                <input type="tel" placeholder="Tu número 9xxxxxxxx" id="telefono" name="telefono">
            </div>
            <div class="input-formulario">
                <label for="mensaje">Mensaje</label>
                <textarea id="mensaje" name="mensaje" required></textarea>
            </div>
            <div class="btn-formulario">
                <input type="submit" class="btn btn-verde" value="Enviar">
            </div>
        </form>
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
                <a href="https://www.facebook.com/profile.php?id=61565646991296" aria-label="Facebook"><i class="fab fa-facebook-square"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter-square"></i></a>
                <a href="https://www.instagram.com/saborperuano731?utm_source=qr&igsh=NTEzNjA3cXdwZWQ=" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>Página de prueba &copy; 2024 Taller Web</p>
    </footer>
</body>

</html>

<?php
// Configuración de la base de datos
$servername = "localhost"; // Cambia esto según tu configuración
$username = "root"; // Cambia esto según tu configuración
$password = ""; // Cambia esto según tu configuración
$dbname = "restaurant"; // Cambia esto al nombre de tu base de datos

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Verificar si el formulario ha sido enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Verificar si las claves existen en $_POST y limpiar los datos
    $nombre = isset($_POST['nombre']) ? $conn->real_escape_string($_POST['nombre']) : '';
    $apellido = isset($_POST['apellidos']) ? $conn->real_escape_string($_POST['apellidos']) : '';
    $correo = isset($_POST['correo']) ? $conn->real_escape_string($_POST['correo']) : '';
    $telefono = isset($_POST['telefono']) ? $conn->real_escape_string($_POST['telefono']) : '';
    $mensaje = isset($_POST['mensaje']) ? $conn->real_escape_string($_POST['mensaje']) : '';

    // Preparar la consulta SQL
    $sql = "INSERT INTO contacto (nombre, apellido, correo, telefono, mensaje) VALUES (?, ?, ?, ?, ?)";

    // Preparar la declaración
    $stmt = $conn->prepare($sql);

    // Enlazar parámetros
    $stmt->bind_param("sssss", $nombre, $apellido, $correo, $telefono, $mensaje);

    // Ejecutar la declaración
    if ($stmt->execute()) {
        echo "¡Gracias por contactarnos! Tu mensaje ha sido enviado.";
    } else {
        echo "Error: " . $stmt->error;
    }

    // Cerrar la declaración y la conexión
    $stmt->close();
    $conn->close();
}
?>

