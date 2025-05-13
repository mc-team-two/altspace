package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/reviewAdd")
public class ReviewAddController {

    final AccomService accomService;
    String dir ="reviewadd/";

    /* 리뷰 작성 페이지 이동 */
    @RequestMapping("")
    public String dtadd(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);

        model.addAttribute("accomm", accomm);
        model.addAttribute("center", dir + "center");
        return "index";
    }
}
