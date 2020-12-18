package Controller;

import Models.DBfuncs;
import Models.Seguridad;
import Models.ConexionesSMTP;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javax.mail.*;
import java.sql.*;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RecuperarcontController {

   @FXML
   public TextField TXTmail;
   @FXML
   public Button BTNenviar;

@FXML
    public void Validar(MouseEvent event) throws SQLException{
        String texto = "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$";
        Pattern pattern = Pattern.compile(texto, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher (this.TXTmail.getText ());

        if  (matcher.find()){


            try
            {
                //DBfuncs new_instance_connection = new DBfuncs(); // Creamos una instancia a la base de datos
                //Connection open_connection = new_instance_connection.connect(); // Abrimos la conexion a la base de datos

                DBfuncs new_instance=new DBfuncs();
                Connection open_connection = new_instance.getConnection ();

                PreparedStatement query_mail = open_connection.prepareStatement("SELECT mail FROM usuarios;"); // realizamos una consulta sobre la tabla usuarios
                ResultSet answerset = query_mail.executeQuery(); // El resultado de la consulta lo depositamos en un objeto ResultSet (este objeto es como un array)

                boolean flag = false;
                while(answerset.next() || flag==false) // Esta funcion devuelve true o false si es que puede o no seguir recorriendo el array de resultados
                {
                    if(answerset.getString (1).equals (this.TXTmail.getText ()))
                    {
                        flag = true;
                    }
                }
                //new_instance_connection.disconect();

                PreparedStatement query_password = open_connection.prepareStatement("SELECT contrasenia FROM usuarios where mail like '"+this.TXTmail.getText()+"';"); // realizamos una consulta sobre la tabla usuarios para la contrasenia

                answerset = query_password.executeQuery();
                answerset.next ();
                if(flag)
                {
                    MOSTRARMENSAJEINFO (" Mail encontrado, usted esta registrado ");
                    ConexionesSMTP new_connection = new ConexionesSMTP(); // Llamo al objeto ConexionSMTP
                    Session open_session=new_connection.Open_session(); // Abro una sesion en el servidor SMTP
                    new_connection.send_Message
                            (
                                    open_session,
                                     this.TXTmail.getText (),
                                    "Recuperar Contraseña",
                                    "Estimado,\n\tLe informamos que su contraseña es:\n\t\t" + Seguridad.decrypt(String.valueOf(answerset.getString (1)),"S"));
                            ; // Mando el mail pasandole por parametros el destinatario, asunto y cuerpo del mail.

                    MOSTRARMENSAJEINFO ("Le enviamos un correo elctronico porfavor verifique ");
                }
                else
                {
                    MOSTRARMENSAJEERROR ("El mail ingresado no existe en nuestros registros.\nPor favor, registrese.");
                }




            }
            catch(NullPointerException e) // la conexion es nula
            {
                System.out.println("Cancelo dentro del main por el siguiente error: " + e.getMessage());
            }
            catch(SQLException e)
            {
                System.out.println("Cancelo dentro del main por el siguiente error: " + e.getMessage());
                e.getErrorCode();
            }
            catch (Exception e)
            {
                System.out.println(e.getMessage());
            }
        }


        else
        {
            MOSTRARMENSAJEERROR (" Mail no encontrado ");
        }
    }









@FXML
    public void MOSTRARMENSAJEINFO (String mensaje){
    Alert alert=new Alert (Alert.AlertType.INFORMATION);
    alert.setTitle ("CONFIRMADO");
    alert.setHeaderText (null);
    alert.setContentText (mensaje);
    alert.showAndWait ();


}


    @FXML
    public void MOSTRARMENSAJEERROR (String mensaje){
        Alert alert=new Alert (Alert.AlertType.ERROR);
        alert.setTitle ("ERROR");
        alert.setHeaderText (null);
        alert.setContentText (mensaje);
        alert.showAndWait ();


    }









}
