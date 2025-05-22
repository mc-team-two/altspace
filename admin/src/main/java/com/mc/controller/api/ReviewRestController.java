package com.mc.controller.api;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.User;
import com.mc.app.service.ReviewImageService;
import com.mc.app.service.ReviewRepliesService;
import com.mc.app.service.ReviewService;
import com.mc.common.response.ResponseMessage;
import com.mc.util.PapagoUtil;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/api/review")
@RestController
@RequiredArgsConstructor
@Slf4j
public class ReviewRestController {

    private final ReviewService reviewService;
    private final ReviewRepliesService reviewRepliesService;

    @Value("${ncp.papago.id}")
    String papagoId;
    @Value("${ncp.papago.key}")
    String papagoKey;

    @PostMapping("/dashboard")
    public ResponseEntity<?> dashboard(@RequestParam("hostId") String hostId,
                                       HttpSession httpSession) throws Exception {
        // 접근 제한 코드
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
        
        // 데이터
        Map<String, Object> response = new LinkedHashMap<>();

        try {
            // 누적 리뷰수
            List<Reviews> totalReviewsDataList =  reviewService.getByHostId(hostId);

            Map<String, Object> totalReviewsData = new LinkedHashMap<>();
            totalReviewsData.put("count", totalReviewsDataList.size());
            totalReviewsData.put("list", totalReviewsDataList);
            response.put("totalReviews", totalReviewsData);

            // 누적 평점
            double averageGrade = 0.0;
            int count = totalReviewsDataList.size();
            if (count > 0) {
                int totalGrade = totalReviewsDataList.stream()
                        .mapToInt(Reviews::getGrade)
                        .sum();
                averageGrade = (double) totalGrade / count;
            }
            double roundedGrade = Math.round(averageGrade * 10.0) / 10.0;
            response.put("averageGrade", roundedGrade);

            // 오늘 등록된 리뷰
            List<Reviews> todayReviewsList = reviewService.selectTodayReview(hostId);

            Map<String, Object> todayReviewsData = new LinkedHashMap<>();
            int todayReviewsCount = todayReviewsList.size();
            todayReviewsData.put("count", todayReviewsCount);
            todayReviewsData.put("list", todayReviewsList);
            response.put("todayReviews", todayReviewsData);

            // 답글을 쓸 수 있는 리뷰
            List<Reviews> noReplyReviewsList = reviewService.selectNoReplyReview(hostId);

            Map<String, Object> noReplyReviewsData = new LinkedHashMap<>();
            int noReplyReviewsCount = noReplyReviewsList.size();
            noReplyReviewsData.put("count", noReplyReviewsCount);
            noReplyReviewsData.put("list", noReplyReviewsList);
            response.put("noReplyReviews", noReplyReviewsData);

            return ResponseEntity.ok(response);

        } catch (Exception e)  {
            // 에러 처리
            return ResponseEntity
                    .status(ResponseMessage.ERROR.getStatus())
                    .body(ResponseMessage.ERROR.getMessage());
        }
    }

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

    ///  리뷰 번역
    @PostMapping("/translate")
    public ResponseEntity<String> translate(@RequestBody Map<String, String> body) {
        String msg = body.get("msg");
        String target = body.get("target");

        String translatedText = PapagoUtil.getMsg(papagoId, papagoKey, msg, target);
        return ResponseEntity.ok(translatedText);
    }
}
