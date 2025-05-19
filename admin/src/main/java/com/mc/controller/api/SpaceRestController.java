package com.mc.controller.api;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.util.FileUploadUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.lang.reflect.Method;

@RequestMapping("/api/space")
@RestController
@RequiredArgsConstructor
@Slf4j
public class SpaceRestController {

    final AccomService accomService;

    @Value("${app.dir.uploadimgdir}")
    String uploadDir;

    // 추가
    @PostMapping("/add")
    public ResponseEntity<?> add(Accommodations acc,
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

        MultipartFile[] images = {image1, image2, image3, image4, image5};
        String[] imageFieldNames = {"setImage1Name", "setImage2Name", "setImage3Name", "setImage4Name", "setImage5Name"};

        try {
            // 이미지 처리
            for (int i = 0; i < images.length; i++) {
                MultipartFile image = images[i];
                if (image != null && !image.isEmpty()) {
                    FileUploadUtil.saveFile(image, uploadDir);
                    String methodName = imageFieldNames[i];
                    Method method = Accommodations.class.getMethod(methodName, String.class);
                    method.invoke(acc, image.getOriginalFilename());
                }
            }
            // DB 저장
            accomService.add(acc);
            return ResponseEntity.ok().body("정상적으로 등록되었습니다.");

        } catch (Exception e) {
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("스페이스 등록 과정에서 오류가 발생했습니다. " + e.getMessage());
        }
    }

    // 수정
    @RequestMapping("/mod")
    public ResponseEntity<?> mod(Accommodations acc,
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

        MultipartFile[] images = {image1, image2, image3, image4, image5};
        String[] imageFieldNames = {"setImage1Name", "setImage2Name", "setImage3Name", "setImage4Name", "setImage5Name"};

        try {
            // 이미지 처리
            for (int i = 0; i < images.length; i++) {
                MultipartFile image = images[i];
                if (image != null && !image.isEmpty()) {
                    FileUploadUtil.saveFile(image, uploadDir);
                    String methodName = imageFieldNames[i];
                    Method method = Accommodations.class.getMethod(methodName, String.class);
                    method.invoke(acc, image.getOriginalFilename());
                }
            }
            // DB 저장
            accomService.mod(acc);
            return ResponseEntity.ok().body("정상적으로 수정되었습니다.");

        } catch (Exception e) {
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("업데이트 과정에서 오류가 발생했습니다. " + e.getMessage());
        }
    }

    // 삭제
    @PostMapping("/del")
    @ResponseBody
    public ResponseEntity<String> del(@RequestParam("id") Integer id) {
        try {
            accomService.del(id);
            return ResponseEntity.ok("정상적으로 삭제되었습니다.");
        } catch (Exception e) {
            log.info(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 과정에서 오류가 발생했습니다.");
        }
    }


}
