package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/about")
public class AboutController {

    String dir = "about/";

    @RequestMapping("")
    public String about(Model model) {
        model.addAttribute("center", dir + "center");
        return "index";
    }
}
