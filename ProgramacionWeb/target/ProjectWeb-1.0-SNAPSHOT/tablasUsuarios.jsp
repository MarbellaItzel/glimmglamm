<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tablas Usuarios</title>

    <!-- CSS -->
    <link rel="stylesheet" href="css/estilos.css">
    <link rel="stylesheet" href="css/formulario.css">

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/tablasUsuarios.js"></script>
</head>

<body>

    <!-- =================== HEADER =================== -->
    <header class="barra-navegacion">
        <div class="contenedor-header">
            <div class="menu-toggle" onclick="toggleMenu()">☰</div>
            <div class="titulo">
                <h1>Glimm & Glam</h1>
                <p>Administración de Usuarios</p>
            </div>
        </div>

        <nav class="opciones-barra">
            <a href="#alta" class="btn">Registrar</a>
            <a href="#modificar" class="btn">Modificar</a>
            <a href="#eliminar" class="btn">Eliminar</a>
        </nav>

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
                <li><a href="tablasProductos.jsp">Tablas Productos</a></li>
                <li><a href="tablasUsuarios.jsp">Tablas Usuarios</a></li>
                <li><a href="index.jsp">Regresar al inicio</a></li>
            </ul>
        </nav>
    </header>


    <!-- =================== SECCIÓN ALTA =================== -->
    <section id="alta" class="form-seccion">
        <form class="formUsuario">
            <h2>Registrar Usuario</h2>

            <input type="hidden" name="accion" value="alta">

            <table>
                <tr>
                    <td>Nombre:</td>
                    <td><input type="text" name="nombre" required></td>
                </tr>

                <tr>
                    <td>Correo:</td>
                    <td><input type="email" name="correo" required></td>
                </tr>

                <tr>
                    <td>Contraseña:</td>
                    <td><input type="password" name="password" required></td>
                </tr>

                <tr>
                    <td>Rol:</td>
                    <td>
                        <select name="rol">
                            <option value="administrador">Administrador</option>
                            <option value="cliente">Cliente</option>
                            <option value="vendedor">Vendedor</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align:center;">
                        <button type="submit">Guardar</button>
                    </td>
                </tr>
            </table>
        </form>
    </section>


    <!-- =================== SECCIÓN MODIFICAR =================== -->
    <section id="modificar" class="form-seccion">
        <form class="formUsuario">
            <h2>Modificar Usuario</h2>

            <input type="hidden" name="accion" value="modificar">

            <table>
                <tr>
                    <td>ID Usuario:</td>
                    <td><input type="text" name="id" required></td>
                </tr>

                <tr>
                    <td>Nuevo Nombre:</td>
                    <td><input type="text" name="nombre"></td>
                </tr>

                <tr>
                    <td>Nuevo Correo:</td>
                    <td><input type="email" name="correo"></td>
                </tr>

                <tr>
                    <td>Nueva Contraseña:</td>
                    <td><input type="password" name="password"></td>
                </tr>

                <tr>
                    <td>Nuevo Rol:</td>
                    <td>
                        <select name="rol">
                            <option value="">-- Seleccionar --</option>
                            <option value="administrador">Administrador</option>
                            <option value="cliente">Cliente</option>
                            <option value="vendedor">Vendedor</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align:center;">
                        <button type="submit">Modificar</button>
                    </td>
                </tr>
            </table>
        </form>
    </section>


    <!-- =================== SECCIÓN ELIMINAR =================== -->
    <section id="eliminar" class="form-seccion">
        <form class="formUsuario">
            <h2>Eliminar Usuario</h2>

            <input type="hidden" name="accion" value="eliminar">

            <table>
                <tr>
                    <td>ID Usuario:</td>
                    <td><input type="text" name="id" required></td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align:center;">
                        <button type="submit">Eliminar</button>
                    </td>
                </tr>
            </table>
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
    
    <!-- =================== FOOTER =================== -->
    <footer>
        <h2>Contáctanos</h2>
        <img src="Imagenes/contacto.jpg" width="300">
        <p>
            Escríbenos a atencion@GlimmGlam.com<br>
            Llámanos al 800-737-4072<br>
            Lunes a Domingo de 8 am a 8 pm
        </p>
    </footer>

    </body>
    </html>
