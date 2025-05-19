package com.mc.controller.api;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.service.AccomService;
import com.mc.app.service.ReviewRepliesService;
import com.mc.app.service.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/review")
@RestController
@RequiredArgsConstructor
@Slf4j
public class ReviewRestController {

    private final ReviewRepliesService reviewRepliesService;

    @PostMapping("/add-reply")
    public ResponseEntity<?> addReply(@RequestBody ReviewReplies reply) {
        try {
            reviewRepliesService.add(reply);
            return ResponseEntity.ok("성공적으로 등록되었습니다");
        } catch (Exception e) {
            return ResponseEntity
                    .internalServerError()
                    .body("오류가 발생했습니다. 관리자에게 문의해주세요." + e.getMessage());
        }
    }

    @PostMapping("/del-reply")
    public ResponseEntity<?> delReply(@RequestParam("replyId") int replyId) {
        try {
            reviewRepliesService.del(replyId);
            return ResponseEntity.ok("성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("오류가 발생했습니다. 관리자에게 문의해주세요.");
        }
    }
}
