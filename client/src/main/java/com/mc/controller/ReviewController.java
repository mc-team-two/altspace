package com.mc.controller;

import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewService;
import com.mc.util.PapagoUtil;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/review")
public class ReviewController {

    final AccomService accomService;
    final ReviewService reviewService;
    String dir ="review/";

    @Value("${ncp.papago.id}")
    String papagoId;
    @Value("${ncp.papago.key}")
    String papagoKey;

    @RequestMapping("")
    public String review(Model model, HttpSession httpSession) throws Exception {

        User user = (User)httpSession.getAttribute("user");

        if (user == null) {
            return "redirect:/login"; // 세션 만료나 비로그인 처리
        }

        // user 객체에서 아이디 가져오기
        String userId = user.getUserId();

        // DB 조회용 객체 생성
        Reviews reviews = new Reviews();
        reviews.setGuestId(userId);

        // 실제 DB 조회(여러 건 가져올 수 있음)
        List<Reviews> ReviewList = reviewService.getMyReviews(reviews);
        model.addAttribute("ReviewList", ReviewList);
        model.addAttribute("center", dir + "center");
        return "index";
    }

    /* 리뷰 수정 */
    @RequestMapping("/update")
    public String update(@Valid Reviews reviews,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes) throws Exception {

        if (bindingResult.hasErrors()) {
            StringBuilder errorMessages = new StringBuilder();

            bindingResult.getFieldErrors().forEach(error -> {
                String field = error.getField();
                if (field.equals("grade") || field.equals("comment")) {
                    errorMessages.append(error.getDefaultMessage()).append("\n");
                }
            });

            if (errorMessages.length() > 0) {
                redirectAttributes.addFlashAttribute("errorMessage", errorMessages.toString());
                return "redirect:/review";
            }
        }

        reviewService.mod(reviews);
        return "redirect:/review";
    }

    /* 리뷰 삭제 */
    @RequestMapping("/delete")
    public String delete(Model model, @RequestParam("rvId") int rvid) throws Exception {
        reviewService.del(rvid);
        return "redirect:/review";
    }

    /* 리뷰 업로드 */
    @RequestMapping("/reviewUpload")
    public String reviewUpload(@Valid Reviews reviews,
                               BindingResult bindingResult,
                               @RequestParam("id") int id,
                               RedirectAttributes redirectAttributes) throws Exception {

        /* DTO에서 유효성 검사 */
        if (bindingResult.hasErrors()) {
            StringBuilder errorMessages = new StringBuilder();
            boolean redirectToLogin = false;

            for (FieldError error : bindingResult.getFieldErrors()) {
                errorMessages.append(error.getDefaultMessage()).append("\n");

                // guestId 또는 accommodationId가 문제일 경우 로그인으로 리다이렉트
                if (error.getField().equals("guestId") || error.getField().equals("accommodationId")) {
                    redirectToLogin = true;
                }
            }

            redirectAttributes.addFlashAttribute("errorMessage", errorMessages.toString());

            if (redirectToLogin) {
                return "redirect:/login";
            }

            // 그 외 유효성 오류는 다시 리뷰 작성 폼으로
            return "redirect:/reviewAdd?id=" + id;
        }

        reviewService.add(reviews);
        return "redirect:/review";
    }

    /* 리뷰 번역 */
    @PostMapping("/translate")
    public ResponseEntity<String> translate(@RequestBody Map<String, String> body) {
        String msg = body.get("msg");
        String target = body.get("target");

        String translatedText = PapagoUtil.getMsg(papagoId, papagoKey, msg, target);
        return ResponseEntity.ok(translatedText);
    }

    /* 리뷰 요약 */
    @ResponseBody
    @GetMapping("reviewSummary/{id}")
    public String getReviewSummary(Model model,
                                   @PathVariable("id") int id) throws Exception {
        String getResult = reviewService.getReviewSummary(id);
        return getResult;
    }

}
