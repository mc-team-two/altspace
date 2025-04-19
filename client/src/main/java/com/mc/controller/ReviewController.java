package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Reviews;
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
@RequestMapping("/review")
public class ReviewController {

    final AccomService accomService;
    final ReviewService reviewService;
    String dir ="review/";

    @RequestMapping("")
    public String review(Model model) {
        model.addAttribute("headers", dir + "headers");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "index";
    }

    @RequestMapping("/rvdtSel")
    public String review(Model model, @RequestParam("id") int id) throws Exception {

        Accommodations accomm = accomService.get(id);

        model.addAttribute("accomm", accomm);
        return "review";
    }

    @RequestMapping("/dtadd")
    public String dtadd(Model model,
                       @RequestParam("id") int id,
                       Reviews reviews) throws Exception {

        reviewService.add(reviews);
        return "redirect:/detail?id=" + id;
    }

    @RequestMapping("/upimpl")
    public String upimpl(Model model,
                         @RequestParam("id") int id) throws Exception {

        Reviews review = reviewService.selectReviewAccom(id);
        log.info("review: " + review);

        model.addAttribute("review", review);
        return "reviewImpl";
    }

    @RequestMapping("/update")
    public String update(Model model,
                         @RequestParam("id") int id,
                         Reviews reviews) throws Exception {

        reviewService.mod(reviews);
        return "redirect:/detail?id=" + id;
    }

    @RequestMapping("/delete")
    public String delete(Model model,
                         @RequestParam("rvId") int rvid,
                         @RequestParam("acId") int acid) throws Exception {

        reviewService.del(rvid);
        return "redirect:/detail?id=" + acid;
    }
}
