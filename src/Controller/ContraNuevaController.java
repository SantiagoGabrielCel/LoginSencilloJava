package Controller;

import Models.DBfuncs;
import Models.Seguridad;
import Models.Logica;
import javafx.fxml.FXML;
import javafx.event.ActionEvent;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.*;

public class ContraNuevaController {
    String sEncriptado = "S";
    @FXML
    private PasswordField pwdNueva;

    @FXML
    private PasswordField pwdRepetir;

    @FXML
    private PasswordField pwdVieja;

    @FXML
    private TextField txtMail;

    @FXML
    void eConNuevaEnv(ActionEvent event) throws SQLException {
        Connection Con = null;
        try {
            Con =  DBfuncs.getConnection();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        if(Logica.Regxvalidar(txtMail.getText(),"^[^@]+@[^@]+\\.[a-zA-Z]{2,}$")== false){
            Errores("No corresponde con el formato de usuario correspondiente (MAIL)");
        }
            else if (pwdNueva.getText().equals(pwdRepetir.getText())){
                //System.out.println(Seguridad.encrypt(pwdNueva.getText(),sEncriptado));
                String sNuevaEncriptada = Seguridad.encrypt(pwdNueva.getText(),sEncriptado);

                try {
                    PreparedStatement ps1 = Con.prepareStatement("UPDATE beltranvigilancia.usuarios SET contrasenia = ? WHERE mail = ? and contrasenia = ?");
                    ps1.setString(1, sNuevaEncriptada);
                    ps1.setString(2, txtMail.getText());
                    ps1.setString(3, pwdVieja.getText());


                    ps1.executeUpdate();
                    JOptionPane.showMessageDialog(null, "Actualizacion completada");
                    ps1.close();
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                Errores("Las contraseñas no son iguales.");

            }
    }

    public void Errores(String sCampo ){
        JOptionPane.showMessageDialog(null,sCampo);
    }




}
