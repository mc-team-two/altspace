package com.mc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/roominfo")
public class roomInfoController {

    String dir ="roominfo/";

    // 2025-04-16 note.
    // 기존의 헤더 메인 nav의 마이페이지 페이지가 예약 내역 페이지로 변경예정
    // 일단 임시로 룸인포를 향하도록 해놨는데, 페이지 이름이 바뀔 시 이 컨트롤러의 이름도 바뀔 예정.

    @RequestMapping("")
    public String roominfo(Model model) {
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "index";
    }


}
