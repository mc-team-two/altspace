package com.mc.controller.api.oauth2;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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

@Controller
@Slf4j
@RequiredArgsConstructor
public class AuthNaverController {

    private final SocialUserService socialUserService;
    private final UserService userService;

    @Value("${app.key.naverApiKey}")
    String NAVER_CLIENT_ID;

    @Value("${app.key.naverApiSecretKey}")
    String NAVER_CLIENT_SECRET;

    @Value("${app.url.serverUrl}/auth/naver/token")
    private String NAVER_REDIRECT_URI;

    @RequestMapping("/auth/naver/authorize")
    public String naverAuthorize(HttpSession httpSession) {

        // 랜덤 state 생성
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();

        // state 세션에 저장
        httpSession.setAttribute("state", state);

        String targetUrl = "https://nid.naver.com/oauth2.0/authorize";
        targetUrl += "?client_id=" + NAVER_CLIENT_ID
                + "&redirect_uri=" + NAVER_REDIRECT_URI
                + "&response_type=code"
                + "&state=" + state;

        return "redirect:" + targetUrl;
    }

    @RequestMapping("/auth/naver/token")
    public String naverCallback(@RequestParam("code") String code, HttpSession httpSession) throws Exception {

        String targetUrl = "https://nid.naver.com/oauth2.0/token";
        targetUrl += "?grant_type=authorization_code";
        targetUrl += "&client_id=" + NAVER_CLIENT_ID;
        targetUrl += "&client_secret=" + NAVER_CLIENT_SECRET;
        targetUrl += "&code=" + code;
        targetUrl += "&state=" + httpSession.getAttribute("state");

        // POST 요청 (동기)
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(targetUrl, null, String.class);

        String responseBody = response.getBody();

        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);

        String accessToken = (String) jsonObject.get("access_token");

        return "redirect:/auth/naver/info?access_token=" + accessToken;
    }

    @RequestMapping("/auth/naver/info")
    public String naverInfo(@RequestParam("access_token") String token,
                            HttpSession httpSession,
                            Model model) throws Exception {

        String targetUrl = "https://openapi.naver.com/v1/nid/me";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);

        HttpEntity<String> requestEntity = new HttpEntity<>(headers);

        // GET 요청 (동기)
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.GET, requestEntity, String.class);

        String responseBody = response.getBody();

        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);

        JSONObject naverAccount = (JSONObject) jsonObject.get("response");
        String providerUserId = "naver" + naverAccount.get("id");
        String name = (String) naverAccount.get("name");
        String email = (String) naverAccount.get("email");
        String phone = (String) naverAccount.get("mobile");
        // 커넥트 시점이 안 넘어와서 직접 여기에서 초기화
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
                    .provider("naver")
                    .providerUserId(providerUserId)
                    .connectedAt(connectedAt)
                    .build();
            socialUserService.add(newSocialUser);

            httpSession.setAttribute("user", newUser);
            return "redirect:/";

        } catch (Exception e) {
            model.addAttribute("msg", "오류 발생: " + e.getMessage());
            return "auth/login";
        }
    }

}