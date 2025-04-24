package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    String dir = "dashboard/";

    @RequestMapping("/dashboard")
    public String dashboard1(Model model){
        model.addAttribute("center", dir+"dashboard");
        model.addAttribute("index", dir+"index");
        return "index";
    }
}
