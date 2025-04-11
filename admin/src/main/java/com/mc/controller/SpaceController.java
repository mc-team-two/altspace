package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/space")
public class SpaceController {

    String dir = "space/";

    @RequestMapping("/space1")
    public String space1(Model model){
        model.addAttribute("center", dir+"space1");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/space2")
    public String space2(Model model){
        model.addAttribute("center", dir+"space2");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/space3")
    public String space3(Model model){
        model.addAttribute("center", dir+"space3");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/space4")
    public String space4(Model model){
        model.addAttribute("center", dir+"space4");
        model.addAttribute("index", dir+"index");
        return "index";
    }
}
