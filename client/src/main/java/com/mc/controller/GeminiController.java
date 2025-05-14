package com.mc.controller;

import com.mc.msg.GeminiMsg;
import com.mc.util.GeminiUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.io.IOException;

@Controller
@Slf4j
@RequiredArgsConstructor
public class GeminiController {

    private final SimpMessagingTemplate template;
    private final GeminiUtil geminiUtil;

    @MessageMapping("/geminichat")
    public void handleGemini(@Payload GeminiMsg msg) {
        log.info("Gemini 메시지 수신: {}", msg);

        try {
            String reply = geminiUtil.askGemini(msg.getContent());
            msg.setContent(reply);
            template.convertAndSend("/sub/gemini", msg);
        } catch (IOException e) { // InterruptedException 제거
            log.error("Gemini 응답 실패 (IOException)", e);
            msg.setContent("[Gemini 응답 실패 - I/O 오류]");
            template.convertAndSend("/sub/gemini", msg);
        }
    }
}