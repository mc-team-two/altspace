package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Payments;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
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

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    private final UserService userService;
    final AccomService accomService;
    final PaymentService paymentService;
    final ReviewService reviewService;

    String dir = "home/";

    @RequestMapping("/")
    public String main(Model model) throws Exception {

        List<Accommodations> accomm = null;
        accomm = accomService.get();

        model.addAttribute("accomm", accomm);
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
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
                         @RequestParam(value = "paymentId", required = false) Integer paymentId) throws Exception {

        Accommodations accomm = accomService.get(id);
        model.addAttribute("accomm", accomm);

        List<Reviews> review = reviewService.selectReviewsAll(id);
        model.addAttribute("review", review);

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
        return "detail";
    }
}