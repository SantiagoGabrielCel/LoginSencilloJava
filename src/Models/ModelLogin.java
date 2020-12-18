package Models;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class ModelLogin {

    public static int pLlamadaLogin(String NombreSp , Connection Cn, String var1, String var2 ) throws SQLException {

            CallableStatement cst = Cn.prepareCall("{call " + NombreSp +"  (?,?,?)}");
            //{? = call MyStoredProcedure(?)}
            cst.setString(1,var1);
            cst.setString(2,var2);
            cst.registerOutParameter(3, Types.INTEGER);
            cst.execute();
            int oFallido = cst.getInt(3);
            return oFallido;
    }
    public static int pLlamadaHabilitado(String NombreSp , Connection Cn, String var1, String var2 ) throws SQLException {

        CallableStatement cst = Cn.prepareCall("{call " + NombreSp +"  (?,?,?)}");
        //{? = call MyStoredProcedure(?)}
        cst.setString(1,var1);
        cst.setString(2,var2);
        cst.registerOutParameter(3, Types.INTEGER);
        cst.execute();
        int oHab = cst.getInt(3);

        return oHab;

    }



}
