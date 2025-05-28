package com.mc.restfulController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.app.dto.AccomSuggestion;
import com.mc.app.dto.PopularLocation;
import com.mc.app.dto.TravelInsight;
import com.mc.app.dto.aiSuggest.PersonalizedRecommendation;
import com.mc.app.dto.aiSuggest.UserConsumptionAnalysis;
import com.mc.app.dto.aiSuggest.UserPreference;
import com.mc.app.dto.aiSuggest.UserPreferenceRequest;
import com.mc.app.service.AccomService;
import com.mc.app.service.GeminiService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("api/gemini")
@Slf4j
@AllArgsConstructor
public class GeminiRestController {

    private final AccomService accomService;
    private final GeminiService geminiService;

    // ✅ 인기 지역 통계 조회
    @GetMapping("/get-popular-stats")
    public List<PopularLocation> getPopularStats() {
        try {

            List<PopularLocation> stats = geminiService.getPopularStats();
            log.info("🔥 인기 지역 통계: {}", stats);  // 로그로 확인

            ObjectMapper mapper = new ObjectMapper();
            String statsJson = mapper.writeValueAsString(stats);

            log.info("📦 JSON 변환 결과: {}", statsJson);  // JSON 결과도 출력

            return geminiService.getPopularStats();
        } catch (Exception e) {
            log.error("🔥 인기 지역 통계 조회 실패!", e);
            return Collections.emptyList();
        }
    }

    // ✅ 숙소 추천 (사용자 조건 기반)
    @PostMapping("/search-accomsuggestions")
    public TravelInsight getSuggestions(@Valid @RequestBody AccomSuggestion request) throws Exception {
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

    // ✅ 사용자 개인화 추천 데이터 조회
    @PostMapping("/search-usersuggestions")
    public UserPreference getUserSuggestions(@RequestBody UserPreferenceRequest request) {
        if (request.getUserId() == null || request.getUserId().isBlank()) {
            throw new IllegalArgumentException("userId가 없습니다.");
        }
        return geminiService.getUserPreferenceData(request.getUserId());
    }

    /**
     * ✅ 사용자 AI 추천 및 분석 데이터 조회 (새로 추가)
     * 클라이언트에서 이 API를 호출하여 데이터를 비동기적으로 가져옵니다.
     * UserPreferenceRequest 대신 userId를 직접 @RequestParam으로 받거나,
     * 세션에서 userId를 가져오는 로직이 필요합니다.
     * 여기서는 편의상 userId를 @RequestParam으로 받는 예시를 들었습니다.
     */
    @GetMapping("/user-ai-data")
    public ResponseEntity<Map<String, Object>> getUserAiData(@RequestParam("userId") String userId) {
        log.info("🌟 평문 userId로 조회: {}", userId);
        Map<String, Object> response = new HashMap<>();
        try {
            UserPreference userPref = geminiService.getUserPreferenceData(userId);

            if (userPref == null) {
                log.warn("⚠️ userPref가 비어있습니다. (userId={})", userId);
                response.put("success", false);
                response.put("message", "해당 사용자의 취향 데이터가 없습니다.");
                return ResponseEntity.status(HttpStatus.OK).body(response);  // 200으로 JSON 보장
            }

            List<PersonalizedRecommendation> recommendations = geminiService.getPersonalizedRecommendations(userPref);
            UserConsumptionAnalysis analysis = geminiService.getUserConsumptionAnalysis(userPref);

            response.put("aiRecommendations", recommendations);
            response.put("consumptionAnalysis", analysis);
            response.put("success", true);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("🔥 사용자 AI 데이터 조회 실패!", e);
            response.put("success", false);
            response.put("message", "사용자 AI 데이터 조회에 실패했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);  // 500도 JSON으로!
        }
    }



    // ✅ yyyy-MM-dd 날짜 형식 검사
    private boolean isValidDate(String date) {
        try {
            LocalDate.parse(date);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}