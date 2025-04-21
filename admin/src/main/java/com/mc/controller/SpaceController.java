package com.mc.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.repository.AccomRepository;
import com.mc.app.service.AccomService;
import com.mc.util.FileUploadUtil;
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
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@RequestMapping("/space")
@Controller
@RequiredArgsConstructor
@Slf4j
public class SpaceController {

    final AccomService accomService;

    @Value("${app.dir.uploadimgdir}")
    String uploadDir;

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

/*
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

*/
    @RequestMapping("/get")
    public String get(@RequestParam(value="pageNo", defaultValue = "1") int pageNo,
            Model model, HttpSession httpSession){

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

    @RequestMapping("/detail")
    public String detail(@RequestParam("id") Integer id,
                         Model model){
        try {
            Accommodations data = accomService.get(id);
            log.info(data.toString());
            model.addAttribute("data", data);
        } catch (Exception e) {
            log.info(e.getMessage());
        }

        model.addAttribute("kakaoJSApiKey", kakaoJSApiKey);
        model.addAttribute("center", dir+"detail");

        return "index";
    }

    @RequestMapping("/updatespace")
    public String updatespace(Accommodations acc,
                              @RequestParam("image1") MultipartFile image1,
                              @RequestParam("image2") MultipartFile image2,
                              @RequestParam("image3") MultipartFile image3,
                              @RequestParam("image4") MultipartFile image4,
                              @RequestParam("image5") MultipartFile image5) {

        try {
            // ✅ 이미지 파일이 있는 경우만 저장
            if (image1 != null && !image1.isEmpty()) {
                FileUploadUtil.saveFile(image1, uploadDir); // 실제 파일 저장
                acc.setImage1Name(image1.getOriginalFilename()); // DB에 파일명 저장
            }

            if (image2 != null && !image2.isEmpty()) {
                FileUploadUtil.saveFile(image2, uploadDir); // 실제 파일 저장
                acc.setImage1Name(image2.getOriginalFilename()); // DB에 파일명 저장
            }

            if (image3 != null && !image3.isEmpty()) {
                FileUploadUtil.saveFile(image3, uploadDir); // 실제 파일 저장
                acc.setImage1Name(image3.getOriginalFilename()); // DB에 파일명 저장
            }

            if (image4 != null && !image4.isEmpty()) {
                FileUploadUtil.saveFile(image4, uploadDir);
                acc.setImage1Name(image4.getOriginalFilename());
            }

            if (image5 != null && !image5.isEmpty()) {
                FileUploadUtil.saveFile(image5, uploadDir); // 실제 파일 저장
                acc.setImage1Name(image5.getOriginalFilename()); // DB에 파일명 저장
            }


            // ✅ 숙소 정보 수정 처리
            accomService.mod(acc);

            return "redirect:/space/get";

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("업데이트 중 오류 발생", e);
        }
    }
}
