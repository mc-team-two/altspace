package com.mc.controller.auth;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.math.BigInteger;
import java.security.SecureRandom;

@Controller
@Slf4j
@RequiredArgsConstructor
public class AuthNaverController {

    @Value("${app.key.naverApiKey}")
    String NAVER_CLIENT_ID;

    @Value("${app.key.naverApiSecretKey}")
    String NAVER_CLIENT_SECRET;

    @Value("${app.url.serverUrl}")
    String REDIRECT_URI;
    String NAVER_REDIRECT_URI = REDIRECT_URI + "/auth/naver/token";


    final UserService userService;
    final SocialUserService socialUserService;

    /**
     *  네이버 인가코드 가져오기 (step1)
     */
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

    /**
     *  콜백: 인가코드 사용해서 토큰 받아오기 (step2)
     */
    @RequestMapping("/auth/naver/token")
    public String naverCallback(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession httpSession) throws Exception {

        // 모든 파라미터를 url에 포함
        String targetUrl = "https://nid.naver.com/oauth2.0/token";
        targetUrl += "?grant_type=authorization_code";
        targetUrl += "&client_id=" + NAVER_CLIENT_ID;
        targetUrl += "&client_secret=" + NAVER_CLIENT_SECRET;
        targetUrl += "&code=" + code;
        targetUrl += "&state=" + httpSession.getAttribute("state");

        // POST 요청 (헤더/바디 없음)
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(targetUrl, null, String.class);

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

        return "redirect:/auth/naver/info?access_token=" + httpSession.getAttribute("accessToken");
    }

    /**
     *  토큰 사용해서 유저 정보 가져오기 (step3)
     */
    @RequestMapping("/auth/naver/info")
    public String naverInfo(@RequestParam("access_token") String token,
                            HttpSession httpSession) throws Exception {

        String targetUrl = "https://openapi.naver.com/v1/nid/me";

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
        log.info("auth/naver/info");
        log.info(responseBody);

        JSONObject naverAccount = (JSONObject) jsonObject.get("response");
        String id = "naver" + naverAccount.get("id");
        String name = (String) naverAccount.get("name");
        String email = (String) naverAccount.get("email");
        String phone = (String) naverAccount.get("mobile");

        // 로그 확인용
        log.info("id : " + id);
        log.info("name : " + name);
        log.info("email : " + email);
        log.info("phone : " + phone);

        //////////////////////////////////////////////////
/*        // 1. db에 id가 있는지 조회
        SocialUser dbSocialUser = socialUserService.get(id);

        // 1-1. db에 존재함 (연동되어 있는 회원임)
        if (dbSocialUser != null) {
           User dbUser = userService.get(dbSocialUser.getUser_id());
           httpSession.setAttribute("user", dbUser);
           return "redirect:/";
        } else {
            SocialUser newSocialUser = SocialUser.builder().provider("kakao").providerUserId(id).connectedAt(connected_at);
            socialUserService.add(newSocialUser);
        }*/

        // 1-2. db에 존재하지 않음 (새로 연동)


        return "redirect:/";
    }


    // DB 조회하기




}