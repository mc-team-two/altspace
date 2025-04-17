package com.mc.controller;

import com.mc.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.mc.app.dto.User;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final UserService userService;
    String dir = "home/";

    @RequestMapping("/")
    public String main(Model model){
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "index";
    }

    @RequestMapping("/contacts")
    public String contacts(){
        return "contacts";
    }

    @RequestMapping("/elements")
    public String elements(){
        return "elements";
    }
}