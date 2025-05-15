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
        } catch (Exception e) { // Exception으로 변경하여 askGemini에서 던지는 예외를 모두 처리
            log.error("Gemini 응답 실패", e);
            msg.setContent("[Gemini 응답 실패]");
            template.convertAndSend("/sub/gemini", msg);
        }
    }
}