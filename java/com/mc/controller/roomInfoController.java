package com.mc.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/roominfo")
public class roomInfoController {

    String dir ="roomInfo/";

    @RequestMapping("")
    @Operation(summary = "룸인포 페이지", description = "룸인포 페이지로 이동합니다. DB데이터 뿌려야 합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "성공", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "400", description = "잘못된 요청", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "500", description = "서버 오류", content = @Content(mediaType = "text/html"))
    })
    public String roomInfo(Model model) {
        model.addAttribute("center", dir + "center");
        return "index";
    }
}
