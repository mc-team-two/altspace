package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/about")
public class aboutController {

    String dir = "about/";

    @RequestMapping("")
    public String about(Model model) {
        model.addAttribute("header", dir + "header");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "about";
    }
}
