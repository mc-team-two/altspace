package com.mc.controller;

import com.mc.app.dto.User;
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
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuthController {

    final UserService userService;

    @RequestMapping("/login")
    public String login(Model model) {
        return "login";
    }

    @RequestMapping("/register")
    public String register(Model model) {
        return "register";
    }

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
            return "register";
        }

        // 유효성 테스트 통과시 : 고유 id 부여 후 DB에 푸시
        user.setId(AuthUtil.generateUUID());
        try {
            userService.add(user);
            log.info(user.toString());
        } catch (Exception e) {
            String msg = e.toString();
            model.addAttribute("msg", msg);
            return "register";
        }
        return "redirect:/login";
    }

    @PostMapping("/loginimpl")
    public String loginimpl(@RequestParam("email") String email,
                            @RequestParam("pwd") String pwd,
                            Model model, HttpSession httpSession) {
        // 해당 이메일로 가입한 유저가 있는지 확인
        User dbUser = userService.getByEmail(email);

        // 있다면 비밀번호 대조 후 로그인 처리
        if (dbUser != null && dbUser.getPwd().equals(pwd)) {
            httpSession.setAttribute("user", dbUser);
            log.info(dbUser.toString()); // 로그 확인용
            return "redirect:/";
        }
        // 없다면 오류 메시지 반환
        String msg = "이메일 혹은 비밀번호가 다릅니다.";
        model.addAttribute("msg", msg);
        return "login";
    }

}
