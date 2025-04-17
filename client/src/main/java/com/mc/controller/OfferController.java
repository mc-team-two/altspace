package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Reviews;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/offers")
public class OfferController {

    final AccomService accomService;
    final ReviewService reviewService;

    @RequestMapping("")
    public String main(Model model) throws Exception {

        List<Accommodations> accomm = null;
        accomm = accomService.get();
        model.addAttribute("accomm", accomm);

        return "offers";
    }

    @RequestMapping("/detail")
    public String detail(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);
        List<Reviews> review = reviewService.selectReviewsAll(id);

        model.addAttribute("accomm", accomm);
        model.addAttribute("review", review);
        return "detail";
    }

    @RequestMapping("/review")
    public String review(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);
        log.info("accomm: " + accomm);

        model.addAttribute("accomm", accomm);
        return "review";
    }
}