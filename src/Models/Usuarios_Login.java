package Models;
import java.io.UnsupportedEncodingException;
import java.sql.Date;



public class Usuarios_Login {
    public Integer getIDUsuario() {
        return IDUsuario;
    }

    public void setIDUsuario(Integer IDUsuario) {
        this.IDUsuario = IDUsuario;
    }

    private Integer IDUsuario;


    public String getContraseña() {
        return Contraseña;
    }

    public void setContraseña(String contraseña) {
        Contraseña = contraseña;
    }

    public String getMail() {
        return Mail;
    }

    public void setMail(String mail) {
        Mail = mail;
    }

    private String Contraseña;
    private String Mail;

}
