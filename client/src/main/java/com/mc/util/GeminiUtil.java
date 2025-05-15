package com.mc.util;

import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

@Slf4j
public class GeminiUtil {

    private static final OkHttpClient client = new OkHttpClient();
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static String summarizeText(String apiKey, String reviewText) throws IOException {
        // 프롬프트 구성
        String prompt = String.format("""
            요약해서 3 ~ 4줄 정도를 한 문단으로 정리해서 알려줘. 너의 생각도 조금 추가해도 괜찮아.
            
            %s
            """, reviewText);

        // JSON 요청 구성
        MediaType mediaType = MediaType.parse("application/json");
        String json = String.format("""
        {
          "contents": [
            {
              "parts": [
                {
                  "text": "%s"
                }
              ]
            }
          ]
        }
        """, prompt.replace("\"", "\\\""));

        // 요청 로그
        log.info("[GeminiUtil] === Gemini 요약 요청 ===");
        log.info("[GeminiUtil] 보낼 프롬프트:\n" + prompt);
        log.info("[GeminiUtil] JSON:\n" + json);

        RequestBody body = RequestBody.create(mediaType, json);
        Request request = new Request.Builder()
                .url("https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=" + apiKey)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(request).execute()) {
            int code = response.code();
            boolean success = response.isSuccessful();

            String responseBody = (response.body() != null) ? response.body().string() : null;

            // 응답 로그
            log.info("[GeminiUtil] === Gemini 응답 ===");
            log.info("[GeminiUtil] HTTP 응답 코드: " + code);
            log.info("[GeminiUtil] 성공 여부: " + success);
            log.info("[GeminiUtil] 응답 바디:\n" + responseBody);

            if (!success || responseBody == null) {
                return "요약을 가져오지 못했습니다. (API 오류)";
            }

            // JSON 파싱
            JsonNode root = objectMapper.readTree(responseBody);
            JsonNode textNode = root.at("/candidates/0/content/parts/0/text");

            if (textNode.isMissingNode()) {
                return "요약을 가져오지 못했습니다. (응답 구조 오류)";
            }

            return textNode.asText().replace("\n", " ");

        } catch (IOException e) {
            e.printStackTrace();
            return "요약을 가져오지 못했습니다. (예외 발생)";
        }
    }
}
