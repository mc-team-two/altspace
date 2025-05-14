package com.mc.util;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.vertexai.VertexAI;
import com.google.cloud.vertexai.api.GenerateContentResponse;
import com.google.cloud.vertexai.generativeai.GenerativeModel;
import com.google.cloud.vertexai.generativeai.ResponseHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

@Slf4j
@Component
public class GeminiUtil {

    @Value("${app.key.geminiProjectId}")
    private String projectId;

    @Value("${app.key.credentialsFilePath}")
    private String credentialsFilePath;

    public String askGemini(String promptText) throws IOException {
        log.info("Credentials file path: {}", credentialsFilePath);

        GoogleCredentials credentials;

        // classpath 또는 절대경로 자동 처리
        if (credentialsFilePath.startsWith("classpath:")) {
            ClassPathResource resource = new ClassPathResource(credentialsFilePath.substring("classpath:".length()));
            try (InputStream stream = resource.getInputStream()) {
                credentials = GoogleCredentials.fromStream(stream);
            }
        } else {
            // 절대경로나 상대경로 처리
            File file = new File(credentialsFilePath);
            if (!file.exists() && !file.isAbsolute()) {
                // 상대경로인 경우 classpath에서 찾기
                ClassPathResource resource = new ClassPathResource(credentialsFilePath);
                try (InputStream stream = resource.getInputStream()) {
                    credentials = GoogleCredentials.fromStream(stream);
                }
            } else {
                try (FileInputStream stream = new FileInputStream(file)) {
                    credentials = GoogleCredentials.fromStream(stream);
                }
            }
        }

        // newBuilder() 대신 직접 생성자 사용
        try (VertexAI vertexAI = new VertexAI(projectId, "asia-northeast3")) {
            GenerativeModel model = new GenerativeModel("gemini-2.0-super-001", vertexAI);
            GenerateContentResponse response = model.generateContent(promptText);
            return ResponseHandler.getText(response);
        }
    }
}