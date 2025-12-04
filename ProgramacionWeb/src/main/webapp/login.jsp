<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="projectWeb.DBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Glimm & Glam - Login</title>
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

<%
    String correo = request.getParameter("email");
    String contrasena = request.getParameter("password");
    String mensajeError = null;

    if (correo != null && contrasena != null) {
        DBManager db = new DBManager();
        try {
            db.open();

            PreparedStatement ps = db.getCon().prepareStatement(
                "SELECT * FROM usuarios WHERE correo = ? AND contrasena = ?"
            );
            ps.setString(1, correo);
            ps.setString(2, contrasena);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String rol = rs.getString("rol");   

                session.setAttribute("usuario", correo);
                session.setAttribute("rol", rol);   

                db.close();

                response.sendRedirect("index.jsp");
                return;
            } else {
                mensajeError = "Correo o contraseña incorrectos";
            }

            rs.close();
            ps.close();
            db.close();

        } catch (Exception e) {
            mensajeError = "Error interno: " + e.getMessage();
        }
    }
%>

<section class="pantalla pantalla-login">

    <header>
        <a href="index.jsp" class="back-btn"></a>
    </header>

    <h2>Inicio de sesión</h2>

    <form class="login-form" method="post" action="login.jsp">
        <label>Correo electrónico</label>
        <input type="email" name="email" placeholder="Correo electrónico" required>

        <label>Contraseña</label>
        <input type="password" name="password" placeholder="Contraseña" required>

        <button type="submit" class="btn-amarillo">Iniciar sesión</button>

        <% if (mensajeError != null) { %>
            <p style="color:red; text-align:center;"><%= mensajeError %></p>
        <% } %>

        <a href="recovery.jsp" class="olvide">¿Olvidaste tu contraseña?</a>
    </form>

</section>

</body>
</html>
