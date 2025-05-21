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
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
        // location, checkIn, checkOut, personnel 등 필터링
        if (request.getLocation() != null && request.getLocation().length() > 100) {
            throw new IllegalArgumentException("지역 정보가 너무 깁니다.");
        }
        if (!isValidDate(request.getCheckIn()) || !isValidDate(request.getCheckOut())) {
            throw new IllegalArgumentException("잘못된 날짜 형식입니다.");
        }

        List<String> allowed = List.of("breakfast", "pet", "barbecue", "pool");
        if (request.getExtras() != null) {
            request.setExtras(request.getExtras().stream()
                    .filter(allowed::contains)
                    .collect(Collectors.toList()));
        }

        return accomService.getSuggestions(request);
    }
    private String sanitize(String input) {
        return input == null ? "" : input.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }

    private boolean isValidDate(String date) {
        try {
            LocalDate.parse(date);
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }
}