package Models;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Seguridad {

    private static SecretKeySpec secretKey;
    private static byte[] key;

    public static void setKey(String myKey)
    {
        MessageDigest sha = null;
        try {
            key = myKey.getBytes("UTF-8");
            sha = MessageDigest.getInstance("SHA-1");
            key = sha.digest(key);
            key = Arrays.copyOf(key, 16);
            secretKey = new SecretKeySpec(key, "AES");
        }
        catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    public static String encrypt(String strToEncrypt, String secret)
    {
        try
        {
            setKey(secret);
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
        }
        catch (Exception e)
        {
            System.out.println("Error en encriptado: " + e.toString());
        }
        return null;
    }

    public static String decrypt(String strToDecrypt, String secret)
    {
        try
        {
            setKey(secret);
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
        }
        catch (Exception e)
        {
            System.out.println("Error al desencriptar : " + e.toString());
        }
        return null;
    }
    public static String getHash(String txt, String hashType) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance( hashType );
            byte[] array = md.digest( txt.getBytes() );
            StringBuffer sb = new StringBuffer();

            for (int i = 0; i < array.length; i++) {
                sb.append( Integer.toHexString( (array[i] & 0xff) | 0x100 ).substring( 1, 3 ) );
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            System.out.println( e.getMessage() );
        }
        return null;
    }

    public static String md5(String txt) {
        return Seguridad.getHash( txt, "MD5" );
    }

    public static String sha2(String txt) {
        return Seguridad.getHash( txt, "SHA1" );
    }


}

// Algoritmo viejo
    //public static String pEncripta(String sTextoAEncriptar){
//
    //    String textoSinEncriptar= sTextoAEncriptar;
    //    String textoEncriptadoConSHA=DigestUtils.sha1Hex(textoSinEncriptar);
    //    System.out.println("Texto Encriptado con SHA : "+textoEncriptadoConSHA);
    //    return textoEncriptadoConSHA;
    //}


