//package com.mc.controller;
//
//import lombok.extern.slf4j.Slf4j;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
//import org.springframework.http.HttpEntity;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpMethod;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.util.LinkedMultiValueMap;
//import org.springframework.util.MultiValueMap;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.client.RestTemplate;
//
//import java.io.UnsupportedEncodingException;
//import java.net.URLEncoder;
//
//@Controller
//@Slf4j
//public class socialAuthController {
//
//    private final String REST_API_KEY = "0236ec56bbb03df025a455a202697ffb";
//    private final String REDIRECT_URI = "http://localhost:1212/auth/kakao/token";
//
//    /**
//     *  카카오 인가코드 가져오기 (step1)
//     */
//    @RequestMapping("/auth/kakao/authorize")
//    public String kakaoAuthorize() throws UnsupportedEncodingException {
//        String targetUrl = "https://kauth.kakao.com/oauth/authorize";
//        StringBuilder urlBuilder = new StringBuilder(targetUrl);
//        urlBuilder.append("?" + URLEncoder.encode("client_id", "UTF-8") + "=" + REST_API_KEY);
//        urlBuilder.append("&" + URLEncoder.encode("redirect_uri", "UTF-8") + "=" + REDIRECT_URI);
//        urlBuilder.append("&" + URLEncoder.encode("response_type", "UTF-8") + "=" + "code");
//
//        return "redirect:" + urlBuilder.toString();
//    }
//
//    /**
//     *  카카오 인가코드 사용해서 토큰 받아오기 (step2)
//     */
//    @RequestMapping("/auth/kakao/token")
//    public String kakaoLogin(@RequestParam("code") String code) throws Exception {
//
//        String targetUrl = "https://kauth.kakao.com/oauth/token";
//
//        // RestTemplate - 동기 요청이라서 나중에 비동기 방식으로 바꿔야 할 수도.
//        RestTemplate restTemplate = new RestTemplate();
//
//        // 헤더
//        HttpHeaders headers = new HttpHeaders();
//        headers.set("Content-Type", "application/x-www-form-urlencoded");
//
//        // 바디
//        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
//        body.add("grant_type", "authorization_code");
//        body.add("client_id", REST_API_KEY);
//        body.add("redirect_uri", REDIRECT_URI);
//        body.add("code", code);
//
//        // HttpEntity 생성
//        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(body, headers);
//
//        // POST 요청 보내기
//        ResponseEntity<String> response = restTemplate.exchange(targetUrl, HttpMethod.POST, requestEntity, String.class);
//
//        // 응답 처리
//        String responseBody = response.getBody();
//
//        // Json으로 변환
//        JSONParser jsonParser = new JSONParser();
//        JSONObject jsonObject = (JSONObject) jsonParser.parse(responseBody);
//
//        // 로그 확인용
//        log.info(responseBody);
//
//        // TODO (1) : refresh_token, access_token, id_token -> 유저 DB에 저장하기
//        // TODO (2) : access_token 사용해서 닉네임, email 정보 가져와서 DB에 넣기
//
//        return "redirect:/";
//    }
//}
//
