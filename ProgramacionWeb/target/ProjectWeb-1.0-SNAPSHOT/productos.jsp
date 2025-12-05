<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="projectWeb.DBManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos - Glimm & Glam</title>

    <link rel="stylesheet" href="css/estilos.css"> 
    <link rel="stylesheet" href="css/productos.css"> 
</head>

<body>

<header class="barra-navegacion">
    <div class="contenedor-header">
        <div class="menu-toggle" onclick="toggleMenu()">☰</div>
        <div class="botones-izquierda">
            <a href="logout.jsp" class="btn">Cerrar Sesión</a>
        </div>
    </div>

    <nav class="menu-hamburguesa" id="menuHamburguesa">
        <ul>
            <li><a href="productos.jsp?filtro=Marca">Marcas</a></li>
            <li><a href="productos.jsp?filtro=Rostro">Rostro</a></li>
            <li><a href="productos.jsp?filtro=Labios">Labios</a></li>
            <li><a href="productos.jsp?filtro=Ojos">Ojos</a></li>
            <li><a href="productos.jsp?filtro=Pestañas">Pestañas</a></li>
            <li><a href="productos.jsp?filtro=Cejas">Cejas</a></li>
            <li><a href="productos.jsp?filtro=Skincare">Skincare</a></li>
            <li><a href="productos.jsp?filtro=Brochas">Brochas</a></li>
            <li><a href="productos.jsp?filtro=Sets">Sets</a></li>
            <li><a href="productos.jsp?filtro=Accesorios">Accesorios</a></li>
            <li><a href="productos.jsp?filtro=Todo">Ver todo</a></li>
            <li><a href="index.jsp">Nosotros</a></li>

            <%
                String rol = (String) session.getAttribute("rol");
                if ("administrador".equals(rol)) {
            %>
                <li><a href="tablasProductos.jsp">Tablas Productos</a></li>
                <li><a href="tablasUsuarios.jsp">Tablas Usuarios</a></li>
            <%
                }
            %>
        </ul>
    </nav>
</header>

<main class="productos-contenedor">

<%
    String filtro = request.getParameter("filtro");
    if (filtro == null) filtro = "Todo";

    String marcaSeleccionada = request.getParameter("marca");

    DBManager db = new DBManager();
    db.open();

    boolean mostrarProductos = true;
%>

<%
if (filtro.equals("Marca")) {
    PreparedStatement psMarcas = db.getCon().prepareStatement(
        "SELECT DISTINCT marca FROM productos WHERE marca IS NOT NULL ORDER BY marca"
    );
    ResultSet rsMarcas = psMarcas.executeQuery();
    mostrarProductos = false;
%>

<h1 class="titulo-productos">Selecciona una marca</h1>

<div style="display:flex; flex-wrap:wrap; gap:20px; justify-content:center; padding:20px;">

<%
    while (rsMarcas.next()) {
        String m = rsMarcas.getString("marca");
%>

    <a href="productos.jsp?marca=<%= m %>"
       style="padding:12px 20px; background:#e08ebf; color:white; border-radius:12px; text-decoration:none; font-weight:bold; font-size:1.1rem;">
        <%= m %>
    </a>

<%
    }
    rsMarcas.close();
    psMarcas.close();
}
%>



<%
if (marcaSeleccionada != null) {
    PreparedStatement psMarca = db.getCon().prepareStatement(
        "SELECT * FROM productos WHERE marca = ?"
    );
    psMarca.setString(1, marcaSeleccionada);
    ResultSet rsMarca = psMarca.executeQuery();
    mostrarProductos = false;
%>

<h1 class="titulo-productos">Productos de <%= marcaSeleccionada %></h1>

<div class="grid-productos">

<%
    boolean hayProductosMarca = false;

    while (rsMarca.next()) {
        hayProductosMarca = true;
        String img = rsMarca.getString("url_imagen");
        if (img == null || img.trim().equals("")) img = "img/sin-imagen.png";
%>

    <div class="card-producto">
        <img src="<%= img %>">
        <p class="nombre-producto"><%= rsMarca.getString("nombre") %></p>
        <p class="precio-producto">$<%= rsMarca.getDouble("precio") %> MXN</p>
        <a href="#" class="btn-agregar">Agregar al carrito</a>
    </div>

<%
    }

    if (!hayProductosMarca) {
%>
        <p class="sin-productos">No hay artículos disponibles .</p>
<%
    }

    rsMarca.close();
    psMarca.close();
}
%>

</div>



<%
if (mostrarProductos) {

    PreparedStatement ps;
    if (filtro.equals("Todo")) {
        ps = db.getCon().prepareStatement("SELECT * FROM productos");
    } else {
        ps = db.getCon().prepareStatement(
            "SELECT p.* FROM productos p JOIN categorias c ON p.id_categoria = c.id_categoria WHERE c.nombre = ?"
        );
        ps.setString(1, filtro);
    }

    ResultSet rs = ps.executeQuery();
%>

<h1 class="titulo-productos"><%= filtro.equals("Todo") ? "Todos los productos" : filtro %></h1>

<div class="grid-productos">

<%
    boolean hayProductosCat = false;

    while (rs.next()) {
        hayProductosCat = true;
        String img = rs.getString("url_imagen");
        if (img == null || img.trim().equals("")) img = "img/sin-imagen.png";
%>

    <div class="card-producto">
        <img src="<%= img %>">
        <p class="nombre-producto"><%= rs.getString("nombre") %></p>
        <p class="precio-producto">$<%= rs.getDouble("precio") %> MXN</p>
        <a href="#" class="btn-agregar">Agregar al carrito</a>
    </div>

<%
    }

    if (!hayProductosCat) {
%>
        <p class="sin-productos">No hay artículos disponibles</p>
<%
    }

    rs.close();
    ps.close();
}
db.close();
%>

</div>

<div class="validador">
                <a href="https://validator.w3.org/check?uri=referer" target="_blank">
                    <img src="https://www.w3.org/Icons/valid-html401" alt="¡HTML válido!" width="88" height="31">
                </a>
            </div>

            <div class="validador-css">
                <a href="https://jigsaw.w3.org/css-validator/check/referer" target="_blank">
                    <img src="https://jigsaw.w3.org/css-validator/images/vcss" alt="¡CSS válido!" width="88" height="31">
                </a>
            </div>

</main>

<footer>
    <h2>Contáctanos</h2>
    <img src="Imagenes/contacto.jpg" width="300">
    <p>
        Escríbenos a atencion@GlimmGlam.com<br>
        Llámanos al 800-737-4072<br>
        Lunes a Domingo de 8 am a 8 pm
    </p>
</footer>

<script src="js/index.js"></script>
</body>
</html>
