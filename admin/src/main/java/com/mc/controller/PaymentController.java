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

import java.util.List;

@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
@Slf4j
public class PaymentController {

    String dir = "payment/";
    final PaymentService paymentService;

    @RequestMapping("/payment1")
    public String payment1(Model model, HttpSession httpSession) throws Exception {
        User user = (User) httpSession.getAttribute("user");
        List<Payments> payments = paymentService.getByHostId(user.getUserId());

        model.addAttribute("payments", payments);
        model.addAttribute("center", dir+"payment1");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/payment2")
    public String payment2(Model model){
        model.addAttribute("center", dir+"payment2");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/payment3")
    public String payment3(Model model){
        model.addAttribute("center", dir+"payment3");
        model.addAttribute("index", dir+"index");
        return "index";
    }
    
}
