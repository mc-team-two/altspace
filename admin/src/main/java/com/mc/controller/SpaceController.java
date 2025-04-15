package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/space")
@Controller
@RequiredArgsConstructor
@Slf4j
public class SpaceController {

    final AccomService accomService;

    @Value("${app.key.kakaoJSApiKey}")
    String kakaoJSApiKey;

    String dir = "space/";

    @RequestMapping("/add")
    public String add(Model model){
        model.addAttribute("kakaoJSApiKey", kakaoJSApiKey);
        model.addAttribute("center", dir+"add");
        return "index";
    }

    @PostMapping("/addimpl")
    public String addimpl(Accommodations acc,
                          HttpSession httpSession){

        // 현재 유저 정보
        User currentUser = (User) httpSession.getAttribute("user");
        acc.setHostId(currentUser.getUserId());

        // 활성 정보
        acc.setStatus("활성");

        log.info(acc.toString());
        // DB 접근
        try {
            accomService.add(acc);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 처리 후 리다이렉트
        return "redirect:/space/get";
    }


    @RequestMapping("/get")
    public String get(Model model){
        model.addAttribute("center", dir+"get");
        return "index";
    }
}
