package com.mc.controller;

import com.mc.app.dto.*;
import com.mc.app.dto.aiSuggest.UserPreference;
import com.mc.app.dto.aiSuggest.UserPreferenceRequest;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@Slf4j
@RequiredArgsConstructor
public class GeminiController {

    private final SimpMessagingTemplate template;
    private final GeminiUtil geminiUtil;
    private final AccomService accomService;
    private final GeminiService geminiService;

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

    @PostMapping("/search-accomsuggestions")
    @ResponseBody
    public TravelInsight getSuggestions(@RequestBody AccomSuggestion request) throws Exception {
        if (request.getLocation() != null && request.getLocation().length() > 100) {
            throw new IllegalArgumentException("지역 정보가 너무 깅니다.");
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

    // 개인화 추천 사용자 데이터 조회
    @PostMapping("/search-usersuggestions")
    @ResponseBody
    public UserPreference getUserSuggestions(@RequestBody UserPreferenceRequest request) {
        // 이 시점에서 AI로 보내기 전, DB에서 사용자 취향 데이터 조회
        return geminiService.getUserPreferenceData(request.getUserId());
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