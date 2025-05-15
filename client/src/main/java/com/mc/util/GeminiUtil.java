package com.mc.util;

import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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

    public String askGemini(String prompt) throws Exception {
        String constrainedPrompt = prompt + ". 답변을 간결하게 (130자 내외) 요약해 주세요.";
        // 130자로 요약해주세요 라고 했더니 '알겠습니다! 130자 내외로 간결하게 답변해 드리겠습니다.' 라는 답변으로 시작해서 표현을 변경

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
                try {
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
                } catch (ParseException e) {
                    log.error("JSON 파싱 오류", e);
                    return "Failed to parse response.";
                }
            }
        } else if (responseCode == 401) {
            throw new RuntimeException("Failed : HTTP error code : 401 Unauthorized. Please check your API key and permissions.");
        } else if (responseCode == 400) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"))) {
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
                throw new RuntimeException("Failed : HTTP error code : 400 Bad Request. Response: " + response.toString());
            }
        } else {
            throw new RuntimeException("Failed : HTTP error code : " + responseCode);
        }
    }
}