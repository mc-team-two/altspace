package com.mc.controller;

import com.mc.app.dto.Payments;
import com.mc.app.dto.User;
import com.mc.app.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
@Slf4j
public class PaymentController {

    String dir = "payment/";
    final PaymentService paymentService;

    @RequestMapping("/pay")
    public String pay(Model model, HttpSession httpSession) throws Exception {
        User user = (User) httpSession.getAttribute("user");

        // 로그인 했을 때만 접속 가능함
        if (user == null) {
            return "redirect:/auth/login";
        }

        List<Payments> payments = paymentService.getByHostId(user.getUserId());
        model.addAttribute("payments", payments);

        // 통계 데이터 생성 (상태별 건수)
        Map<String, Long> statusCounts = payments.stream()
                .collect(Collectors.groupingBy(Payments::getPayStatus, Collectors.counting()));
        model.addAttribute("statusCounts", statusCounts);
        model.addAttribute("center", dir+"pay");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/detail")
    public String detail(@RequestParam("accommodationId") int accommodationId, Model model,
                         HttpSession httpSession) throws Exception {
        // 로그인 했을 때만 접속 가능함
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        // 선택한 스페이스의 예약 내역을 가져옵니다.
        List<Payments> payments = paymentService.getByAccommodationId(accommodationId);
        model.addAttribute("payments", payments);
        model.addAttribute("filteredId", accommodationId);
        model.addAttribute("center", dir + "detail");
        model.addAttribute("index", dir + "index");
        return "index";
    }
}
