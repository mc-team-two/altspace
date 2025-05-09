package com.mc.util;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class EncryphtUtil {
    public class EncryptUtil {
        public static void main(String[] args) {
            StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
            encryptor.setPassword("YOUR_JASYPT_PASSWORD_FROM_STEP_1");
            encryptor.setAlgorithm("PBEWITHHMACSHA512ANDAES");
            String plainTextApiKey = "YOUR_NEW_PLAIN_TEXT_API_KEY";
            String encryptedApiKey = encryptor.encrypt(plainTextApiKey);
            System.out.println("Encrypted API Key: " + encryptedApiKey);
        }
    }
}
