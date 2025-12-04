<%@ page import="java.security.MessageDigest" %>
<%@ page import="projectWeb.DBManager" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain; charset=UTF-8" %>

<%! 
    // ----------- FUNCIÓN PARA ENCRIPTAR (DEBE IR AQUÍ) ----------- //
    public String hashPassword(String pass) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] digest = md.digest(pass.getBytes("UTF-8"));
        StringBuilder hex = new StringBuilder();
        for (byte b : digest) hex.append(String.format("%02x", b));
        return hex.toString();
    }
%>

<%
    request.setCharacterEncoding("UTF-8");

    String accion = request.getParameter("accion");
    DBManager db = new DBManager();

    try {
        db.open();

        // ----------- ALTA ----------- //
        if ("alta".equals(accion)) {

            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String password = hashPassword(request.getParameter("password"));
            String rol = request.getParameter("rol");

            PreparedStatement ps = db.getCon().prepareStatement(
                "INSERT INTO usuarios (nombre, correo, contrasena, rol) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, nombre);
            ps.setString(2, correo);
            ps.setString(3, password);
            ps.setString(4, rol);
            ps.executeUpdate();
            ps.close();

            out.print("Usuario registrado con éxito.");
        }

        // ----------- MODIFICAR ----------- //
        else if ("modificar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String password = request.getParameter("password");
            String rol = request.getParameter("rol");

            StringBuilder sql = new StringBuilder("UPDATE usuarios SET ");
            boolean first = true;

            if (nombre != null && !nombre.trim().isEmpty()) {
                sql.append("nombre=?");
                first = false;
            }
            if (correo != null && !correo.trim().isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("correo=?");
                first = false;
            }
            if (password != null && !password.trim().isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("contrasena=?");
                first = false;
            }
            if (rol != null && !rol.trim().isEmpty()) {
                if (!first) sql.append(", ");
                sql.append("rol=?");
            }

            sql.append(" WHERE id=?");

            PreparedStatement ps = db.getCon().prepareStatement(sql.toString());

            int index = 1;
            if (nombre != null && !nombre.trim().isEmpty()) ps.setString(index++, nombre);
            if (correo != null && !correo.trim().isEmpty()) ps.setString(index++, correo);
            if (password != null && !password.trim().isEmpty()) {
                ps.setString(index++, hashPassword(password));
            }
            if (rol != null && !rol.trim().isEmpty()) ps.setString(index++, rol);

            ps.setInt(index, id);

            int filas = ps.executeUpdate();
            ps.close();

            if (filas > 0) out.print("Usuario modificado con éxito.");
            else out.print("No existe un usuario con ese ID.");
        }

        // ----------- ELIMINAR ----------- //
        else if ("eliminar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));

            PreparedStatement ps = db.getCon().prepareStatement(
                "DELETE FROM usuarios WHERE id=?"
            );
            ps.setInt(1, id);

            int filas = ps.executeUpdate();
            ps.close();

            if (filas > 0) out.print("Usuario eliminado con éxito.");
            else out.print("No existe un usuario con ese ID.");
        }

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        try { db.close(); } catch (Exception ex) {}
    }
%>
