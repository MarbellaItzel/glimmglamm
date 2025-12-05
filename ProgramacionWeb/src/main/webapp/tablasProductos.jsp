<%@ page import="projectWeb.DBManager" %>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tablas Productos</title>
        <link rel="stylesheet" href="css/estilos.css">
        <link rel="stylesheet" href="css/formulario.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="js/tablasProductos.js"></script>
    </head>
    
    <body>
        <%
            String accion = request.getParameter("accion");
            String mensaje = null;
            
            if (accion != null) {
                DBManager db = new DBManager();
                try {
                    db.open();

                    if ("alta".equals(accion)) {
                    String nombre = request.getParameter("nombre");
                    String marca = request.getParameter("marca");
                    String descripcion = request.getParameter("descripcion");
                    String precio = request.getParameter("precio");
                    String stock = request.getParameter("stock");
                    String id_categoria = request.getParameter("id_categoria");
                    String url_imagen = request.getParameter("url_imagen");;

                    PreparedStatement ps = db.getCon().prepareStatement(
                        "INSERT INTO productos (nombre, marca, descripcion, precio, stock, id_categoria, url_imagen) VALUES (?, ?, ?, ?, ?, ?, ?)"
                    );
                    ps.setString(1, nombre);
                    ps.setString(2, marca);
                    ps.setString(3, descripcion);
                    ps.setBigDecimal(4, new java.math.BigDecimal(precio));
                    ps.setInt(5, Integer.parseInt(stock));
                    ps.setInt(6, Integer.parseInt(id_categoria));
                    ps.setString(7, url_imagen);
                    ps.executeUpdate();
                    ps.close();

                    mensaje = "Producto registrado con éxito";

                    } else if ("modificar".equals(accion)) {
                    String id = request.getParameter("id");
                    String precio = request.getParameter("precio");
                    String stock = request.getParameter("stock");

                    PreparedStatement ps = db.getCon().prepareStatement(
                        "UPDATE productos SET precio = ?, stock = ? WHERE id_producto = ?"
                    );
                    ps.setBigDecimal(1, new java.math.BigDecimal(precio));
                    ps.setInt(2, Integer.parseInt(stock));
                    ps.setInt(3, Integer.parseInt(id));
                    ps.executeUpdate();
                    ps.close();

                    mensaje = "Producto modificado con éxito";
                
                    } else if ("eliminar".equals(accion)) {
                    String id = request.getParameter("id");

                    PreparedStatement ps = db.getCon().prepareStatement(
                        "DELETE FROM productos WHERE id_producto = ?"
                    );
                    ps.setInt(1, Integer.parseInt(id));
                    ps.executeUpdate();
                    ps.close();

                    mensaje = "Producto eliminado con éxito";
                }

                db.close();
            } catch (Exception e) {
                mensaje = "Error: " + e.getMessage();
            }
        }
        %>

        <header class="barra-navegacion">
            <div class="contenedor-header">
                <div class="menu-toggle" onclick="toggleMenu()">☰</div>
                <div class="titulo">
                    <h1>Glimm & Glam</h1>
                    <p>Maquíllate como reina, brilla como diosa</p>
                </div>          
            </div>

            <nav class="opciones-barra">
                <a href="#alta" class="btn">Registrar</a>
                <a href="#modificar" class="btn">Modificar</a>
                <a href="#eliminar" class="btn">Eliminar</a>
            </nav>

            <nav class="menu-hamburguesa" id="menuHamburguesa">
                <ul>
                    <li><a href="marca.jsp">Marca</a></li>
                    <li><a href="rostro.jsp">Rostro</a></li>
                    <li><a href="labios.jsp">Labios</a></li>
                    <li><a href="ojos.jsp">Ojos</a></li>
                    <li><a href="pestanas.jsp">Pestañas</a></li>
                    <li><a href="cejas.jsp">Cejas</a></li>
                    <li><a href="skincare.jsp">Skincare</a></li>
                    <li><a href="brochas.jsp">Brochas</a></li>
                    <li><a href="sets.jsp">Sets</a></li>
                    <li><a href="accesorios.jsp">Accesorios</a></li>
                    <li><a href="tablasProductos.jsp">Tablas Productos</a></li>
                    <li><a href="tablasUsuarios.jsp">Tablas Usuarios</a></li>
                    <li><a href="index.jsp">Regresar al inicio</a></li>
                </ul>
            </nav>
        </header>

        <!-- Formulario Alta -->
        <section id="alta" class="form-seccion">
            <form method="post">
                <h2>Registrar Producto</h2>
                <input type="hidden" name="accion" value="alta">
                <table>
                    <tr><td>Nombre:</td><td><input type="text" name="nombre" required></td></tr>
                    <tr><td>Marca:</td><td><input type="text" name="marca" required></td></tr>
                    <tr><td>Descripción:</td><td><textarea name="descripcion"></textarea></td></tr>
                    <tr><td>Precio:</td><td><input type="text" name="precio" required></td></tr>
                    <tr><td>Stock:</td><td><input type="text" name="stock" required></td></tr>
                    <tr><td>Categoría:</td>
                        <td>
                            <select name="id_categoria">
                                <option value="2">Rostro</option>
                                <option value="3">Cejas</option>
                                <option value="4">Labios</option>
                                <option value="5">Pestañas</option>
                                <option value="6">Ojos</option>
                                <option value="7">Brochas</option>
                                <option value="8">Sets</option>
                                <option value="9">Skincare</option>
                                <option value="10">Accesorios</option>
                            </select>
                        </td>
                    </tr>
                    <tr><td>Imagen (URL):</td><td><input type="text" name="url_imagen"></td></tr>
                    <tr><td colspan="2" style="text-align:center;"><button type="submit">Guardar</button></td></tr>
                </table>
               <div class="mensaje-validacion" style="display:none;"></div>
            </form>
        </section>

        <!-- Formulario Modificar -->
        <section id="modificar" class="form-seccion">
            <form method="post">
                <h2>Modificar Producto</h2>
                <input type="hidden" name="accion" value="modificar">
                <table>
                    <tr><td>ID Producto:</td><td><input type="text" name="id" required></td></tr>
                    <tr><td>Nuevo Precio:</td><td><input type="text" name="precio"></td></tr>
                    <tr><td>Nuevo Stock:</td><td><input type="text" name="stock"></td></tr>
                    
                    <tr><td colspan="2" style="text-align:center;"><button type="submit">Modificar</button></td></tr>
                </table>
                <div class="mensaje-validacion" style="display:none;"></div>
            </form>
        </section>

        <!-- Formulario Eliminar -->
        <section id="eliminar" class="form-seccion">
            <form method="post">
                <h2>Eliminar Producto</h2>
                <input type="hidden" name="accion" value="eliminar">
                <table>
                    <tr><td>ID Producto:</td><td><input type="text" name="id" required></td></tr>
                    
                    <tr><td colspan="2" style="text-align:center;"><button type="submit">Eliminar</button></td></tr>
                </table>
                <div class="mensaje-validacion" style="display:none;"></div>
            </form>
        </section>
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
        <footer>
            <h2>Contáctanos</h2>
            <img src="Imagenes/contacto.jpg" alt="Prueba de imagen" width="300">
            <p>
                Contáctanos Escríbenos a atencion@GlimmGlam.com<br>
                o Llámanos al 800-737-4072<br>
                Lunes a Domingo de 8 am a 8 pm
            </p>
        </footer>
        <script>
            var mensaje = "<%= mensaje != null ? mensaje : "" %>";
            if (mensaje.trim() !== "") {
                Swal.fire({
                    icon: mensaje.includes("Error") ? 'error' : 'success',
                    title: '¡Acción completada!',
                    html: `<div class="mensaje-exito"><strong>${mensaje}</strong><br>Gracias por mantener tu catálogo actualizado 💄✨</div>`,
                    background: '#fff0f7',
                    confirmButtonColor: '#e08ebf',
                    confirmButtonText: '¡Perfecto!',
                    customClass: {
                        popup: 'sweet-popup',
                        confirmButton: 'sweet-button'
                    }
                });
            }

        </script>
    </body>

</html>
