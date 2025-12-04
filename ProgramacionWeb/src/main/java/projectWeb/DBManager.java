package projectWeb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DBManager {
    private Connection con = null;
    private Statement stm = null;

    // 🔹 Datos de tu instancia AWS RDS PostgreSQL
    private String host = "glammdb.cxow28k2gvtk.us-east-2.rds.amazonaws.com";  // <-- Endpoint de AWS
    private String port = "5432";
    private String user = "postgres";  // Usuario maestro
    private String pass = "Mirv123*";  // <-- CAMBIA ESTO
    private String db = "glimm_glamm"; // Nombre de tu BD importada en RDS

    public void open() throws Exception {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection(
            "jdbc:postgresql://" + host + ":" + port + "/" + db,
            user, pass
        );
        stm = con.createStatement();
    }

    public void close() throws Exception {
        if (stm != null) stm.close();
        if (con != null) con.close();
    }

    public Connection getCon() { return con; }
    public Statement getStm() { return stm; }
}
