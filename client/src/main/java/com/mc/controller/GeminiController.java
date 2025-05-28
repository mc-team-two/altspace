package com.mc.controller;

import com.mc.app.service.AccomService;
import com.mc.app.service.GeminiService;
import com.mc.msg.GeminiMsg;
import com.mc.util.GeminiUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

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
            String reply = geminiUtil.askGemini(msg.getContent(), "간결하고 명확하게 답변해 주세요.");
            msg.setContent(reply);
            template.convertAndSend("/sub/gemini", msg);
        } catch (Exception e) {
            log.error("Gemini 응답 실패", e);
            msg.setContent("[Gemini 응답 실패]");
            template.convertAndSend("/sub/gemini", msg);
        }
    }
}