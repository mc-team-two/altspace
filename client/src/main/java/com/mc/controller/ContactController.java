package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contact")
public class ContactController {
    @RequestMapping("")
    public String main() {
        return "contact";
    }
}