package com.mc.controller;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    final SocialUserService socialUserService;

    @RequestMapping("/")
    public String main(Model model, HttpSession httpSession) throws Exception {
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("center","center");
        return "index";
    }

    @RequestMapping("/mypage")
    public String mypage(Model model, HttpSession httpSession) throws Exception {
        // 로그인 했을 때만 접속 가능함
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        User user = (User) httpSession.getAttribute("user");
        SocialUser socialUser = socialUserService.get(user.getUserId());

        model.addAttribute("socialUser", socialUser);
        model.addAttribute("user", user);
        model.addAttribute("center","mypage");
        return "index";
    }

}
