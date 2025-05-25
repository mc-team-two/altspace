package com.mc.util;

import com.mc.app.dto.AccomSuggestion;
import com.mc.app.dto.aiSuggest.ReviewSummary;
import com.mc.app.dto.aiSuggest.UserPreference;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Slf4j
@Component
public class GeminiUtil {

    @Value("${app.key.geminiKey}")
    private String API_KEY;

    private static final String MODEL_NAME = "gemini-2.0-flash";

    // 상위 호출 메서드: 여행용 프롬프트 + JSON 응답 요청
    public String askGeminiSuggestion(AccomSuggestion suggestion) {
        String prompt = buildSuggestionPrompt(suggestion);
        String suffix = "응답은 반드시 위 JSON 형식 그대로만 해주세요. 다른 말은 하지 마세요.";
        try {
            return askGemini(prompt, suffix);
        } catch (Exception e) {
            log.error("Gemini 호출 실패", e);
            return "{}"; // JSON 실패 방지용 빈 객체
        }
    }

    // Gemini API 호출 메서드
    public String askGemini(String prompt, String suffixInstruction) throws Exception {
        String fullPrompt = prompt + (suffixInstruction != null ? " " + suffixInstruction : "");
        String urlString = "https://generativelanguage.googleapis.com/v1beta/models/" + MODEL_NAME + ":generateContent?key=" + API_KEY;
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInput = String.format(
                "{\"contents\": [{\"parts\": [{\"text\": \"%s\"}]}]}",
                fullPrompt.replace("\n", "\\n").replace("\"", "\\\"") // JSON escape
        );

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonInput.getBytes("utf-8"));
        }

        int responseCode = conn.getResponseCode();
        InputStream input = responseCode == 200 ? conn.getInputStream() : conn.getErrorStream();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(input, "utf-8"))) {
            StringBuilder responseBuilder = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseBuilder.append(line.trim());
            }

            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(responseBuilder.toString());

            JSONArray candidates = (JSONArray) json.get("candidates");
            if (candidates != null && !candidates.isEmpty()) {
                JSONObject content = (JSONObject) ((JSONObject) candidates.get(0)).get("content");
                JSONArray parts = (JSONArray) content.get("parts");
                JSONObject part = (JSONObject) parts.get(0);
                return part.get("text").toString();
            } else {
                return "{}"; // 빈 JSON으로 반환
            }
        }
    }

    // 프롬프트 생성 메서드
    private String buildSuggestionPrompt(AccomSuggestion req) {
        StringBuilder sb = new StringBuilder();
        sb.append("다음은 여행 정보 요청입니다:\n");
        sb.append("장소: ").append(req.getLocation()).append("\n");
        sb.append("체크인: ").append(req.getCheckIn()).append("\n");
        sb.append("체크아웃: ").append(req.getCheckOut()).append("\n");
        sb.append("인원: ").append(req.getPersonnel()).append("명\n");
        if (req.getExtras() != null && !req.getExtras().isEmpty()) {
            sb.append("요청 옵션: ").append(String.join(", ", req.getExtras())).append("\n");
        }

        sb.append("\n아래 JSON 형식으로 응답해 주세요. 형식을 반드시 지켜주세요:\n");
        sb.append("{\n");
        sb.append("  \"weather\": \"기온과 옷차림 관련 팁\",\n");
        sb.append("  \"festival\": \"지역 축제 및 행사 정보\",\n");
        sb.append("  \"food\": \"맛집 정보\",\n");
        sb.append("  \"tips\": \"기타 여행 팁\",\n");
        sb.append("  \"maxTemp\": 숫자만 (예: 22),\n");
        sb.append("  \"minTemp\": 숫자만 (예: 15)\n");
        sb.append("}\n");

        sb.append("정보가 없으면 빈 문자열이나 null을 사용하세요. 응답에 다른 말은 절대 하지 마세요. 다음과 같은 JSON 형식으로만 응답해주세요. Markdown 코드 블록(```json)이나 설명 없이 JSON만 주세요.");
        return sb.toString();
    }

    // 🔥 UserPreference 기반 프롬프트 생성
    public String buildUserRecommendationPrompt(UserPreference userPref) {
        StringBuilder sb = new StringBuilder();
        sb.append("다음은 사용자의 숙소 이용 패턴입니다:\n\n");

        sb.append("✅ 예약한 숙소 ID: ").append(userPref.getBookedAccommodationIds()).append("\n");
        sb.append("✅ 찜 목록 숙소 ID: ").append(userPref.getWishlistAccommodationIds()).append("\n");

        if (userPref.getReviews() != null && !userPref.getReviews().isEmpty()) {
            sb.append("✅ 리뷰:\n");
            for (ReviewSummary review : userPref.getReviews()) {
                sb.append("- 숙소ID: ").append(review.getAccommodationId())
                        .append(", 평점: ").append(review.getGrade() != null ? review.getGrade() : "없음")
                        .append(", 내용: ").append(review.getComment() != null ? review.getComment() : "없음").append("\n");
            }
        } else {
            sb.append("✅ 리뷰: 없음\n");
        }

        sb.append("\n이 사용자의 취향을 분석해서 다음 형식으로 맞춤형 숙소 추천 목록을 JSON으로만 응답해 주세요.\n");
        sb.append("[\n");
        sb.append("  {\n");
        sb.append("    \"accommodationId\": 1,\n");
        sb.append("    \"name\": \"추천 숙소명\",\n");
        sb.append("    \"location\": \"위치\",\n");
        sb.append("    \"recommendationReason\": \"추천 이유\"\n");
        sb.append("  },\n");
        sb.append("  ...\n");
        sb.append("]\n");
        sb.append("응답에 다른 설명이나 마크다운, 코드블록 없이 JSON만 주세요.");

        return sb.toString();
    }

    // 🔥 UserPreference 기반으로 소비유형/선호유형 분석 프롬프트 생성
    public String buildUserConsumptionTypePrompt(UserPreference userPref) {
        StringBuilder sb = new StringBuilder();
        sb.append("너는 여행 숙소 추천 전문가야. 아래의 사용자가 최근 예약, 찜, 리뷰한 숙소 데이터를 기반으로 ")
                .append("이 사용자의 여행/소비 유형을 분석해줘.\n\n");

        sb.append("✅ 예약 숙소 ID: ").append(userPref.getBookedAccommodationIds()).append("\n");
        sb.append("✅ 찜 목록 숙소 ID: ").append(userPref.getWishlistAccommodationIds()).append("\n");

        if (userPref.getReviews() != null && !userPref.getReviews().isEmpty()) {
            sb.append("✅ 리뷰:\n");
            for (ReviewSummary review : userPref.getReviews()) {
                sb.append("- 숙소ID: ").append(review.getAccommodationId())
                        .append(", 평점: ").append(review.getGrade() != null ? review.getGrade() : "없음")
                        .append(", 내용: ").append(review.getComment() != null ? review.getComment() : "없음").append("\n");
            }
        } else {
            sb.append("✅ 리뷰: 없음\n");
        }

        sb.append("\n이 사용자의 소비유형과 선호 숙소 유형을 아래 형식으로 JSON으로만 응답해줘:\n\n");
        sb.append("{\n");
        sb.append("  \"consumptionType\": \"사용자의 여행/소비 유형 (한 문장)\",\n");
        sb.append("  \"consumptionTypeDescription\": \"소비 유형에 대한 간단한 설명 (한 문장)\",\n");
        sb.append("  \"favoriteAccommodationType\": \"선호 숙박유형 (쉼표로 구분된 문자열)\"\n");
        sb.append("}\n\n");

        sb.append("✅ 유형 예시는 다음과 같아:\n");
        sb.append("- 짧고 자주 가는 여행자: 짧은 일정으로 여행을 자주 떠나며, 교통 편리성과 빠른 예약을 중시\n");
        sb.append("- 호캉스 중심 여행자: 숙소 내 휴식과 고급스러운 경험을 중시. 뷰, 수영장, 룸서비스 등 부대시설 선호\n");
        sb.append("- 자연 속 힐링파: 자연 속에서의 조용한 휴식을 선호. 숲속 리조트, 한적한 펜션 선호\n");
        sb.append("- 맛집 탐험가: 여행지의 먹거리와 맛집을 탐험. 맛집과 가까운 위치의 숙소 선호\n");
        sb.append("- 가족 중심 여행자: 가족 단위 여행이 많고, 키즈존·패밀리룸 등 편의시설을 중시\n");
        sb.append("- 액티비티 애호가: 숙소 근처에서 즐길 수 있는 레저/액티비티를 중요시. 서핑, 스키, MTB 등 계절별 스포츠\n");
        sb.append("- 전통/문화 탐방객: 전통문화, 유적지, 로컬 체험 위주의 여행을 선호. 한옥스테이·문화유산 근처 숙소 선호\n");
        sb.append("- 럭셔리 & 프리미엄: 고급스러운 인테리어와 서비스 중시. 풀빌라, 럭셔리 호텔, 스위트룸 등 선호\n");
        sb.append("- 장기 투숙형: 출장·여행으로 장기간 머무는 타입. 주방·세탁시설 완비된 레지던스 숙소 선호\n");
        sb.append("- 커플/로맨틱 여행자: 프라이빗한 공간과 로맨틱한 분위기를 중요시. 야경, 루프탑, 감각적인 인테리어 선호\n");

        sb.append("\n숙소 ID나 내부 코드명은 응답하지 말고, 실제 숙소 유형/스타일/분위기만 알려줘.");
        sb.append("\n응답은 반드시 위에 언급한 짧고 자주 가는 여행자, 호캉스 중심 여행자, 자연 속 힐링파, 맛집 탐험가, 가족 중시 여행자, 액티비티 애호가, 전통/문화 탐방객, 력셔리 & 프리미엄, 장기 투숙형, 커플/로맨틱 여행자 유형 안에서만 응답해줘. 다른 응답은 절대로 하지 말아줘.");
        sb.append("\n \n" +
                "  \"consumptionType\": \"특정 숙소\" 키워드 같은 건 절대로 넣지 마세요.");
        sb.append("\n \n" +
                "  추론 사유도 그럴듯한 걸 넣어주세요.");
        sb.append("응답에 다른 설명이나 마크다운, 코드블록 없이 JSON만 주세요.");

        return sb.toString();
    }
}