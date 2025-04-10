package com.mc.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("")
public class MainController {

    String dir = "home/";

    @RequestMapping("/")
    public String main(Model model){
        model.addAttribute("center", dir + "center");
        return "index";
    }

    @RequestMapping("/elements")
    public String elements(){
        return "elements";
    }
}
