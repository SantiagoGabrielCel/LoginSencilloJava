package Models;

import java.sql.*;

public class DBfuncs {
    public static final String DEFAULT_DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";
    //El puerto tiene que ser editado a criterio del usuario!
    public static final String DEFAULT_URL = "jdbc:mysql://localhost:3307/beltranvigilancia?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";

    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "root";//;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DEFAULT_DRIVER_CLASS);
        return DriverManager.getConnection( DEFAULT_URL,DEFAULT_USERNAME, DEFAULT_PASSWORD);
    }
    //Trabajando una llamada general de sp (de usarse)

    public static void PasaParametro(Object var1){
        Object LArray[] = {var1};


    }
}
