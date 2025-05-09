package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
@RequestMapping("/review")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    final AccomService accomService;
    final ReviewService reviewService;

    String dir = "review/";

    @RequestMapping("/list")
    public String list (Model model, HttpSession httpSession) throws Exception {
        /*
        // 로그인 한 사용자 정보 가져오기
        User user = (User)httpSession.getAttribute("user");
        // 사용자 정보 없으면 리다이렉트
        if (httpSession.getAttribute("user") != null) {
            return "redirect:/";
        }

        // 사용자 정보에서 아이디 가져오기
        String hostId = user.getUserId();

        List<Reviews> rvList = reviewService.getByHostId(hostId);
        log.info(rvList.toString());

        model.addAttribute("rvList", rvList);*/
        model.addAttribute("center", dir+"list");
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