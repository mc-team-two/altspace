package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.service.AccomService;
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
@RequestMapping("/offers")
public class offerController {

    final AccomService accomService;

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
        log.info("accomm: " + accomm);

        model.addAttribute("accomm", accomm);
        return "detail";
    }
}