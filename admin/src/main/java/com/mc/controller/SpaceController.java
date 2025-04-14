package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/space")
public class SpaceController {

    String dir = "space/";

    @RequestMapping("/add")
    public String add(Model model){
        model.addAttribute("center", dir+"add");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/get")
    public String get(Model model){
        model.addAttribute("center", dir+"get");
        model.addAttribute("index", dir+"index");
        return "index";
    }
}
