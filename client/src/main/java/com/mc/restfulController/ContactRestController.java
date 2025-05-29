package com.mc.restfulController;

import com.mc.app.service.EmailService;
import com.mc.common.response.ResponseMessage;
import com.mc.util.EmailUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/contact")
public class ContactRestController {

    private final EmailService emailService;

    @PostMapping("/send-email")
    public ResponseEntity<?> sendEmail(
            @RequestParam("username")String username,
            @RequestParam("subject")String subject,
            @RequestParam("content")String content,
            @RequestParam("email")String email) {

        String formattedContents = EmailUtil.htmlFormatter(subject, content, email);
        try {
            emailService.sendEmail("biz.altspace@gmail.com",
                    "고객센터 문의",
                    formattedContents);
            return ResponseEntity
                    .status(ResponseMessage.SUCCESS.getStatus())
                    .body(ResponseMessage.SUCCESS.getMessage());
        } catch (Exception e) {
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }
}
