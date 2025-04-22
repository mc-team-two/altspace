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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    // 페이지 연결
    @RequestMapping("/login")
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

    // rest, util
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
            return "auth/register";
        }

        // 유효성 테스트 통과시 : 고유 id 부여 후 DB에 푸시
        // email -> 유니크 key
        if (userService.getByEmail(user.getEmail()) != null) {
            String msg = "사용중인 이메일 주소입니다.";
            model.addAttribute("msg", msg);
            return "auth/register";
        }

        // email 중복 아니라면
        user.setUserId(AuthUtil.generateUUID());
        try {
            userService.add(user);
            log.info(user.toString());
        } catch (Exception e) {
            String msg = e.toString();
            model.addAttribute("msg", msg);
            return "auth/register";
        }
        return "redirect:auth/login";
    }

    @PostMapping("/loginimpl")
    public String loginimpl(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            Model model, HttpSession httpSession) {

        // DB 접근 #1 - email 사용자가 있는지 확인
        User dbUser = userService.getByEmail(email);

        // 1. 유저가 존재하지 않음
        if (dbUser == null) {
            model.addAttribute("msg", "이메일 혹은 비밀번호가 틀렸습니다");
            return "auth/login";
        }

        // 2. 일반 이메일 회원 (비밀번호 필드가 있어야 함)
        if (dbUser.getPassword() != null) {
            // 패스워드 비교
            if (dbUser.getPassword().equals(password)) {
                httpSession.setAttribute("user", dbUser);
                return "redirect:/";
            } else {
                model.addAttribute("msg", "비밀번호가 틀렸습니다");
                return "auth/login";
            }
        }

        // 3. 소셜 로그인 회원
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
        // 세션에서 유저 정보 가져오기
        User curUser = (User) httpSession.getAttribute("user");

        if (curUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요한 요청입니다.");
        }
        if (!curUser.getUserId().equals(id)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("허가되지 않은 요청입니다.");
        }

        try {
            // User 객체의 name 필드 바꾸기
            curUser.setName(name);

            // DB 접근
            userService.mod(curUser);

            // 세션 처리
            httpSession.removeAttribute("user");
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
