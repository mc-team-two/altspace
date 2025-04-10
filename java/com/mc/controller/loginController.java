package com.mc.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login")
public class loginController {

    String dir = "login/";

    @RequestMapping
    public String loginForm() {
        return dir + "/login"; // webapp/views/Login/login.jsp
    }

    // 로그인 처리 로직 (@PostMapping("/login")) 추가

    @RequestMapping("/register")
    @Operation(summary = "회원가입 페이지", description = "회원 가입창으로 이동합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "성공", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "400", description = "잘못된 요청", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "500", description = "서버 오류", content = @Content(mediaType = "text/html"))
    })
    public String registerForm() {
        return dir + "/register";
    }
}
