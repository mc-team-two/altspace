package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/review")
public class reviewController {

    String dir ="review/";

    @RequestMapping("")
    public String review(Model model) {
        model.addAttribute("center", dir + "center");
        return "review";
    }
}
