package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/book")
public class BookController {

    String dir = "book/";

    @RequestMapping("/book1")
    public String book1(Model model){
        model.addAttribute("center", dir+"book1");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/book2")
    public String book2(Model model){
        model.addAttribute("center", dir+"book2");
        model.addAttribute("index", dir+"index");
        return "index";
    }

    @RequestMapping("/book3")
    public String book3(Model model){
        model.addAttribute("center", dir+"book3");
        model.addAttribute("index", dir+"index");
        return "index";
    }
    
}
