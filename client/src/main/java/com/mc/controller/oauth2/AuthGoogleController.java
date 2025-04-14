package com.mc.controller.oauth2;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class AuthGoogleController {

    private final SocialUserService socialUserService;
    private final UserService userService;

    @Value("${app.key.googleApiKey}")
    String GOOGLE_CLIENT_ID;

    @Value("${app.key.googleApiSecretKey}")
    String GOOGLE_CLIENT_SECRET;

    @Value("${app.url.serverUrl}/auth/google/token")
    String GOOGLE_REDIRECT_URI;

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
    public String googleCallback(@RequestParam("code") String code) throws ParseException {
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

        // 토큰 추출
        String accessToken = (String) jsonObject.get("access_token");

        return "redirect:/auth/google/info?access_token=" + accessToken;
    }

    @RequestMapping("/auth/google/info")
    public String googleInfo(@RequestParam("access_token") String token,
                             HttpSession httpSession,
                             Model model) throws Exception {

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

        String providerUserId = "google" + profileJson.get("sub");
        String name = (String) profileJson.get("name");
        String email = (String) profileJson.get("email");

        // 2. 전화번호 정보 요청
        String phoneUrl = "https://people.googleapis.com/v1/people/me?personFields=phoneNumbers";
        ResponseEntity<String> phoneResponse = restTemplate.exchange(phoneUrl, HttpMethod.GET, requestEntity, String.class);
        JSONObject phoneJson = (JSONObject) jsonParser.parse(phoneResponse.getBody());

        String phone = "";
        JSONArray phones = (JSONArray) phoneJson.get("phoneNumbers");
        if (phones != null && !phones.isEmpty()) {
            JSONObject phoneObject = (JSONObject) phones.get(0);
            phone = (String) phoneObject.get("value");
        }

        LocalDateTime connectedAt = LocalDateTime.now();

        // 분기점
        // DB 접근 및 처리
        try {
            // 기존 소셜 사용자 여부 확인
            User dbUser = socialUserService.getBySocialId(providerUserId);
            if (dbUser != null) {
                httpSession.setAttribute("user", dbUser);
                return "redirect:/";
            }

            // 이메일 중복 확인
            // 이메일로 가입한 회원이거나 다른 소셜 계정의 이메일로 가입한 회원
            User existingUser = userService.getByEmail(email);
            if (existingUser != null) {
                // 일반 회원 여부
                if (existingUser.getPassword() != null) {
                    model.addAttribute("msg", "이메일 계정으로 가입한 회원입니다. 로그인 해주세요.");
                    return "auth/login";
                }

                // 소셜 회원 여부
                SocialUser existingSocialUser = socialUserService.get(existingUser.getUserId());
                if (existingSocialUser != null) {
                    String msg = existingSocialUser.getProvider() + "로 가입한 회원입니다.\n";
                    msg += "연동일자: " + existingSocialUser.getConnectedAt();
                    model.addAttribute("msg", msg);
                    return "auth/login";
                }
            }

            // 신규 회원가입 처리
            User newUser = User.builder()
                    .userId(AuthUtil.generateUUID())
                    .role("호스트")
                    .email(email)
                    .name(name)
                    .phone(phone)
                    .build();
            userService.add(newUser);

            SocialUser newSocialUser = SocialUser.builder()
                    .userId(newUser.getUserId())
                    .provider("google")
                    .providerUserId(providerUserId)
                    .connectedAt(connectedAt)
                    .build();
            socialUserService.add(newSocialUser);

            httpSession.setAttribute("user", newUser);
            return "redirect:/";

        } catch (Exception e) {
            model.addAttribute("msg", "오류 발생: " + e.getMessage());
            return "login/login";
        }
    }

}
