package Models;

import com.sun.org.apache.xml.internal.security.utils.Base64;
//Estos imports van para la parte de encriptar md5
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;

import javax.swing.*;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Logica {
    //VALIDAR REGEX
    public static boolean Regxvalidar(Object Cadena, String patron) {
        //ARMO OBJETO PATTERN
        Pattern p = Pattern.compile(patron);
        //MATCHEO con cadena
        Matcher matCadena = p.matcher(String.valueOf(Cadena));
        if (matCadena.matches() == true) {
            return true;
        } else {
            return false;
        }

    }

}
