package com.mc.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mc.app.dto.*;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import com.mc.app.service.ReviewService;
import com.mc.app.service.UserService;
import java.sql.Date;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    @Value("${app.url.webSocketUrl}")
    String webSocketUrl;

    private final UserService userService;
    final AccomService accomService;
    final PaymentService paymentService;
    final ReviewService reviewService;

    @Value("${app.key.kakaoJSApiKey}")
    String kakaoJSApiKey;
  
    private static final int PAGE_SIZE = 10; // 한 페이지에 표시할 숙소 수

    String dir = "home/";

    @RequestMapping("/")
    public String main(Model model,
                       @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) throws Exception {

        PageHelper.startPage(pageNum, PAGE_SIZE); // PageHelper 시작


        List<Accommodations> allAccomm = accomService.get();
        PageInfo<Accommodations> pageInfo = new PageInfo<>(allAccomm); // PageInfo 객체 생성

        model.addAttribute("accomm", allAccomm);
        model.addAttribute("pageInfo", pageInfo);

        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");

        List<AccomodationsWithRating> accommodationsWithRatingList = accomService.getAccommodationsWithRating(pageInfo.getList());
        model.addAttribute("accommodationsWithRatingList", accommodationsWithRatingList);

        return "index";
    }

    @RequestMapping("/contacts")
    public String contacts(Model model){
        model.addAttribute("headers", "contacts/headers");
        model.addAttribute("center", "contacts/center");
        model.addAttribute("footer", "contacts/footer");
        return "index";
    }

    @RequestMapping("/contacts2")
    public String contacts2(Model model){
        model.addAttribute("headers", "contacts2/headers");
        model.addAttribute("center", "contacts2/center");
        model.addAttribute("footer", "contacts2/footer");
        return "index";
    }

    @RequestMapping("/detail")
    public String detail(Model model,
                         @RequestParam("id") int id,
                         @RequestParam(value = "pyStatus", required = false) String pyStatus,
                         @RequestParam(value = "paymentId", required = false) Integer paymentId) throws Exception {

        Accommodations accomm = accomService.get(id);
        model.addAttribute("accomm", accomm);

        List<Payments> chInChOut =  paymentService.selectCheckInCheckOut(id);
        model.addAttribute("chInChOut", chInChOut);

        List<Reviews> review = reviewService.selectReviewsAll(id);
        model.addAttribute("review", review);

        // 총 리뷰 수
        int reviewCount = review.size();
        model.addAttribute("reviewCount", reviewCount);
        // 평점 평균 계산
        double averageRating = 0.0;
        if (reviewCount > 0) {
            double sum = 0.0;
            for (Reviews r : review) {
                sum += r.getGrade();
            }
            averageRating = Math.round((sum / (double) reviewCount) * 10.0) / 10.0; // 소수점 1자리 반올림
        }
        model.addAttribute("averageRating", averageRating);

        // pyStatus가 '완료'이고 paymentId 있다면 결제 상세 조회
        if ("완료".equals(pyStatus) && paymentId != null) {
            Payments payInfo = paymentService.selectPayment(paymentId);  // paymentId 조회하는 메서드

            // LocalDate → java.sql.Date 로 변환
            Date checkInDate = Date.valueOf(payInfo.getCheckIn());
            Date checkOutDate = Date.valueOf(payInfo.getCheckOut());

            model.addAttribute("pyStatus", pyStatus);
            model.addAttribute("payInfo", payInfo);
            model.addAttribute("checkInDate", checkInDate);
            model.addAttribute("checkOutDate", checkOutDate);

        }

        model.addAttribute("kakaoJSApiKey", kakaoJSApiKey);
        model.addAttribute("headers", "payments/headers");
        model.addAttribute("center", "payments/center");
        model.addAttribute("footer", "payments/footer");

        return "index";
    }

    @PostMapping("/save-location")
    @ResponseBody
    public String saveLocation(@RequestBody Map<String, Double> location, HttpSession session) {
        double latitude = location.get("latitude");
        double longitude = location.get("longitude");

        // 세션에 위치 정보 저장
        session.setAttribute("userLatitude", latitude);
        session.setAttribute("userLongitude", longitude);

        return "위치 정보가 세션에 저장되었습니다.";
    }

    @RequestMapping("/chat/{accId}")
    public String chat(Model model,
                       @PathVariable("accId") Integer accId) throws Exception {
        Accommodations acc = accomService.get(accId);
        model.addAttribute("acc", acc);
        model.addAttribute("serverUrl", webSocketUrl);
        return "chat";
    }
}