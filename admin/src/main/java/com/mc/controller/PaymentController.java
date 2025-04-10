package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    String dir = "payment/";

    @RequestMapping("/payment1")
    public String payment1(Model model){
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
