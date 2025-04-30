package com.mc.controller;

import com.mc.app.dto.Guide;
import com.mc.app.service.GuideService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/support")
public class SupportController {

    final GuideService guideService;

    String dir = "support/";

    @RequestMapping("/guide")
    public String guide(Model model) throws Exception {
        List<Guide> guides = null;
        guides = guideService.get();

        model.addAttribute("guides", guides);
        model.addAttribute("center", dir + "guide");
        model.addAttribute("index", dir + "index");
        return "index";
    }

    @RequestMapping("/message")
    public String message(Model model){
        model.addAttribute("center", dir+"message");
        model.addAttribute("index", dir+"index");
        return "index";
    }
    
}
