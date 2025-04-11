package com.mc.controller.auth;

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
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;

@Controller
@Slf4j
@RequiredArgsConstructor
public class AuthKakaoController {

    private final SocialUserService socialUserService;
    @Value("${app.key.kakaoApiKey}")
    private String KAKAO_CLIENT_ID;

    private final String redirectUrl = "http://127.0.0.1:9090/auth/kakao/token";

    final UserService userService;

    @RequestMapping("/auth/kakao/authorize")
    public String kakaoAuthorize() {
        String targetUrl = "https://kauth.kakao.com/oauth/authorize";
        targetUrl += "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + redirectUrl
                + "&response_type=code";

        return "redirect:" + targetUrl;
    }

    @RequestMapping("/auth/kakao/token")
    public String kakaoLogin(@RequestParam("code") String code, HttpSession httpSession) throws Exception {
        String targetUrl = "https://kauth.kakao.com/oauth/token";

        // RestTemplate - 동기 요청
        RestTemplate restTemplate = new RestTemplate();

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
        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.POST, requestEntity, String.class);

        // 응답 처리
        String responseBody = response.getBody();

        // Json으로 변환
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);

        // 로그 확인용
        log.info(responseBody);
        log.info(String.valueOf(jsonObject));

        String accessToken = (String) jsonObject.get("access_token");
        String refreshToken = (String) jsonObject.get("refresh_token");
        
        // Session에 토큰을 저장 (로직 바뀔 수도 있음)
        httpSession.setAttribute("accessToken", accessToken);
        httpSession.setAttribute("refreshToken", refreshToken);

        return "redirect:/auth/kakao/info?access_token=" + httpSession.getAttribute("accessToken");
    }

    @RequestMapping("/auth/kakao/info")
    public String kakaoInfo(@RequestParam("access_token") String token,
                            HttpSession httpSession) throws Exception {

        String targetUrl = "https://kapi.kakao.com/v2/user/me";

        // RestTemplate - 동기 요청
        RestTemplate restTemplate = new RestTemplate();

        // 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);

        // HttpEntity 생성
        HttpEntity<String> requestEntity = new HttpEntity<>(headers);

        // GET 요청 보내기
        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.GET, requestEntity, String.class);

        // 응답 처리
        String responseBody = response.getBody();

        // Json으로 변환
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);

        // 로그 확인용
        //log.info(responseBody);

        String id = "kakao" + jsonObject.get("id");

        String connectedAtStr = (String) jsonObject.get("connected_at");
        LocalDateTime connected_at = OffsetDateTime.parse(connectedAtStr).toLocalDateTime();

        JSONObject kakaoAccount = (JSONObject) jsonObject.get("kakao_account");
        String name = (String) kakaoAccount.get("name");
        String email = (String) kakaoAccount.get("email");
        String phone = (String) kakaoAccount.get("phone_number");
        phone = phone.replaceFirst("^\\+82\\s?", "0");

        // 로그 확인용
        log.info("id : " + id);
        log.info("connected_at : " + connected_at);
        log.info("name : " + name);
        log.info("email : " + email);
        log.info("phone : " + phone);

        // DB에 존재하면
        SocialUser dbSocialUser = socialUserService.get(id);
        if (dbSocialUser != null) {
            // 로그인 처리
            User dbUser = userService.get(dbSocialUser.getUserId());
            httpSession.setAttribute("user", dbUser);
            return "redirect:/";
        }

        // DB에 없으면 -> 회원가입 처리
        // 유효성 테스트 통과시 : 고유 id 부여 후 DB에 푸시
        User newUser = User.builder()
                .role("호스트")
                .email(email)
                .name(name)
                .phone(phone).build();
        newUser.setId(AuthUtil.generateUUID());
        try {
            userService.add(newUser);
            log.info(newUser.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 소셜 회원도 만듦
        SocialUser newSocialUser = SocialUser.builder()
                .provider("kakao")
                .providerUserId(id)
                .connectedAt(connected_at)
                .build();
        newSocialUser.setUserId(newUser.getId());
        try {
            socialUserService.add(newSocialUser); // 여기에서 오류가 남
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/";
    }

}