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
        List<Payments> payments = paymentService.getByHostId(user.getUserId());

        model.addAttribute("payments", payments);
        model.addAttribute("center", dir+"pay");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/detail")
    public String detail(@RequestParam("accommodationId") int accommodationId, Model model) throws Exception {
        // 선택한 스페이스의 예약 내역을 가져옵니다.
        List<Payments> payments = paymentService.getByAccommodationId(accommodationId);
        model.addAttribute("payments", payments);
        model.addAttribute("filteredId", accommodationId);
        model.addAttribute("center", dir + "detail");
        model.addAttribute("index", dir + "index");
        return "index";
    }
}
