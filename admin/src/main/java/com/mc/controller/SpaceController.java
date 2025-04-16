package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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
    public String get(Model model, HttpSession httpSession){
        User user = (User) httpSession.getAttribute("user");
        List<Accommodations> data = null;
        try {
            data = accomService.getByHostId(user.getUserId());
            // log.info(data.toString());
        } catch (Exception e) {
            log.info(e.getMessage());
        }
        model.addAttribute("data", data);
        model.addAttribute("center", dir+"get");
        return "index";
    }

    @PostMapping("/del")
    @ResponseBody
    public ResponseEntity<String> del(@RequestParam("id") Integer id) {
        try {
            accomService.del(id);
            return ResponseEntity.ok("삭제 성공!");
        } catch (Exception e) {
            log.info(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패!");
        }
    }

}
