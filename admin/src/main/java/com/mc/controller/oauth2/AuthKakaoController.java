package com.mc.controller.oauth2;

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
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class AuthKakaoController {

    private final SocialUserService socialUserService;
    private final UserService userService;

    @Value("${app.key.kakaoApiKey}")
    private String KAKAO_CLIENT_ID;

    @Value("${app.url.serverUrl}/auth/kakao/token")
    private String redirectUrl;

    @RequestMapping("/auth/kakao/authorize")
    public String kakaoAuthorize() {
        String targetUrl = "https://kauth.kakao.com/oauth/authorize";
        targetUrl += "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + redirectUrl
                + "&response_type=code";

        return "redirect:" + targetUrl;
    }

    @RequestMapping("/auth/kakao/token")
    public String kakaoCallback(@RequestParam("code") String code) throws ParseException {
        String targetUrl = "https://kauth.kakao.com/oauth/token";

        // 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");

        // 바디
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("grant_type", "authorization_code");
        body.add("client_id", KAKAO_CLIENT_ID);
        body.add("redirect_uri", redirectUrl);
        body.add("code", code);

        // HttpEntity 생성
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(body, headers);

        // POST 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.POST, requestEntity, String.class);

        // 응답 처리
        String responseBody = response.getBody();

        // Json으로 변환
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = null;
        jsonObject = (JSONObject) jsonParser.parse(responseBody);

        // json 에서 token 추출
        String accessToken = (String) jsonObject.get("access_token");

        return "redirect:/auth/kakao/info?access_token=" + accessToken;
    }

    @RequestMapping("/auth/kakao/info")
    public String kakaoInfo(@RequestParam("access_token") String token,
                            HttpSession httpSession,
                            Model model) throws ParseException {

        String targetUrl = "https://kapi.kakao.com/v2/user/me";

        // 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);

        // HttpEntity 생성
        HttpEntity<String> requestEntity = new HttpEntity<>(headers);

        // GET 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.GET, requestEntity, String.class);

        // 응답 처리
        String responseBody = response.getBody();

        // Json으로 변환
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);

        // 데이터 추출
        String providerUserId = "kakao" + jsonObject.get("id");

        String connectedAtStr = (String) jsonObject.get("connected_at");
        LocalDateTime connectedAt = OffsetDateTime.parse(connectedAtStr).toLocalDateTime();

        JSONObject kakaoAccount = (JSONObject) jsonObject.get("kakao_account");
        String name = (String) kakaoAccount.get("name");
        String email = (String) kakaoAccount.get("email");
        String phone = (String) kakaoAccount.get("phone_number");
        phone = phone.replaceFirst("^\\+82\\s?", "0");

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
                    return "demo/login";
                }

                // 소셜 회원 여부
                SocialUser existingSocialUser = socialUserService.get(existingUser.getUserId());
                if (existingSocialUser != null) {
                    String msg = existingSocialUser.getProvider() + "로 가입한 회원입니다.\n";
                    msg += "연동일자: " + existingSocialUser.getConnectedAt();
                    model.addAttribute("msg", msg);
                    return "demo/login";
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
                    .provider("kakao")
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