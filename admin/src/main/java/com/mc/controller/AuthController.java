package com.mc.controller;

import com.mc.app.dto.User;
import com.mc.app.service.UserService;
import com.mc.app.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLIntegrityConstraintViolationException;

@Controller
@Slf4j
@RequiredArgsConstructor
public class AuthController {

    final UserService userService;

    @RequestMapping("/auth/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/auth/loginimpl")
    public String loginimpl(@RequestParam("email") String email,
                            @RequestParam("pwd") String pwd,
                            HttpSession httpSession,
                            Model model) {
        User dbUser = userService.getByEmail(email);
        if (dbUser != null && dbUser.getPwd().equals(pwd)) {
            httpSession.setAttribute("user", dbUser);
            log.info(dbUser.toString()); // 로그 확인용
        } else {
            String msg = "로그인이 정상적으로 처리되지 않았습니다.";
            model.addAttribute("msg", msg);
            return "redirect:/auth/login";
        }
        return "redirect:/";
    }

    @RequestMapping("/auth/register")
    public String register() {
        return "register";
    }

    @RequestMapping("/auth/registerimpl")
    public String registerimpl(User user, Model model) {
        user.setId(AuthUtil.generateUUID());
        log.info(user.toString());
        try {
            userService.add(user);
            log.info("userService.add() 실행됨");
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "회원가입이 정상적으로 이루어지지 않았습니다.";
            model.addAttribute("msg", msg);
            return "redirect:/auth/register";
        }
        return "redirect:/auth/login";
    }
}
