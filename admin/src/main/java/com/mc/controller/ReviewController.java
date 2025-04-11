package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/review")
public class ReviewController {

    String dir = "review/";

    @RequestMapping("/review1")
    public String review1(Model model){
        model.addAttribute("center", dir+"review1");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/review2")
    public String review2(Model model){
        model.addAttribute("center", dir+"review2");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/review3")
    public String review3(Model model){
        model.addAttribute("center", dir+"review3");
        model.addAttribute("index", dir+"index");
        return "index";
    }
    
}
