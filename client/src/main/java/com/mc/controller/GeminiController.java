package com.mc.controller;

import com.google.gson.Gson;
import com.mc.app.dto.AccomSuggestion;
import com.mc.app.dto.TravelInsight;
import com.mc.app.service.AccomService;
import com.mc.msg.GeminiMsg;
import com.mc.util.GeminiUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class GeminiController {

    private final SimpMessagingTemplate template;
    private final GeminiUtil geminiUtil;
    private final AccomService accomService;

    @MessageMapping("/geminichat")
    public void handleGemini(@Payload GeminiMsg msg) {
        log.info("Gemini 메시지 수신: {}", msg);

        try {
            String reply = geminiUtil.askGemini(msg.getContent(), "간결하고 명확하게 답변해 주세요.");
            msg.setContent(reply);
            template.convertAndSend("/sub/gemini", msg);
        } catch (Exception e) { // Exception으로 변경하여 askGemini에서 던지는 예외를 모두 처리
            log.error("Gemini 응답 실패", e);
            msg.setContent("[Gemini 응답 실패]");
            template.convertAndSend("/sub/gemini", msg);
        }
    }

    // 일반 검색과 동시에, 한번 더 검색 조건들을 서버에 전송, 제미나이를 통해 응답을 내려받는 컨트롤러.
    @PostMapping("/search-accomsuggestions")
    @ResponseBody
    public TravelInsight getSuggestions(@RequestBody AccomSuggestion request) throws Exception {
        return accomService.getSuggestions(request);
    }
}