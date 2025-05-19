package com.mc.util;

import com.mc.app.dto.AccomSuggestion;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@Slf4j
@Component
public class GeminiUtil {

    @Value("${app.key.geminiKey}")
    private String API_KEY;

    private static final String MODEL_NAME = "gemini-2.0-flash";

    // 1. 상위 호출 메서드: 여행 제안 전용
    public String askGeminiSuggestion(AccomSuggestion suggestion) throws Exception {
        String prompt = buildSuggestionPrompt(suggestion);
        return askGemini(prompt, "130자 이내로 간결하게 정리해서 말해줘.");
    }

    // 2. 공통 Gemini 호출 메서드
    public String askGemini(String prompt, String suffixInstruction) throws Exception {
        String constrainedPrompt = prompt + (suffixInstruction != null ? " " + suffixInstruction : "");

        String urlString = "https://generativelanguage.googleapis.com/v1beta/models/" + MODEL_NAME + ":generateContent?key=" + API_KEY;
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String jsonInputString = String.format(
                "{\"contents\": [{\"parts\": [{\"text\": \"%s\"}]}]}",
                constrainedPrompt.replace("\n", "\\n")
        );

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }

                JSONParser parser = new JSONParser();
                JSONObject jsonResponse = (JSONObject) parser.parse(response.toString());
                if (jsonResponse.containsKey("candidates")) {
                    JSONArray candidates = (JSONArray) jsonResponse.get("candidates");
                    StringBuilder message = new StringBuilder();
                    for (Object candidateObj : candidates) {
                        JSONObject candidate = (JSONObject) candidateObj;
                        JSONObject content = (JSONObject) candidate.get("content");
                        JSONArray parts = (JSONArray) content.get("parts");
                        for (Object partObj : parts) {
                            JSONObject part = (JSONObject) partObj;
                            message.append(part.get("text")).append("\n");
                        }
                    }
                    return message.toString().trim();
                } else {
                    return "No candidates found in the response.";
                }
            }
        } else if (responseCode == 401) {
            throw new RuntimeException("Unauthorized. Please check your API key.");
        } else if (responseCode == 400) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"))) {
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
                throw new RuntimeException("Bad Request: " + response);
            }
        } else {
            throw new RuntimeException("HTTP error code: " + responseCode);
        }
    }

    // 3. Prompt 생성 메서드 (여행용)
    private String buildSuggestionPrompt(AccomSuggestion req) {
        StringBuilder sb = new StringBuilder();
        sb.append("사용자가 여행 정보를 요청했습니다.\n");
        sb.append("장소: ").append(req.getLocation()).append("\n");
        sb.append("체크인: ").append(req.getCheckIn()).append("\n");
        sb.append("체크아웃: ").append(req.getCheckOut()).append("\n");
        sb.append("인원: ").append(req.getPersonnel()).append("명\n");
        if (req.getExtras() != null && !req.getExtras().isEmpty()) {
            sb.append("요청 옵션: ").append(String.join(", ", req.getExtras())).append("\n");
        }
        sb.append("200자 정도도 괜찮으니, 날씨, 옷차림, 지역 축제, 치안 정보 등 여행에 필요한 팁을 알려주세요.");
        return sb.toString();
    }
}