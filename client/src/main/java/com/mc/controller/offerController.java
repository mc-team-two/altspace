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
    // 페이지가 사라져서 컨트롤러 날리려다 숙소 관련 기능으로 사용될 거 같아서 일단 살려둠
}