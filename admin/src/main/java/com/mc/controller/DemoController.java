package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/demo")
public class DemoController {
    String dir = "demo/";

    @RequestMapping("/login")
    public String logindemo() {
        return dir + "login";
    }

    @RequestMapping("/register")
    public String registerdemo() {
        return dir + "register";
    }
}
