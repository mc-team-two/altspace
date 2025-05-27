package com.mc.restfulController;


import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.EmailService;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import com.mc.common.response.AuthMessage;
import com.mc.common.response.ResponseMessage;
import com.mc.util.AuthUtil;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RequestMapping("/api/auth")
@RestController
@RequiredArgsConstructor
@Slf4j
public class AuthRestController {

    private final UserService userService;
    private final SocialUserService socialUserService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final EmailService emailService;
    private final StandardPBEStringEncryptor standardPBEStringEncryptor;

    // 회원가입
    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid User user, BindingResult bindingResult) {
        // 파라미터의 @Valid -> User DTO 에서 유효성 검사
        // 유효성 검사 실패시
        if (bindingResult.hasErrors()) {
            StringBuilder errorMessage = new StringBuilder();
            bindingResult.getFieldErrors().forEach(error ->
                    errorMessage.append("[")
                            .append(error.getField())
                            .append("] ")
                            .append(error.getDefaultMessage())
                            .append(" "));
            log.error(errorMessage.toString());
            return ResponseEntity
                    .status(AuthMessage.SIGNUP_BAD_REQUEST.getStatus())
                    .body(AuthMessage.SIGNUP_BAD_REQUEST.getMessage());
        }

        // 유효성 검사 통과시
        // #1. DB에서 이메일 주소 중복 검사 (unique key)
        if (userService.getByEmail(user.getEmail()) != null) {
            return ResponseEntity
                    .status(AuthMessage.EMAIL_CONFLICT.getStatus())
                    .body(AuthMessage.EMAIL_CONFLICT.getMessage());
        }

        // #2. DB에 푸시 (고유 UID 제공 + 암호화)
        user.setUserId(AuthUtil.generateUUID());
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword())); // 비밀번호 (복호화 불가)
        user.setName(standardPBEStringEncryptor.encrypt(user.getName()));   // 이름
        user.setPhone(standardPBEStringEncryptor.encrypt(user.getPhone())); // 휴대폰 번호

        try {
            userService.add(user);
            return ResponseEntity
                    .status(AuthMessage.SIGNUP_SUCCESS.getStatus())
                    .body(AuthMessage.SIGNUP_SUCCESS.getMessage());
        } catch (Exception e) {
            log.error("회원가입 중 예외 발생: {}", e.getMessage());
            return ResponseEntity
                    .status(AuthMessage.SIGNUP_FAIL.getStatus())
                    .body(AuthMessage.SIGNUP_FAIL.getMessage());
        }
    }

    // 로그인
    @PostMapping("/login")
    public ResponseEntity<?> login(
            @RequestParam("email") String email,
            @RequestParam("password") String password,HttpSession httpSession) {

        // 해당 email을 사용하는 유저가 DB에 있는지 확인
        User dbUser = userService.getByEmail(email);

        // #1. 유저가 없으면 -> 에러 처리
        if (dbUser == null) {
            return ResponseEntity
                    .status(AuthMessage.LOGIN_NOT_FOUND.getStatus())
                    .body(AuthMessage.LOGIN_NOT_FOUND.getMessage());
        }

        // 유저가 있으면 ->
        // 탈퇴한 회원인지 확인
        if (dbUser.getDeletedDay() != null) {
            return ResponseEntity
                    .status(AuthMessage.DELETED_USER_ERROR.getStatus())
                    .body(AuthMessage.DELETED_USER_ERROR.getMessage() + "탈퇴일자: \n" + dbUser.getDeletedDay());
        }

        // #2. 일반 회원인지 확인 (비밀번호 필드가 있음)
        if (dbUser.getPassword() != null && bCryptPasswordEncoder.matches(password, dbUser.getPassword())) {
            // 복호화된 데이터로 세팅
            dbUser.setName(standardPBEStringEncryptor.decrypt(dbUser.getName()));
            dbUser.setPhone(standardPBEStringEncryptor.decrypt(dbUser.getPhone()));
            httpSession.setAttribute("user", dbUser);
            return ResponseEntity
                    .status(AuthMessage.LOGIN_SUCCESS.getStatus())
                    .body(AuthMessage.LOGIN_SUCCESS.getMessage());
        } else if (!bCryptPasswordEncoder.matches(password, dbUser.getPassword())){
            return ResponseEntity
                    .status(AuthMessage.LOGIN_BAD_REQUEST.getStatus())
                    .body(AuthMessage.LOGIN_BAD_REQUEST.getMessage());
        }

        // #3. 소셜 회원인지 확인 (비밀번호 필드가 없음) -> 소셜 로그인 버튼으로 로그인 해야됨 (리다이렉트)
        try {
            SocialUser sUser = socialUserService.get(dbUser.getUserId());
            return ResponseEntity
                    .status(AuthMessage.LOGIN_BAD_REQUEST.getStatus())
                    .body(AuthMessage.LOGIN_BAD_REQUEST.getMessage()
                            + "(" + sUser.getProvider() + ")");
        } catch (Exception e) {
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

    // 유저 수정
    @PostMapping("/mod")
    public ResponseEntity<?> mod(@RequestParam("id") String id,
                                 @RequestParam("name") String name,
                                 HttpSession httpSession) {

        // #1. 요청 권한 확인 (세션에서 유저 정보 확인)
        User curUser = (User) httpSession.getAttribute("user");
        if (curUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }
        if (!curUser.getUserId().equals(id)) {
            return ResponseEntity
                    .status(ResponseMessage.FORBIDDEN.getStatus())
                    .body(ResponseMessage.FORBIDDEN.getMessage());
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

            return ResponseEntity
                    .status(AuthMessage.USER_MODIFY_SUCCESS.getStatus())
                    .body(AuthMessage.USER_MODIFY_SUCCESS.getMessage());
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

    // 유저 삭제
    @PostMapping("/del")
    public ResponseEntity<?> del(@RequestParam("id") String id, HttpSession httpSession) {
        // 권한 체크
        User curUser = (User) httpSession.getAttribute("user");
        if (curUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }
        if (!curUser.getUserId().equals(id)) {
            return ResponseEntity
                    .status(ResponseMessage.FORBIDDEN.getStatus())
                    .body(ResponseMessage.FORBIDDEN.getMessage());
        }

        // 탈퇴 시도
        try {
            // DB 접근
            userService.softDel(id);
            // userService.del(id);

            // 로그아웃 처리
            httpSession.removeAttribute("user");
            httpSession.invalidate();

            // 읃답 반환
            return ResponseEntity
                    .status(AuthMessage.USER_DELETE_SUCCESS.getStatus())
                    .body(AuthMessage.USER_DELETE_SUCCESS.getMessage());
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity
                    .status(AuthMessage.USER_DELETE_FAIL.getStatus())
                    .body(AuthMessage.USER_DELETE_FAIL.getMessage());
        }
    }

    // 계정 찾기
    @PostMapping("/find-account")
    public ResponseEntity<?> findAccount(@RequestParam("email") String email) {
        System.out.println("Received email: " + email);
        try {
            // #1. 해당 이메일을 사용하는 유저가 있는지 검색
            User dbUser = userService.getByEmail(email);

            if (dbUser == null) {
                return ResponseEntity
                        .status(AuthMessage.EMAIL_NOTFOUND.getStatus())
                        .body(AuthMessage.EMAIL_NOTFOUND.getMessage());
            }

            // #2. 소셜 유저인지 확인
            SocialUser dbSocialUser = socialUserService.get(dbUser.getUserId());
            if (dbSocialUser != null) {
                String msg = dbSocialUser.getProvider() + " 계정으로 가입한 회원입니다.\n"
                        + "연동 일자: " + dbSocialUser.getConnectedAt();
                return ResponseEntity
                        .status(AuthMessage.LOGIN_FAIL_SOCIAL.getStatus())
                        .body(msg);
            }

            // #3. 이메일로 가입한 유저라면
            // 비밀번호를 임시 비밀번호로 바꿈
            String rawPwd = AuthUtil.generatePwd();
            String encryptedPwd = bCryptPasswordEncoder.encode(rawPwd);
            dbUser.setPassword(encryptedPwd);
            userService.mod(dbUser);

            //log.info("유저 정보 변경됨 : " + dbUser.toString());
            //log.info("변경된 비밀번호: " + rawPwd);

            // 바뀐 비밀번호 + 아이디 정보를 이메일로 전송
            emailService.sendEmail(email,
                    "[알트스페이스] 임시 비밀번호 발급",
                    "임시 비밀번호 : " + rawPwd);

            // 전송 후 안내 메시지 반환
            return ResponseEntity
                    .status(AuthMessage.FIND_ACCOUNT_SUCCESS.getStatus())
                    .body(AuthMessage.FIND_ACCOUNT_SUCCESS.getMessage());

        } catch (Exception e) {
            log.error("계정 찾기 중 예외 발생: {}", e.getMessage());
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

    // 비밀번호 변경
    @PostMapping("/change-pwd-impl")
    public ResponseEntity<?> changePwdImpl(@RequestBody Map<String, String> pwdData,
                                           HttpSession httpSession) throws Exception {
        String oldPwd = pwdData.get("oldPwd");
        String newPwd = pwdData.get("newPwd");

        //log.info("oldPwd: " + oldPwd);
        //log.info("newPwd: " + newPwd);

        // 현재 로그인한 사용자
        User user = (User) httpSession.getAttribute("user");
        User dbUser = userService.get(user.getUserId());

        // 비밀번호 매칭
        if (dbUser.getPassword() != null && bCryptPasswordEncoder.matches(oldPwd, dbUser.getPassword())) {
            dbUser.setPassword(bCryptPasswordEncoder.encode(newPwd));
            userService.mod(dbUser);
            httpSession.setAttribute("user", dbUser);
            return ResponseEntity
                    .status(AuthMessage.PWD_CHANGE_SUCCESS.getStatus())
                    .body(AuthMessage.PWD_CHANGE_SUCCESS.getMessage());
        } else if (!bCryptPasswordEncoder.matches(oldPwd, dbUser.getPassword())) {
            return ResponseEntity
                    .status(AuthMessage.PWD_CHANGE_BAD_REQUEST.getStatus())
                    .body(AuthMessage.PWD_CHANGE_BAD_REQUEST.getMessage());
        }

        // 디폴트 응답 (처리 불가)
        return ResponseEntity
                .status(ResponseMessage.ERROR.getStatus())
                .body(ResponseMessage.ERROR.getMessage());
    }

    // 이메일 중복 체크
    @PostMapping("/check-email")
    public ResponseEntity<?> checkEmail(@RequestParam("email") String email) {
        try {
            User dbUser = userService.getByEmail(email);
            if (dbUser != null) {
                return ResponseEntity
                        .status(AuthMessage.EMAIL_CONFLICT.getStatus())
                        .body(AuthMessage.EMAIL_CONFLICT.getMessage());
            }
            return ResponseEntity
                    .status(AuthMessage.EMAIL_AVAILABLE.getStatus())
                    .body(AuthMessage.EMAIL_AVAILABLE.getMessage());
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

}
