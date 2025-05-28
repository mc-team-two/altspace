package com.mc.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mc.app.dto.*;
import com.mc.app.service.*;
import com.mc.util.GeminiUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    @Value("${app.url.webSocketUrl}")
    String webSocketUrl;

    @Value("${app.key.kakaoJSApiKey}")
    String kakaoJSApiKey;

    final WishlistService wishlistService;
    final AccomService accomService;
    final PaymentService paymentService;
    final ReviewService reviewService;
    final GeminiUtil geminiUtil;

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
        model.addAttribute("kakaoJSApiKey", kakaoJSApiKey);

        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");

        List<AccomodationsWithRating> accommodationsWithRatingList = accomService.getAccommodationsWithRating(pageInfo.getList());
        model.addAttribute("accommodationsWithRatingList", accommodationsWithRatingList);

        return "index";
    }

    @RequestMapping("/contacts")
    public String contacts(Model model) {
        model.addAttribute("center", "contacts/center");
        return "index";
    }

    @RequestMapping("/faq1")
    public String faq1(Model model) {

        model.addAttribute("center", "faq1/center");
        return "index";
    }

    @RequestMapping("/faq2")
    public String faq2(Model model) {

        model.addAttribute("center", "faq2/center");

        return "index";
    }

    @RequestMapping("/faq3")
    public String faq3(Model model) {

        model.addAttribute("center", "faq3/center");

        return "index";
    }

    @RequestMapping("/detail")
    public String detail(Model model,
                         @RequestParam("id") int id,
                         @RequestParam(value = "pyStatus", required = false) String pyStatus,
                         @RequestParam(value = "paymentId", required = false) Integer paymentId,
                         HttpSession httpSession) throws Exception {

        Accommodations accomm = accomService.get(id);
        model.addAttribute("accomm", accomm);

        // 로그인 사용자 정보 가져오기
        User user = (User) httpSession.getAttribute("user");
        if (user != null) {
            String userId = user.getUserId();
            // DB 조회용 객체 생성
            Wishlist wishlist = new Wishlist();
            wishlist.setUserId(userId);
            wishlist.setAccommodationId(id);

            // 숙소 ID와 유저 ID로 찜 여부 확인
            Wishlist resultWishlist = wishlistService.wishlistSelect(wishlist);

            model.addAttribute("resultWishlist", resultWishlist);
        } else {
            model.addAttribute("resultWishlist", null); // 비로그인 상태일 경우
        }

        List<Payments> chInChOut = paymentService.selectCheckInCheckOut(id);
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

    @PostMapping("/analyze-heatmap")
    @ResponseBody
    public String analyzeHeatmap(@RequestBody List<PopularLocation> stats) {
        try {
            StringBuilder prompt = new StringBuilder();
            prompt.append("다음은 호텔별별 숙소 통계입니다. 이를 분석해서, 상위 5개 지역만 조회수, 예약수, 평점에 따라 인사이트를 요약해주세요:\n\n");

            for (PopularLocation loc : stats) {
                prompt.append(String.format(
                        "- 호텔명: %s, 조회수: %d, 예약수: %d, 평점: %.1f\n",
                        loc.getName(),
                        loc.getTotalViews(),
                        loc.getBookingCount(),
                        loc.getAvgRating() != null ? loc.getAvgRating() : 0.0
                ));
            }

            prompt.append("\n주요 지역, 통계적 이상치, 추천 마케팅 포인트를 포함해주세요.");

            return geminiUtil.askGemini(prompt.toString(), "짧고 인사이트 있게 요약해 주세요." +
                    "절대로 호텔명, 조회수, 예약수, 평점, 인사이트는 꼭꼭 기재해주세요." +
                    "절대로 마크다운, 설명 문장, 코드 블록, 주석등, 불필요한 설명 없이 json 배열 형식으로 응답해주세요.");
        } catch (Exception e) {
            e.printStackTrace();
            return "Gemini 분석 중 오류 발생";
        }
    }
}