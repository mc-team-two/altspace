package com.mc.controller;

import com.mc.app.dto.User;
import com.mc.app.service.SocialUserService;
import com.mc.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class MypageController {

    private final UserService userService;
    private final String dir = "mypage/";

    // 마이페이지 홈
    @GetMapping("")
    public String mypage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("center", dir + "center");
        return "index";
    }

    // 내 정보 수정 페이지
    @GetMapping("/modify-info")
    public String showModifyInfoPage(HttpSession session, Model model) {
        model.addAttribute("user", session.getAttribute("user"));
        model.addAttribute("center", dir + "modify-info");
        return "index";
    }

    // 비밀번호 재설정 페이지
    @GetMapping("/reset-password")
    public String showResetPasswordPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user.getPassword() == null) {
            model.addAttribute("errorMessage", "소셜 로그인 회원은 비밀번호를 변경할 수 없습니다.");
        }
        model.addAttribute("center", dir + "reset-password");
        return "index";
    }

    // 회원 탈퇴 페이지
    @GetMapping("/delete-account")
    public String showDeleteAccountPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user.getPassword() == null) {
            model.addAttribute("socialAccount", true); // JSP에서 소셜 계정 여부 표시용
        }
        model.addAttribute("center", dir + "delete-account");
        return "index";
    }

    // 내 정보 수정 처리
    @PostMapping("/modify-info")
    public String updateUserInfo(@ModelAttribute User updatedUser, HttpSession session, Model model) throws Exception {
        User sessionUser = (User) session.getAttribute("user");

        sessionUser.setName(updatedUser.getName());
        sessionUser.setPhone(updatedUser.getPhone());
        userService.mod(sessionUser);

        session.setAttribute("user", sessionUser);
        model.addAttribute("user", sessionUser);
        model.addAttribute("successMessage", "회원 정보가 수정되었습니다.");
        model.addAttribute("center", dir + "modify-info");
        return "index";
    }

    // 비밀번호 재설정 처리
    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String currentPassword,
                                @RequestParam String newPassword,
                                HttpSession session,
                                Model model) throws Exception {
        User user = (User) session.getAttribute("user");

        if (user.getPassword() == null) {
            model.addAttribute("errorMessage", "소셜 로그인 회원은 비밀번호를 변경할 수 없습니다.");
            model.addAttribute("center", dir + "reset-password");
            return "index";
        }

        if (!user.getPassword().equals(currentPassword)) {
            model.addAttribute("errorMessage", "현재 비밀번호가 일치하지 않습니다.");
            model.addAttribute("center", dir + "reset-password");
            return "index";
        }

        user.setPassword(newPassword);
        userService.mod(user);
        session.setAttribute("user", user);
        model.addAttribute("successMessage", "비밀번호가 변경되었습니다.");
        model.addAttribute("center", dir + "reset-password");
        return "index";
    }

    // 회원 탈퇴 처리
    @PostMapping("/delete-account")
    public String deleteAccount(@RequestParam(required = false) String confirmPassword,
                                HttpSession session,
                                Model model) throws Exception {
        User user = (User) session.getAttribute("user");

        if (user.getPassword() == null) {
            // 소셜 로그인 사용자는 confirmPassword 없이 바로 삭제
            userService.del(user.getUserId());
            session.invalidate();
            return "redirect:/";
        }

        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            model.addAttribute("center", dir + "delete-account");
            return "index";
        }

        userService.del(user.getUserId());
        session.invalidate();
        return "redirect:/";
    }
}