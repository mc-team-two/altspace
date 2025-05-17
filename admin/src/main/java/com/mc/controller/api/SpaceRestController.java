package com.mc.controller.api;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import com.mc.util.FileUploadUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RequestMapping("/api/space")
@RestController
@RequiredArgsConstructor
@Slf4j
public class SpaceRestController {

    final AccomService accomService;
    final PaymentService paymentService;

    @Value("${app.dir.uploadimgdir}")
    String uploadDir;

    // 추가
    @PostMapping("/addimpl")
    public String addimpl(Accommodations acc,
                          @RequestParam("image1") MultipartFile image1,
                          @RequestParam("image2") MultipartFile image2,
                          @RequestParam("image3") MultipartFile image3,
                          @RequestParam("image4") MultipartFile image4,
                          @RequestParam("image5") MultipartFile image5,
                          HttpSession httpSession) {

        // 현재 유저 정보
        User currentUser = (User) httpSession.getAttribute("user");
        acc.setHostId(currentUser.getUserId());

        // 활성 정보
        acc.setStatus("활성");

        // 이미지 처리
        try {
            if (image1 != null && !image1.isEmpty()) {
                FileUploadUtil.saveFile(image1, uploadDir);
                acc.setImage1Name(image1.getOriginalFilename());
            }
            if (image2 != null && !image2.isEmpty()) {
                FileUploadUtil.saveFile(image2, uploadDir);
                acc.setImage2Name(image2.getOriginalFilename());
            }
            if (image3 != null && !image3.isEmpty()) {
                FileUploadUtil.saveFile(image3, uploadDir);
                acc.setImage3Name(image3.getOriginalFilename());
            }
            if (image4 != null && !image4.isEmpty()) {
                FileUploadUtil.saveFile(image4, uploadDir);
                acc.setImage4Name(image4.getOriginalFilename());
            }
            if (image5 != null && !image5.isEmpty()) {
                FileUploadUtil.saveFile(image5, uploadDir);
                acc.setImage5Name(image5.getOriginalFilename());
            }

            log.info(acc.toString());

            // DB 저장
            accomService.add(acc);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("등록 중 오류 발생", e);
        }

        // 처리 후 리다이렉트
        return "redirect:/space/list";
    }
    // 삭제
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
    // 수정
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

            return "redirect:/space/list";

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("업데이트 중 오류 발생", e);
        }
    }
}
