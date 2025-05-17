package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.ReviewReplies;
import com.mc.app.dto.SimpReview;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewRepliesService;
import com.mc.app.service.ReviewService;
import com.mc.util.ReviewUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/review")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    String dir = "review/";

    private final ReviewService reviewService;
    private final AccomService accomService;
    private final ReviewRepliesService reviewRepliesService;

    // TODO: 이거 page로 바꾸기
    @RequestMapping("/list")
    public String listByAcc(
            @RequestParam(value = "accId", required = false) Integer accId,
            Model model,
            HttpSession httpSession) throws Exception {

        // 세션에서 사용자 정보 가져오기
        User user = (User) httpSession.getAttribute("user");

        // 사용자 세션이 없는 경우, 메인 페이지로 리다이렉트
        if (user == null) {
            return "redirect:/";
        }

        // 사용자 정보가 존재하면 ----
        String hostId = user.getUserId();  // 호스트 id 추출


        // 가져오기 #1: 현재 호스트의 모든 숙소 목록 조회 (사이드바 뿌리는 용도)
        List<Accommodations> accList = accomService.getByHostId(hostId);

        // 가져오기 #2: 호스트의 숙소에 대한 리뷰 가져오기
        List<SimpReview> rvList;
        
        // 특정 숙소에 대한 리뷰만 가져오기
        if (accId != null) {
            Map<String, Object> params = new HashMap<>();
            params.put("hostId", hostId);
            params.put("accId", accId);
            rvList = reviewService.getByHostIdAndAccId(params);
        }
        // 모든 숙소에 대한 리뷰 가져오기
        else {
            rvList = reviewService.getByHostId(hostId);
        }
        
        // 가져오기 #3: 리뷰에 대한 호스트 답글 가져오기
        List<ReviewReplies> replyList = reviewRepliesService.getByHostId(hostId);

        // 리뷰와 답글을 같이 보여주기 위해서 순회해서 키밸류 쌍 만들기
        Map<SimpReview, List<ReviewReplies>> reviewMap =
                ReviewUtil.mapReviewsWithReplies(rvList, replyList);

        model.addAttribute("reviewMap", reviewMap);
        model.addAttribute("rvList", rvList);
        model.addAttribute("accList", accList);
        model.addAttribute("center", dir + "list");

        return "index";
    }

}