package com.mc.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@Tag(name = "메인 컨트롤러", description = "메인 페이지 API입니다.")
@RequestMapping("")
public class MainController {

    String dir = "home/";

    @RequestMapping("/")
    @Operation(summary = "메인 페이지", description = "메인 페이지를 보여줍니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "성공", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "400", description = "잘못된 요청", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "500", description = "서버 오류", content = @Content(mediaType = "text/html"))
    })
    public String main(Model model){
        model.addAttribute("center", dir + "center");
        return "index";
    }

    @RequestMapping("/elements")
    @Operation(summary = "엘레멘츠 페이지", description = "부트스트랩 탬플릿에서 지원하는 요소들을 보여줍니다. 임시 페이지")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "성공", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "400", description = "잘못된 요청", content = @Content(mediaType = "text/html")),
            @ApiResponse(responseCode = "500", description = "서버 오류", content = @Content(mediaType = "text/html"))
            })
    public String elements(){
        return "elements";
    }
}
