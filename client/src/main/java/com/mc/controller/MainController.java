package com.mc.controller;

import com.mc.app.dto.*;
import com.mc.app.repository.AccomRepository;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import com.mc.app.service.ReviewService;
import com.mc.app.service.UserService;
import java.sql.Date;
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
@RequiredArgsConstructor
@Slf4j
public class MainController {

    private final UserService userService;
    final AccomService accomService;
    final PaymentService paymentService;
    final ReviewService reviewService;
    private final AccomRepository accomRepository;

    String dir = "home/";

    @RequestMapping("/")
    public String main(Model model) throws Exception {

        List<Accommodations> accomm = accomService.get(); // 기존 숙소 목록 가져오기 (필요하다면)

        model.addAttribute("accomm", accomm);
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");

        // 서비스에서 숙소 목록과 평점 정보를 함께 가져오기
        List<AccomodationsWithRating> accommodationsWithRatingList = accomService.getAccommodationsWithRating();
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

    @RequestMapping("/detail")
    public String detail(Model model,
                         @RequestParam("id") int id,
                         @RequestParam(value = "pyStatus", required = false) String pyStatus,
                         @RequestParam(value = "reservationsId", required = false) Integer reservationsId) throws Exception {

        Accommodations accomm = accomService.get(id);
        model.addAttribute("accomm", accomm);

        // pyStatus가 '완료'이고 reservationsId 있다면 결제 상세 조회
        if ("완료".equals(pyStatus) && reservationsId != null) {
            Payments payInfo = paymentService.selectPayment(reservationsId);  // reservationsId로 조회하는 메서드

            // LocalDate → java.sql.Date 로 변환
            Date checkInDate = Date.valueOf(payInfo.getCheckIn());
            Date checkOutDate = Date.valueOf(payInfo.getCheckOut());

            model.addAttribute("pyStatus", pyStatus);
            model.addAttribute("payInfo", payInfo);
            model.addAttribute("checkInDate", checkInDate);
            model.addAttribute("checkOutDate", checkOutDate);
        }
        return "detail";
    }
}