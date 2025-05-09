package com.mc.controller.auth;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/auth")
public class AuthController {

    private String dir = "auth/";

    private final UserService userService;
    private final SocialUserService socialUserService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final StandardPBEStringEncryptor standardPBEStringEncryptor;

    // 페이지 연결
    @RequestMapping("/login")
    public String login(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근할 수 없음 (잘못된 접근)
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

    @RequestMapping("/find-account")
    public String findAccount(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근할 수 없음 (잘못된 접근)
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }
        return dir + "find-account";
    }

    // rest, util
    @PostMapping("/registerimpl")
    public String registerimpl(@Valid User user, Model model, BindingResult bindingResult) {
        // 파라미터의 @Valid -> User DTO 유효성 검사
        // 유효성 검사 실패시
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
            return "auth/register";
        }

        // 유효성 검사 통과시
        // #1. DB에서 이메일 주소 중복 검사 (unique key)
        if (userService.getByEmail(user.getEmail()) != null) {
            String msg = "사용중인 이메일 주소입니다.";
            model.addAttribute("msg", msg);
            return "auth/register";
        }

        // #2. DB에 푸시 (고유 UID 제공 + 암호화)
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
            return "auth/register";
        }
        return "auth/login";
    }

    @PostMapping("/loginimpl")
    public String loginimpl(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            Model model, HttpSession httpSession) {

        // 해당 email을 사용하는 유저가 DB에 있는지 확인
        User dbUser = userService.getByEmail(email);

        // #1. 유저가 없으면 -> 에러 처리
        if (dbUser == null) {
            model.addAttribute("msg", "이메일 혹은 비밀번호가 틀렸습니다");
            return "redirect:/auth/login";
        }

        // 유저가 있으면 ->
        // #2. 일반 회원인지 확인 (비밀번호 필드가 있음)
        if (dbUser.getPassword() != null && bCryptPasswordEncoder.matches(password, dbUser.getPassword())) {
            // 복호화된 데이터로 세팅
            dbUser.setName(standardPBEStringEncryptor.decrypt(dbUser.getName()));
            dbUser.setPhone(standardPBEStringEncryptor.decrypt(dbUser.getPhone()));
            httpSession.setAttribute("user", dbUser);
            return "redirect:/";
        } else if (!bCryptPasswordEncoder.matches(password, dbUser.getPassword())){
            model.addAttribute("msg", "비밀번호가 틀렸습니다");
            return "auth/login";
        }

        // #3. 소셜 회원인지 확인 (비밀번호 필드가 없음) -> 소셜 로그인 버튼으로 로그인 해야됨 (리다이렉트)
        try {
            // dbUser가 존재함 -> user_id 로 조회
            SocialUser sUser = socialUserService.get(dbUser.getUserId());
            model.addAttribute("msg", sUser.getProvider() + "로 가입한 회원입니다.");
        } catch (Exception e) {
            model.addAttribute("msg", "소셜 로그인 정보 확인 중 오류가 발생했습니다.");
            log.error("소셜 로그인 사용자 조회 실패", e);
        }

        return "auth/login";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession httpSession) {
        httpSession.removeAttribute("user");
        // 메인으로 이동
        return "redirect:/";
    }

    @RequestMapping("/mod")
    public ResponseEntity<?> mod(@RequestParam("id") String id,
                      @RequestParam("name") String name,
                      HttpSession httpSession) {
        
        // #1. 요청 권한 확인 (세션에서 유저 정보 확인)
        User curUser = (User) httpSession.getAttribute("user");
        if (curUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요한 요청입니다.");
        }
        if (!curUser.getUserId().equals(id)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("허가되지 않은 요청입니다.");
        }
        
        // #2. DB 접근
        try {
            // 새로운 정보로 푸시
            curUser.setName(standardPBEStringEncryptor.encrypt(name));
            userService.mod(curUser);

            // 기존 세션 제거 후 새로 세팅
            httpSession.removeAttribute("user");
            curUser.setName(standardPBEStringEncryptor.decrypt(curUser.getName()));
            httpSession.setAttribute("user", curUser);

            return ResponseEntity.ok("회원 정보가 수정되었습니다");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("서버 오류가 발생했습니다.");
        }
    }

    @PostMapping("/del")
    public ResponseEntity<?> del(@RequestParam("id") String id, HttpSession httpSession) {
        User curUser = (User) httpSession.getAttribute("user");

        if (curUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요한 요청입니다.");
        }
        if (!curUser.getUserId().equals(id)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("허가되지 않은 요청입니다.");
        }
        try {
            userService.del(id);
            httpSession.invalidate();
            return ResponseEntity.ok("탈퇴가 정상적으로 완료되었습니다.\n이용해주셔서 감사합니다.");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("회원 탈퇴 과정에서 서버 오류가 발생했습니다.");
        }
    }

    @PostMapping("/check-email")
    public ResponseEntity<?> checkEmail(@RequestParam("email") String email) {
        log.info("레스트");
        try {
            User dbUser = userService.getByEmail(email);
            if (dbUser != null) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용중인 이메일 주소입니다.");
            }
            return ResponseEntity.ok("사용 가능한 이메일 주소입니다.");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("서버 오류가 발생했습니다.");
        }
    }

}
