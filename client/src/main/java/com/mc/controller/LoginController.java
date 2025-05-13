package com.mc.controller;

import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.EmailService;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping("/login")
@Slf4j
public class LoginController {

    private final UserService userService;
    private final SocialUserService socialUserService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final StandardPBEStringEncryptor standardPBEStringEncryptor;
    private final EmailService emailService;

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

    @RequestMapping("/find-account")
    public String findAccount(HttpSession httpSession) {
        // 로그인 세션이 존재하면 접근 불가
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }
        return dir + "find-account";
    }

    // 실행 REST
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

    @PostMapping("/find-account-impl")
    public ResponseEntity<?> findAccountImpl(@RequestParam("email") String email) throws Exception {
        // 해당 이메일을 사용하는 유저가 있는지 검색
        User dbUser = userService.getByEmail(email);

        // 없다면 메시지 반환
        if (dbUser == null) {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body("해당 이메일로 가입한 회원이 없습니다.");
        }

        // 있다면 다음 단계로
        // 소셜 유저인지 확인
        SocialUser dbSocialUser = socialUserService.get(dbUser.getUserId());
        if (dbSocialUser != null) {
            String message = dbSocialUser.getProvider() + " 계정으로 가입한 회원입니다.\n"
                    + "연동 일자: " + dbSocialUser.getConnectedAt();
            return ResponseEntity
                    .status(HttpStatus.OK)
                    .body(message);
        }

        // 이메일로 가입한 유저라면 비밀번호를 임시 비밀번호로 바꿈
        String rawPwd = AuthUtil.generatePwd();
        String encryptedPwd = bCryptPasswordEncoder.encode(rawPwd);
        dbUser.setPassword(encryptedPwd);
        userService.mod(dbUser);

        log.info("유저 정보 변경됨 : " + dbUser.toString());
        log.info("변경된 비밀번호: " + rawPwd);

        // 바뀐 비밀번호 + 아이디 정보를 이메일로 전송
        emailService.sendEmail(email,
                "[알트스페이스] 임시 비밀번호 발급",
                "임시 비밀번호 : " + rawPwd);

        // 전송 후 안내 메시지 반환
        return ResponseEntity
                .status(HttpStatus.OK)
                .body("메일이 정상적으로 발송되었습니다.\n메일함을 확인해주세요.");
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