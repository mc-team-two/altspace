package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/offers")
public class offerController {
    @RequestMapping("")
    public String main() {
        return "offers";
    }
}