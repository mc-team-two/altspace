package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/review")
public class ReviewController {

    String dir = "review/";

    @RequestMapping("/list")
    public String review1(Model model){
        model.addAttribute("center", dir+"list");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/check")
    public String review2(Model model){
        model.addAttribute("center", dir+"check");
        model.addAttribute("index", dir+"index");
        return "index";
    }
    
}
