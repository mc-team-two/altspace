package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Payments;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewService;
import com.mc.util.PapagoUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
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
    public String update(Reviews reviews) throws Exception {
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
    public String reviewUpload(Model model,
                               @RequestParam("id") int id,
                               Reviews reviews) throws Exception {

        reviewService.add(reviews);
        return "redirect:/review";
    }

    /* 리뷰 번역 */
    @PostMapping("/translate")
    public ResponseEntity<String> translate(@RequestBody Map<String, String> body) {
        String msg = body.get("msg");
        String target = body.get("target");

        log.info(msg);
        log.info(target);

        String translatedText = PapagoUtil.getMsg(papagoId, papagoKey, msg, target);
        return ResponseEntity.ok(translatedText);
    }
}
