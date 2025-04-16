package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Reviews;
import com.mc.app.service.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/review")
public class ReviewController {

    final ReviewService reviewService;

    @RequestMapping("")
    public String main(Model model,
                       @RequestParam("id") int id,
                       Reviews reviews) throws Exception {

        reviewService.add(reviews);
        return "redirect:/offers/detail?id=" + id;
    }
}
