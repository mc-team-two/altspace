package com.mc.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

    @Value("${spring.mail.host}")
    private String host;

    @Value("${spring.mail.port}")
    private int port;

    @Value("${spring.mail.username}")
    private String username;

    @Value("${spring.mail.password}")
    private String password;

    @Value("${spring.mail.properties.mail.smtp.auth}")
    private boolean auth;

    @Value("${spring.mail.properties.mail.smtp.starttls.enable}")
    private boolean starttlsEnable;

    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(host);
        mailSender.setPort(port);
        mailSender.setUsername(username); // Jasypt로 암호화된 경우 자동으로 복호화된 값이 주입됨
        mailSender.setPassword(password); // Jasypt로 암호화된 경우 자동으로 복호화된 값이 주입됨
        mailSender.setDefaultEncoding("UTF-8");
        mailSender.setJavaMailProperties(getMailProperties()); // 메일 인증서버 정보 설정

        return mailSender;
    }

    // JavaMailSender의 속성을 설정하기 위한 Properties 객체 생성
    private Properties getMailProperties() {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", auth);
        // properties.put("mail.smtp.ssl.trust", host); // 필요에 따라 추가 (예: self-signed 인증서)
        // properties.put("mail.smtp.ssl.enable", "true"); // SSL 사용 시 (starttls와 동시 사용 불가)
        properties.put("mail.smtp.starttls.enable", starttlsEnable); // TLS 사용 설정
        // properties.put("mail.debug", "true"); // 디버그 로그 활성화 (문제 해결 시 유용)
        return properties;
    }
}