package com.mc.controllerrest;

import com.mc.app.dto.User;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
public class AuthImplController {

    final UserService userService;

    @PostMapping("/registerimpl")
    public ResponseEntity<String> registerimpl(@Valid User user, BindingResult bindingResult) {
        // registerUser의 파라미터에서 @Valid로 한번 체크를 걸어버림
        if (bindingResult.hasErrors()) {
            // 유효성 검사 실패 처리
            StringBuilder errorMessage = new StringBuilder();
            bindingResult.getFieldErrors().forEach(error ->
                    errorMessage.append("[")
                            .append(error.getField())
                            .append("] ")
                            .append(error.getDefaultMessage())
                            .append(" "));
            return ResponseEntity.badRequest().body(errorMessage.toString());
        }

        // 회원가입 로직 처리
        user.setId(AuthUtil.generateUUID());
        log.info(user.toString()); // 확인용
        try {
            userService.add(user);
        } catch (Exception e) {
            // e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }

        return ResponseEntity.ok("회원가입 성공");
    }

    @PostMapping("/loginimpl")
    public ResponseEntity<String> loginimpl(@RequestParam("email") String email,
                            @RequestParam("pwd") String pwd,
                            HttpSession httpSession) {
        // 해당 이메일로 가입한 유저가 있는지 확인
        User dbUser = userService.getByEmail(email);

        // 있다면 비밀번호 검증
        if (dbUser != null && dbUser.getPwd().equals(pwd)) {
            httpSession.setAttribute("user", dbUser);
            log.info(dbUser.toString()); // 로그 확인용
            return ResponseEntity.ok("로그인 성공");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 실패: 이메일 또는 비밀번호가 올바르지 않습니다.");
    }

}
