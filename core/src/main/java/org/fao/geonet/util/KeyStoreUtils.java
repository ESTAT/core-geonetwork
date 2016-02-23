package org.fao.geonet.util;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.fao.geonet.kernel.setting.SettingManager;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Hex;

/**
 * Created by jose on 22/02/16.
 */
public class KeyStoreUtils {
    private static final String ALGO = "AES";
    private static final int KEYSZ = 256;// 128 default; 192 and 256 also possible

    public static SecretKey generateKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGO);
        keyGenerator.init(KEYSZ);
        SecretKey key = keyGenerator.generateKey();
        return key;
    }

    public static void saveKey(SecretKey key, SettingManager sm) {
        byte[] encoded = key.getEncoded();
        char[] hex = Hex.encodeHex(encoded);
        String data = String.valueOf(hex);
        sm.setValue("system/site/key", data);
    }

    public static SecretKey loadKey(SettingManager sm)  {
        String data = new String(sm.getValue("system/site/key"));
        char[] hex = data.toCharArray();
        byte[] encoded;
        try
        {
            encoded = Hex.decodeHex(hex);
        } catch (DecoderException e) {
            e.printStackTrace();
            return null;
        }
        SecretKey key = new SecretKeySpec(encoded, ALGO);
        return key;
    }

    public static String encrypt(String plainText, SecretKey secretKey)
            throws Exception {
        byte[] plainTextByte = plainText.getBytes();
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedByte = cipher.doFinal(plainTextByte);
        Base64 base64 = new Base64();
        String encryptedText = base64.encodeToString(encryptedByte);
        return encryptedText;
    }

    public static String decrypt(String encryptedText, SecretKey secretKey)
            throws Exception {
        Base64 base64 = new Base64();
        byte[] encryptedTextByte = base64.decode(encryptedText);
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decryptedByte = cipher.doFinal(encryptedTextByte);
        String decryptedText = new String(decryptedByte);
        return decryptedText;
    }
}
