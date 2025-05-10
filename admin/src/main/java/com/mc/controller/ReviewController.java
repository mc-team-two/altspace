package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.SimpReview;
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
@RequestMapping("/review")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    String dir = "review/";

    private final ReviewService reviewService;
    private final AccomService accomService;

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

        List<SimpReview> rvList;

        // accId가 제공된 경우: 해당 숙소 ID에 대한 리뷰만 가져오기
        if (accId != null) {
            Map<String, Object> params = new HashMap<>();
            params.put("hostId", hostId);
            params.put("accId", accId);
            rvList = reviewService.getByHostIdAndAccId(params);
        } else {
            // 모든 리뷰 가져오기
            rvList = reviewService.getByHostId(hostId);
        }

        // 현재 로그인한 호스트의 숙소 목록 조회
        List<Accommodations> accList = accomService.getByHostId(user.getUserId());

        log.info("rvList--------------------------------");
        log.info(rvList.toString());

        model.addAttribute("accList", accList);
        model.addAttribute("rvList", rvList);
        model.addAttribute("center", dir + "list");

        return "index";
    }
}