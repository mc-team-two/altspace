package com.mc;

import com.mc.app.service.EmailService;
import jakarta.mail.MessagingException;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class MailApplicationTests {

    @Autowired
    private EmailService emailService;

    @Test
    void sendEmailTest() {
        try {
            String to = "lee-yejin@naver.com";
            String subject = "테스트 제목";
            String content = "테스트 내용";
            emailService.sendEmail(to, subject, content);
            log.info("메일 전송 성공!");
        } catch (MessagingException e) {
            log.info("메일 전송 실패! : " + e.getMessage());
        }
    }
}
