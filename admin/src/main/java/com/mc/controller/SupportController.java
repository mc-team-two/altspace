package com.mc.controller;

import com.mc.app.dto.Guide;
import com.mc.app.service.GuideService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/support")
public class SupportController {

    @Value("${app.url.serverUrl}")
    String serverUrl;

    final GuideService guideService;

    String dir = "support/";

    @RequestMapping("/guide")
    public String guide(Model model, HttpSession httpSession) throws Exception {
        // 권한 제어
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        List<Guide> guides;
        guides = guideService.get();

        model.addAttribute("guides", guides);
        model.addAttribute("center", dir + "guide");
        model.addAttribute("index", dir + "index");
        return "index";
    }

    @RequestMapping("/message")
    public String message(Model model, HttpSession httpSession){
        // 권한 제어
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("serverUrl", serverUrl);
        return dir+"message";
    }
    
}
