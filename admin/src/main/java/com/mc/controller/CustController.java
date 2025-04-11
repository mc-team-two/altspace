package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cust")
public class CustController {

    String dir = "cust/";

    @RequestMapping("/cust1")
    public String cust1(Model model){
        model.addAttribute("center", dir+"cust1");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/cust2")
    public String cust2(Model model){
        model.addAttribute("center", dir+"cust2");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/cust3")
    public String cust3(Model model){
        model.addAttribute("center", dir+"cust3");
        model.addAttribute("index", dir+"index");
        return "index";
    }
    
}
