package com.mc.app.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.app.dto.PopularLocation;
import com.mc.app.dto.aiSuggest.PersonalizedRecommendation;
import com.mc.app.dto.aiSuggest.UserConsumptionAnalysis;
import com.mc.app.dto.aiSuggest.UserPreference;
import com.mc.app.repository.GeminiRepository;
import com.mc.util.GeminiUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
@Slf4j
@Service
@RequiredArgsConstructor
public class GeminiService {
    private final GeminiRepository geminiRepository;
    private final GeminiUtil geminiUtil;
    private final ObjectMapper objectMapper;
    // 🔥 삭제: private final StringEncryptor encryptor;  // 필요 X

    public List<PopularLocation> getPopularStats() throws Exception {
        return geminiRepository.selectPopularLocations();
    }

    // ✅ 평문 userId로 바로 조회
    public UserPreference getUserPreferenceData(String userId) {
        log.info("🌟 평문 userId로 조회: {}", userId);
        return geminiRepository.selectUserPreferenceData(userId);
    }

    public List<PersonalizedRecommendation> getPersonalizedRecommendations(UserPreference userPref) {
        try {
            String prompt = geminiUtil.buildUserRecommendationPrompt(userPref);
            String aiResponse = geminiUtil.askGemini(prompt, null);

            log.info("AI 응답: {}", aiResponse);

            aiResponse = aiResponse.replaceAll("(?s)```(json)?\\s*(.*?)\\s*```", "$2").trim();

            return objectMapper.readValue(aiResponse, new TypeReference<List<PersonalizedRecommendation>>() {});
        } catch (Exception e) {
            log.error("AI 추천 결과 파싱 실패!", e);
            return Collections.emptyList();
        }
    }

    public UserConsumptionAnalysis getUserConsumptionAnalysis(UserPreference userPref) {
        try {
            String prompt = geminiUtil.buildUserConsumptionTypePrompt(userPref);
            String aiResponse = geminiUtil.askGemini(prompt, null);

            log.info("AI 응답: {}", aiResponse);

            if (aiResponse.startsWith("```")) {
                aiResponse = aiResponse.replaceAll("```(json)?", "").trim();
            }

            return objectMapper.readValue(aiResponse, UserConsumptionAnalysis.class);
        } catch (Exception e) {
            log.error("소비 유형 분석 실패!", e);
            return null;
        }
    }
}