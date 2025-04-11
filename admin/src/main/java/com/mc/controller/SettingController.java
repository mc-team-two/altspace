package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/setting")
public class SettingController {

    String dir = "setting/";

    @RequestMapping("/setting1")
    public String setting1(Model model){
        model.addAttribute("center", dir+"setting1");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/setting2")
    public String setting2(Model model){
        model.addAttribute("center", dir+"setting2");
        model.addAttribute("index", dir+"index");
        return "index";
    }
}
