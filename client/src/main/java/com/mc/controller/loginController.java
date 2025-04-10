package com.mc.controller;

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
    public String registerForm() {
        return dir + "/register";
    }
}
