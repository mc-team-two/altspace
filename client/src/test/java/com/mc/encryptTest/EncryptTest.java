package com.mc.encryptTest;

import org.jasypt.encryption.StringEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.beans.factory.annotation.Value;

@SpringBootTest
public class EncryptTest {

    @Autowired
    private StringEncryptor jasyptStringEncryptor;

    @Value("${app.key.naverApiSecretKey}")
    private String naverApiSecretKeyApiKey; // application.yml에서 암호화된 값 읽기

    @Test
    void decryptValue() {
        String decryptedValue = jasyptStringEncryptor.decrypt(naverApiSecretKeyApiKey.substring(6, naverApiSecretKeyApiKey.length() - 1));
        System.out.println("복호화된 Weather API 키: " + decryptedValue);
        // 필요하다면 복호화된 값이 예상한 값과 일치하는지 assertion을 추가합니다.
        // assertEquals("your_actual_weather_api_key", decryptedValue);
    }
}