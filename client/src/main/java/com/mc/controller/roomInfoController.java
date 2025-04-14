package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/roominfo")
public class roomInfoController {

    String dir ="roomInfo/";

    @RequestMapping("")
    public String roomInfo(Model model) {
        model.addAttribute("center", dir + "center");
        return "roominfo";
    }
}
