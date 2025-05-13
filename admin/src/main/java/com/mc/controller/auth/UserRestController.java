package com.mc.controller.auth;


import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.EmailService;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.format.DateTimeFormatter;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@Slf4j
public class UserRestController {

    private final UserService userService;
    private final SocialUserService socialUserService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final EmailService emailService;
    private final StandardPBEStringEncryptor standardPBEStringEncryptor;

    @PostMapping("/find-account-impl")
    public String findAccountImpl(@RequestParam("email") String email) throws Exception {
        // 해당 이메일을 사용하는 유저가 있는지 검색
        User dbUser = userService.getByEmail(email);

        // 없다면 메시지 반환
        if (dbUser == null) {
            return "해당 이메일로 가입한 회원이 없습니다.";
        }
        
        // 있다면 다음 단계로
        // 소셜 유저인지 확인
        SocialUser dbSocialUser = socialUserService.get(dbUser.getUserId());
        if (dbSocialUser != null) {
            return dbSocialUser.getProvider() + " 계정으로 가입한 회원입니다.\n"
                    + "연동 일자: " + dbSocialUser.getConnectedAt();
        }

        // 이메일로 가입한 유저라면 
        // 비밀번호를 임시 비밀번호로 바꿈
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
        return "메일이 정상적으로 발송되었습니다.\n메일함을 확인해주세요.";
    }

    @PostMapping("/change-pwd-impl")
    public ResponseEntity<?> changePwdImpl(@RequestBody Map<String, String> pwdData,
                                           HttpSession httpSession) throws Exception {
        String oldPwd = pwdData.get("oldPwd");
        String newPwd = pwdData.get("newPwd");

        log.info("oldPwd: " + oldPwd);
        log.info("newPwd: " + newPwd);

        // 현재 로그인한 사용자
        User user = (User) httpSession.getAttribute("user");
        User dbUser = userService.get(user.getUserId());

        // 비밀번호 매칭
        if (dbUser.getPassword() != null && bCryptPasswordEncoder.matches(oldPwd, dbUser.getPassword())) {
            dbUser.setPassword(bCryptPasswordEncoder.encode(newPwd));
            userService.mod(dbUser);
            httpSession.setAttribute("user", dbUser);
            return ResponseEntity.ok("정상적으로 변경되었습니다.");
        } else if (!bCryptPasswordEncoder.matches(oldPwd, dbUser.getPassword())) {
            return ResponseEntity.badRequest().body("비밀번호가 틀렸습니다");
        }

        return ResponseEntity.internalServerError().body("오류가 발생했습니다. 관리자에게 문의해주세요.");
    }
}
