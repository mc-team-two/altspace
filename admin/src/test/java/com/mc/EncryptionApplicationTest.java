package com.mc;

import com.mc.config.JasyptConfig;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootTest
@Slf4j
public class EncryptionApplicationTest {

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private StandardPBEStringEncryptor standardPBEStringEncryptor;

    @Test
    void contextLoads() {
        String name = "이말숙";
        String pwd = "password123!!";

        String jName = standardPBEStringEncryptor.encrypt(name);
        String jPwd = bCryptPasswordEncoder.encode(pwd);

        System.out.println("암호화된 이름: " + jName);
        System.out.println("암호화된 패스워드: " + jPwd);

        System.out.println("복호화된 이름: " + standardPBEStringEncryptor.decrypt(jName));
        System.out.println("패스워드 매칭: " + bCryptPasswordEncoder.matches(pwd, jPwd));
    }
}
