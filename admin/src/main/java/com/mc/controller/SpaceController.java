package com.mc.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Payments;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import com.mc.app.service.ReservationService;
import com.mc.util.FileUploadUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@RequestMapping("/space")
@Controller
@RequiredArgsConstructor
@Slf4j
public class SpaceController {

    final AccomService accomService;
    final PaymentService paymentService;
    private final ReservationService reservationService;

    @Value("${app.key.kakaoJSApiKey}")
    String kakaoJSApiKey;

    String dir = "space/";

    @RequestMapping("/add")
    public String add(Model model, HttpSession httpSession){
        // 권한 제어
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("kakaoJSApiKey", kakaoJSApiKey);
        model.addAttribute("center", dir+"add");
        return "index";
    }

    @RequestMapping("/list")
    public String get(@RequestParam(value="pageNo", defaultValue = "1") int pageNo,
            Model model, HttpSession httpSession){
        // 권한 제어
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        User user = (User) httpSession.getAttribute("user");
        Page<Accommodations> page = null;
        PageInfo<Accommodations> pageInfo = null;

        try {
            page = accomService.getPageByHostId(user.getUserId(), pageNo);
            pageInfo = new PageInfo<>(page, 5); // 하단 네비게이션 개수: 5
        } catch (Exception e) {
            log.info(e.getMessage());
        }
        model.addAttribute("cpage", pageInfo);
        model.addAttribute("target", "/space");
        model.addAttribute("center", dir+"list");
        return "index";
    }


    @RequestMapping("/mod")
    public String mod(@RequestParam("id") Integer id,
                         Model model, HttpSession httpSession){
        // 권한 제어
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        try {
            Accommodations data = accomService.get(id);
            log.info(data.toString());
            model.addAttribute("data", data);
        } catch (Exception e) {
            log.info(e.getMessage());
        }

        model.addAttribute("kakaoJSApiKey", kakaoJSApiKey);
        model.addAttribute("center", dir+"mod");

        return "index";
    }

    @RequestMapping("/booking")
    public String booking(Model model, HttpSession httpSession) {
        // 권한 제어
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        model.addAttribute("center", dir + "booking");
        model.addAttribute("index", dir + "index");
        return "index";
    }
}
