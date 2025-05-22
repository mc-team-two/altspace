package com.mc.controller.api;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.common.response.ResponseMessage;
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

        // 접근 권한 제어
        User currentUser = (User) httpSession.getAttribute("user");
        if (currentUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }

        // 숙소 정보 디폴트값 설정
        acc.setHostId(currentUser.getUserId());  // 호스트 아이디
        acc.setStatus("활성");                    // 활성 정보

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
            return ResponseEntity
                    .status(ResponseMessage.SUCCESS.getStatus())
                    .body(ResponseMessage.SUCCESS.getMessage());

        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
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
        // 데이터 확인
        log.info(acc.toString());

        // 접근 권한 제어
        User currentUser = (User) httpSession.getAttribute("user");
        if (currentUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }
        // 수정 권한 제어
        if (!currentUser.getUserId().equals(acc.getHostId())) {
            return ResponseEntity
                    .status(ResponseMessage.FORBIDDEN.getStatus())
                    .body(ResponseMessage.FORBIDDEN.getMessage());
        }

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
            return ResponseEntity
                    .status(ResponseMessage.SUCCESS.getStatus())
                    .body(ResponseMessage.SUCCESS.getMessage());

        } catch (Exception e) {
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

    // 삭제
    @PostMapping("/del")
    @ResponseBody
    public ResponseEntity<String> del(@RequestParam("id") Integer id, HttpSession httpSession) {
        // 접근 권한 제어
        User currentUser = (User) httpSession.getAttribute("user");
        if (currentUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }

        // DB 참조 (권한 체크)
        try {
            Accommodations acc = accomService.get(id);
            if (acc == null) {
                return ResponseEntity
                        .status(ResponseMessage.NOTFOUND.getStatus())
                        .body(ResponseMessage.NOTFOUND.getMessage());
            }
            // 삭제 권한 제어
            if (!currentUser.getUserId().equals(acc.getHostId())) {
                return ResponseEntity
                        .status(ResponseMessage.FORBIDDEN.getStatus())
                        .body(ResponseMessage.FORBIDDEN.getMessage());
            }
        } catch (Exception e ) {
            log.error(e.getMessage());
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }

        // 삭제 시도
        try {
            accomService.del(id);
            return ResponseEntity
                    .status(ResponseMessage.SUCCESS.getStatus())
                    .body(ResponseMessage.SUCCESS.getMessage());
        } catch (Exception e) {
            log.info(e.getMessage());
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }


}
