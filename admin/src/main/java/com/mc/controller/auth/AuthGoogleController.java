package com.mc.controller.auth;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
public class AuthGoogleController {

    @Value("${app.key.googleApiKey}")
    String GOOGLE_CLIENT_ID;

    @Value("${app.key.googleApiSecretKey}")
    String GOOGLE_CLIENT_SECRET;

    @Value("${app.url.serverUrl}")
    String REDIRECT_URL;
    String GOOGLE_REDIRECT_URI = REDIRECT_URL + "/auth/google/token";

    @RequestMapping("/auth/google/authorize")
    public String googleAuthorize(HttpSession httpSession) {
        // 랜덤 state 생성
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();

        // state 세션에 저장
        httpSession.setAttribute("state", state);

        // Scope 설정
        String scope = "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/user.phonenumbers.read";
        
        String targetUrl = "https://accounts.google.com/o/oauth2/v2/auth";
        targetUrl += "?client_id=" + GOOGLE_CLIENT_ID
                + "&redirect_uri=" + GOOGLE_REDIRECT_URI
                + "&response_type=code"
                + "&state=" + state
                + "&scope=" + scope;

        return "redirect:" + targetUrl;
    }

    @RequestMapping("/auth/google/token")
    public String googleCallback(@RequestParam("code") String code, HttpSession httpSession) throws ParseException {
        String targetUrl = "https://oauth2.googleapis.com/token";

        // 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        // 바디
        Map<String, String> body = new HashMap<>();
        body.put("grant_type", "authorization_code");
        body.put("client_id", GOOGLE_CLIENT_ID);
        body.put("client_secret", GOOGLE_CLIENT_SECRET);
        body.put("redirect_uri", GOOGLE_REDIRECT_URI);
        body.put("code", code);

        // HttpEntity 생성
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(body, headers);

        // POST 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.POST, requestEntity, String.class);

        // 응답 처리
        String responseBody = response.getBody();

        // Json으로 변환
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);

        // 로그 확인용
        //log.info(String.valueOf(jsonObject));

        // 토큰 추출
        String accessToken = (String) jsonObject.get("access_token");

        // 로그 확인용
        //log.info("google accessToken:" + accessToken);

        // Session에 토큰을 저장 (로직 바뀔 수도 있음)
        httpSession.setAttribute("accessToken", accessToken);

        return "redirect:/auth/google/info?access_token=" + httpSession.getAttribute("accessToken");
    }

    @RequestMapping("/auth/google/info")
    public String googleInfo(@RequestParam("access_token") String token) throws Exception {

        // 1. 프로필 기본 정보 요청
        
        // RestTemplate
        RestTemplate restTemplate = new RestTemplate();

        // 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);

        // request 엔터티 생성
        HttpEntity<String> requestEntity = new HttpEntity<>(headers);

        // Get 요청 후 response 받기
        String targetUrl = "https://www.googleapis.com/oauth2/v3/userinfo";
        ResponseEntity<String> profileResponse = restTemplate.exchange(targetUrl, HttpMethod.GET, requestEntity, String.class);

        // 응답을 json으로 변환
        JSONParser jsonParser = new JSONParser();
        JSONObject profileJson = (JSONObject) jsonParser.parse(profileResponse.getBody());

        // 로그 확인용
        log.info(String.valueOf(profileJson));

        String id = "google" + profileJson.get("sub");
        String name = (String) profileJson.get("name");
        String email = (String) profileJson.get("email");

        // 2. 전화번호 정보 요청
        String phoneUrl = "https://people.googleapis.com/v1/people/me?personFields=phoneNumbers";
        ResponseEntity<String> phoneResponse = restTemplate.exchange(phoneUrl, HttpMethod.GET, requestEntity, String.class);
        JSONObject phoneJson = (JSONObject) jsonParser.parse(phoneResponse.getBody());

        // 로그 확인용
        // log.info(String.valueOf(phoneJson));

        String phone = "";
        JSONArray phones = (JSONArray) phoneJson.get("phoneNumbers");
        if (phones != null && !phones.isEmpty()) {
            JSONObject phoneObject = (JSONObject) phones.get(0);
            phone = (String) phoneObject.get("value");
        }

        // 로그 확인용
        log.info("id : " + id);
        log.info("name : " + name);
        log.info("email : " + email);
        log.info("phone : " + phone);

        return "redirect:/";
    }

}
