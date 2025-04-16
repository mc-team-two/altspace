package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/details")
public class detailsController {

    String dir ="details/";

    @RequestMapping("")
    public String details(Model model) {
        model.addAttribute("center", dir + "center");
        return "details";
    }
}
