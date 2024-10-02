<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
    // Reemplaza los valores entre corchetes con los valores reales
String url = "jdbc:mysql://localhost:3306/restaurant"; // Cambia el nombre a la base de datos deseada
    String user = "root"; // Usuario de MySQL (puede ser 'root' o el que uses)
    String password = ""; // Contraseña de MySQL (por defecto suele estar vacía)

    Connection conexion = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Cargar el driver de MySQL
        conexion = DriverManager.getConnection(url, user, password); // Conexión a la base de datos
        // Puedes almacenar el estado en una variable de sesión si es necesario
        session.setAttribute("conexionExitosa", true);
    } catch (Exception e) {
        // Manejo de errores, opcionalmente almacenar el error en la sesión para depuración
        session.setAttribute("conexionError", e.getMessage());
    }
%>
