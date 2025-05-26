package com.mc.controller;

import com.mc.app.dto.*;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewImageService;
import com.mc.app.service.ReviewRepliesService;
import com.mc.app.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
    private final ReviewImageService reviewImageService;
    private final AccomService accomService;
    private final ReviewRepliesService reviewRepliesService;

    // TODO: 이거 page로 바꾸기
    @RequestMapping("/list")
    public String list(
        @RequestParam(value = "accId", required = false) Integer accId,
        Model model,
        HttpSession httpSession) throws Exception {

        // 권한 제어
        User user = (User) httpSession.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }

        // 사용자 정보가 존재하면 ----
        String hostId = user.getUserId();  // 호스트 id 추출

        // 가져오기 #1: 현재 호스트의 모든 숙소 목록 조회 (사이드바 뿌리는 용도)
        List<Accommodations> accList = accomService.getListByHostId(hostId);

        // 가져오기 #2: 호스트의 숙소에 대한 리뷰 가져오기
        List<Reviews> rvList;
        
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
        Map<Integer, List<ReviewReplies>> replyMap = new HashMap<>();
        for (ReviewReplies reply : replyList) {
            replyMap
                    .computeIfAbsent(reply.getReviewId(), k -> new ArrayList<>())
                    .add(reply);
        }

        // 가져오기 #4: 리뷰 이미지
        List<ReviewImage> reviewImageList = reviewImageService.getByHostId(hostId);
        Map<Integer, List<String>> imageMap = new HashMap<>();
        for (ReviewImage image : reviewImageList) {
            imageMap.computeIfAbsent(image.getReviewId(), k -> new ArrayList<>()).add(image.getImageUrl());
        }

        // 최종: 리뷰별 데이터 묶기
        List<Map<String, Object>> reviewMapList = new ArrayList<>();
        for (Reviews r : rvList) {
            Map<String, Object> map = new HashMap<>();
            map.put("review", r);
            map.put("reply", replyMap.getOrDefault(r.getReviewId(), new ArrayList<>()));
            map.put("images", imageMap.getOrDefault(r.getReviewId(), new ArrayList<>()));

            reviewMapList.add(map);
        }

        model.addAttribute("reviewMap", reviewMapList);
        model.addAttribute("accList", accList);
        model.addAttribute("center", dir + "list");

        return "index";
    }

}