package com.mc.controller;

import org.springframework.stereotype.Controller;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mc.app.dto.User;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class MypageController {

    public String dir = "mypage/";

    @GetMapping("")
    public String mypage(Model model, HttpSession session) throws Exception {
        User loggedInUser = (User) session.getAttribute("user"); // 세션에서 "user"로 저장된 사용자 정보 가져오기

        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);
            model.addAttribute("center", dir + "center");
            return "index";
        } else {
            session.setAttribute("previousUrl", "/mypage"); // 로그인 페이지로 리다이렉트되기 전에 이전 URL 저장
            model.addAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }
    }
}