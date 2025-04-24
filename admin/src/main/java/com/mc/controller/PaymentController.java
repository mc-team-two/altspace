package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Payments;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
@Slf4j
public class PaymentController {

    private final AccomService accomService;
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

    @RequestMapping("/booking")
    public String booking(Model model, HttpSession httpSession) throws Exception {
        User user = (User) httpSession.getAttribute("user");
        List<Payments> payments = paymentService.getByHostId(user.getUserId());

        // accommodationId 기준으로 중복 제거 후 오름차순 정렬
        List<Payments> distinctPayments = payments.stream()
                .collect(Collectors.collectingAndThen(
                        Collectors.toMap(Payments::getAccommodationId, p -> p, (p1, p2) -> p1),
                        map -> map.values().stream()
                                .sorted(Comparator.comparing(Payments::getAccommodationId)) // 오름차순 정렬
                                .toList()
                ));

        List<Accommodations> accommodations = accomService.getByUserId(user.getUserId());

        model.addAttribute("payments", distinctPayments); // 중복 제거된 리스트
        model.addAttribute("accommodations", accommodations);
        model.addAttribute("center", dir + "booking");
        model.addAttribute("index", dir + "index");

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
