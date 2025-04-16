package com.mc.controller.auth;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/auth")
public class AuthController {

    private String dir = "auth/";

    private final UserService userService;
    private final SocialUserService socialUserService;

    @PostMapping("/loginimpl")
    public String loginimpl(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            Model model, HttpSession httpSession) {

        // DB 접근 #1 - email 사용자가 있는지 확인
        User dbUser = userService.getByEmail(email);

        // 1. 유저가 존재하지 않음
        if (dbUser == null) {
            model.addAttribute("msg", "이메일 혹은 비밀번호가 틀렸습니다");
            return "redirect:/login";
        }

        // 2. 일반 이메일 회원 (비밀번호 필드가 있어야 함)
        if (dbUser.getPassword() != null) {
            // 패스워드 비교
            if (dbUser.getPassword().equals(password)) {
                httpSession.setAttribute("user", dbUser);

                // 이전 요청 URL 확인 및 리다이렉트
                String previousUrl = (String) httpSession.getAttribute("previousUrl");
                httpSession.removeAttribute("previousUrl");

                if (previousUrl != null && !previousUrl.isEmpty()) {
                    return "redirect:" + previousUrl;
                } else {
                    return "redirect:/"; // 기본 리다이렉트 (로그인 성공 후 메인 페이지)
                }
            } else {
                model.addAttribute("msg", "비밀번호가 틀렸습니다");
                return "login/login";
            }
        }

        // 3. 소셜 로그인 회원
        try {
            // dbUser가 존재함 -> user_id 로 조회
            SocialUser sUser = socialUserService.get(dbUser.getUserId());

            httpSession.setAttribute("user", dbUser); // 소셜 로그인 성공 시 세션 저장
            model.addAttribute("msg", sUser.getProvider() + "로 가입한 회원입니다.");

            // 이전 요청 URL 확인 및 리다이렉트
            String previousUrl = (String) httpSession.getAttribute("previousUrl");
            httpSession.removeAttribute("previousUrl");

            if (previousUrl != null && !previousUrl.isEmpty()) {
                return "redirect:" + previousUrl;
            } else {
                return "redirect:/"; // 기본 리다이렉트 (로그인 성공 후 메인 페이지)
            }

        } catch (Exception e) {
            model.addAttribute("msg", "소셜 로그인 정보 확인 중 오류가 발생했습니다.");
            log.error("소셜 로그인 사용자 조회 실패", e);
            return "login/login";
        }
    }
    @RequestMapping("/logout")
    public String logout(HttpSession httpSession) {
        httpSession.removeAttribute("user");
        // 메인으로 이동
        return "redirect:/";
    }

    @RequestMapping("/mod")
    public String mod(HttpSession httpSession) {
        // TODO: user 세션에 다시 저장
        // 마이페이지로 재접속
        return "redirect:/mypage";
    }

    @RequestMapping("/del")
    public String del(HttpSession httpSession) {
        // TODO : user 세션 다시 저장
        // 메인으로 이동
        return "redirect:/";
    }
}