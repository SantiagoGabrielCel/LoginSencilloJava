package Models;

import javafx.fxml.FXML;

import javax.mail.*;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class ConexionesSMTP
{
    private static String remitente = "seminariolanda44@gmail.com";  //Para la dirección nomcuenta@gmail.com
    private static String password= "landa2000";
    private static Properties props;
    public ConexionesSMTP()
    {
        props = System.getProperties(); // Nos traemos las propiedades para empezar a tratarlas
        props.put("mail.smtp.host", "smtp.gmail.com");  //El servidor SMTP de Google
        props.put("mail.smtp.user", remitente); // Usuario de google que va a enviar los mails
        props.put("mail.smtp.password", password); //La clave de la cuenta
        props.put("mail.smtp.auth", "true");    //Usar autenticación mediante usuario y clave
        props.put("mail.smtp.starttls.enable", "true"); //Para conectar de manera segura al servidor SMTP
        props.put("mail.smtp.port", "587"); //El puerto SMTP seguro de Google
    }

    public static Session Open_session()
    {
        Session session=Session.getDefaultInstance(props); // Instanciamos una sesion de google para abrir la cuenta
        return session; // retornamos la sesion abierta
    }

    public static void send_Message(Session session, String destinatario, String asunto, String cuerpo)
    {
        MimeMessage message = new MimeMessage(Session.getInstance(props)); // Preparamos el objeto para armar el mail.

        try {
            message.setFrom(new InternetAddress(remitente)); //Seteamos el remitente del mensaje
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario)); // Le informamos hacia quien va dirigido el mensaje (destino)
            //Se podrían añadir varios de la misma manera (Linea 42)
            message.setSubject(asunto); // Informamos el asunto del mail
            message.setText(cuerpo); // Informamos el cuerpo o descripcion del mail

            // A partir de aqui realizamos el envio.
            Transport transport = session.getTransport("smtp"); // Indicamos el protocolo a utilizar para enviar el mail -> SMTP
            transport.connect("smtp.gmail.com", remitente, password); // Nos conectamos al gmail que enviará el mail
            transport.sendMessage(message, message.getAllRecipients()); // Enviamos el mail al destinatario o destinatarios
            transport.close(); // Cerramos la conexion luego de enviar el mail
        }
        catch (MessagingException me) {
            me.printStackTrace();   //Si se produce un error
            System.out.println("El codigo fallo arrojando el siguiente error: "+ me.getMessage());
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }
    }
}