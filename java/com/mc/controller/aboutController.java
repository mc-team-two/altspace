package com.mc.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/about")
public class aboutController {

    String dir = "about/";

    @RequestMapping("")
    @Operation(summary = "어바웃 페이지", description = "어바웃 페이지로 이동합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "성공", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "400", description = "잘못된 요청", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "500", description = "서버 오류", content = @Content(mediaType = "text/html"))
    })
    public String about(Model model) {
        model.addAttribute("header", dir + "header");
        model.addAttribute("center", dir + "center");
        model.addAttribute("footer", dir + "footer");
        return "index";
    }
}
