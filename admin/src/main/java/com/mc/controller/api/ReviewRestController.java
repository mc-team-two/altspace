package com.mc.controller.api;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.dto.User;
import com.mc.app.service.ReviewRepliesService;
import com.mc.common.response.ResponseMessage;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/review")
@RestController
@RequiredArgsConstructor
@Slf4j
public class ReviewRestController {

    private final ReviewRepliesService reviewRepliesService;

    @PostMapping("/add-reply")
    public ResponseEntity<?> addReply(@RequestBody ReviewReplies reply, HttpSession httpSession) {
        // 권한 제어
        String hostId = reply.getUserId();
        User curUser = (User) httpSession.getAttribute("user");
        if (curUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }
        if (!curUser.getUserId().equals(hostId)) {
            return ResponseEntity
                    .status(ResponseMessage.FORBIDDEN.getStatus())
                    .body(ResponseMessage.FORBIDDEN.getMessage());
        }

        try {
            reviewRepliesService.add(reply);
            return ResponseEntity
                    .status(ResponseMessage.SUCCESS.getStatus())
                    .body(ResponseMessage.SUCCESS.getMessage());
        } catch (Exception e) {
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

    @PostMapping("/del-reply")
    public ResponseEntity<?> delReply(@RequestParam("replyId") int replyId, HttpSession httpSession) {
        // 권한 제어
        User curUser = (User) httpSession.getAttribute("user");
        if (curUser == null) {
            return ResponseEntity
                    .status(ResponseMessage.UNAUTHORIZED.getStatus())
                    .body(ResponseMessage.UNAUTHORIZED.getMessage());
        }

        // DB 참조
        ReviewReplies dbReply;
        try {
            dbReply = reviewRepliesService.get(replyId);
            if (dbReply == null) {
                return ResponseEntity
                        .status(ResponseMessage.NOTFOUND.getStatus())
                        .body(ResponseMessage.NOTFOUND.getMessage());
            }
        } catch (Exception e) {
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
        
        // 권한 제어
        if (!curUser.getUserId().equals(dbReply.getUserId())) {
            return ResponseEntity
                    .status(ResponseMessage.FORBIDDEN.getStatus())
                    .body(ResponseMessage.FORBIDDEN.getMessage());
        }

        // 삭제 시도
        try {
            reviewRepliesService.del(replyId);
            return ResponseEntity
                    .status(ResponseMessage.SUCCESS.getStatus())
                    .body(ResponseMessage.SUCCESS.getMessage());
        } catch (Exception e) {
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }
}
