package Controller;
import Models.*;
import javafx.application.Platform;
import javafx.embed.swing.JFXPanel;
import javafx.fxml.FXML;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.stage.Stage;
import javafx.stage.Modality;
import javafx.stage.StageStyle;
import javafx.fxml.FXMLLoader;
import javafx.event.ActionEvent;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.*;

public class LoginController {
    String sEncriptado = "S";

    int idUsu;
    @FXML
    private TextField txtUsuario;

    @FXML
    private Button btnCambia;

    @FXML
    private PasswordField pwdPassField;

    private JFXPanel primaryStage;

    @FXML
    void eIngresar(ActionEvent event) throws SQLException {
        Connection Con = null;
        try {
            Con =  DBfuncs.getConnection();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        if(Logica.Regxvalidar(txtUsuario.getText(),"^[^@]+@[^@]+\\.[a-zA-Z]{2,}$")== false){
            Errores("No corresponde con el formato de usuario correspondiente (MAIL)");
        }
        else if(ModelLogin.pLlamadaLogin("sp_in_login",Con,txtUsuario.getText(), Seguridad.encrypt(pwdPassField.getText(),sEncriptado))!= 0 ){
            String sPrueba = Seguridad.encrypt(pwdPassField.getText(),sEncriptado);
            System.out.println(sPrueba);
            Errores("Password o Mail incorrecto");
            if(ModelLogin.pLlamadaHabilitado("sp_chequeahab",Con,txtUsuario.getText(), Seguridad.encrypt(pwdPassField.getText(),sEncriptado))!=1){
                Errores("Su Usuario se encuentra deshabilitado");
            }
        }
        else{
            JOptionPane.showMessageDialog(null,"Ingreso exitoso!");
            //PARA EL ID DE USUARIO
            String sContraEncrip = Seguridad.encrypt(pwdPassField.getText(),sEncriptado);

            PreparedStatement ps1 = Con.prepareStatement("SELECT id_usuario from  beltranvigilancia.usuarios WHERE contrasenia = ? ");
            ps1.setString(1, sContraEncrip);

            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                idUsu = rs.getInt("id_usuario");

            }
            //objeto
            Usuarios_Login u = new Usuarios_Login();
            u.setMail(txtUsuario.getText());
            u.setIDUsuario(idUsu);
            u.setContraseña(pwdPassField.getText());

            System.out.println(u.getMail());
            System.out.println(u.getIDUsuario());

            System.out.println(sContraEncrip);
            String sPrueba = Seguridad.encrypt(pwdPassField.getText(),sEncriptado);
            System.out.println(sPrueba);

        }

    }

    @FXML
    void eSalir(ActionEvent event) {
        Platform.exit();
    }

    @FXML
    void eRecuperar (ActionEvent event) {
        try
        {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("../Views/Recuperarcont.fxml"));
            Parent root1 = (Parent)fxmlLoader.load();
            Stage stage = new Stage();
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.initStyle(StageStyle.DECORATED);
            stage.setTitle("Recuperar Password");
            stage.setScene(new Scene(root1));
            stage.showAndWait();


        }
        catch (Exception E)
        {
            Errores(E.getMessage());
        }
    }

    @FXML
    void eCambia (ActionEvent event) {
        try
        {
            FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("../Views/ContraNueva.fxml"));
            Parent root1 = (Parent)fxmlLoader.load();
            Stage stage = new Stage();
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.initStyle(StageStyle.DECORATED);
            stage.setTitle("Contraseña Nueva");
            stage.setScene(new Scene(root1));
            stage.showAndWait();


        }
        catch (Exception E)
        {
            Errores(E.getMessage());
        }
    }




    public void Errores(String sCampo ){
        JOptionPane.showMessageDialog(null,sCampo);
    }

}
