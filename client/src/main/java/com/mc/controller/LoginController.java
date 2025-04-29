package com.mc.controller;

import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Controller
@RequiredArgsConstructor
@RequestMapping("/login")
@Slf4j
public class LoginController {

    private final UserService userService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final StandardPBEStringEncryptor standardPBEStringEncryptor;

    String dir = "login/";

    // 페이지 연결
    @RequestMapping("")
    public String login(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근할 수 없음
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }
        return dir + "login";
    }

    @RequestMapping("/register")
    public String register(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근할 수 없음 (잘못된 접근)
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }
        return dir + "register";
    }

    @RequestMapping("/find-id")
    public String findid(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근할 수 없음 (잘못된 접근)
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }
        return dir + "find-id";
    }

    @RequestMapping("/find-password")
    public String findpassword(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근할 수 없음 (잘못된 접근)
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }
        return dir + "find-password";
    }

    // 실행
    @PostMapping("/registerimpl")
    public String registerimpl(@Valid User user, Model model, BindingResult bindingResult) {
        // 파라미터의 @Valid -> User DTO 유효성 검사
        // 유효성 검사 통과 못했을 시
        if (bindingResult.hasErrors()) {
            StringBuilder errorMessage = new StringBuilder();
            bindingResult.getFieldErrors().forEach(error ->
                    errorMessage.append("[")
                            .append(error.getField())
                            .append("] ")
                            .append(error.getDefaultMessage())
                            .append(" "));
            String msg = errorMessage.toString();
            model.addAttribute("msg", msg);
            return dir + "register"; // 회원가입 페이지로 리다이렉트
        }

        // 유효성 테스트 통과시 : 고유 id 부여 후 DB에 푸시
        // email -> 유니크 key
        if (userService.getByEmail(user.getEmail()) != null) {
            String msg = "사용중인 이메일 주소입니다.";
            model.addAttribute("msg", msg);
            return "redirect:/login/register";
        }

        // email 중복 아니라면
        user.setUserId(AuthUtil.generateUUID());
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword())); // 비밀번호 (복호화 불가)
        user.setName(standardPBEStringEncryptor.encrypt(user.getName()));   // 이름
        user.setPhone(standardPBEStringEncryptor.encrypt(user.getPhone())); // 휴대폰 번호

        try {
            userService.add(user);
            log.info(user.toString());
        } catch (Exception e) {
            String msg = e.toString();
            model.addAttribute("msg", msg);
            return "redirect:/login/register";
        }
        return "redirect:/login";
    }
}