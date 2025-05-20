package com.mc.util;

import com.mc.app.dto.AccomSuggestion;
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
}