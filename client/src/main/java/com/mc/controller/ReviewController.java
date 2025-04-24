package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Payments;
import com.mc.app.dto.AccomodationsWithRating;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.repository.AccomRepository;
import com.mc.app.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

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

    @RequestMapping("/dtadd")
    public String dtadd(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);
        model.addAttribute("accomm", accomm);
        return "review";
    }

    @RequestMapping("/reviewUpload")
    public String reviewUpload(Model model,
                               @RequestParam("id") int id,
                               Reviews reviews) throws Exception {

        reviewService.add(reviews);
        return "redirect:/detail?id=" + id;
    }






    @RequestMapping("/rvdtSel")
    public String review(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);

        model.addAttribute("accomm", accomm);
        return "redirect:/detail?id=" + id;
    }




    @RequestMapping("/update")
    public String update(Model model,
                         @RequestParam("id") int id,
                         Reviews reviews) throws Exception {

        reviewService.mod(reviews);
        return "redirect:/detail?id=" + id;
    }

    @RequestMapping("/delete")
    public String delete(Model model,
                         @RequestParam("rvId") int rvid,
                         @RequestParam("acId") int acid) throws Exception {

        reviewService.del(rvid);
        return "redirect:/detail?id=" + acid;
    }
}
