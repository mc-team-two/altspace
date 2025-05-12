package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Payments;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "index";
    }

    /* 리뷰 작성 페이지 이동 */
    @RequestMapping("/dtadd")
    public String dtadd(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);
        model.addAttribute("accomm", accomm);
        return "review";
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
}
