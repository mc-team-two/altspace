package com.mc.util;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.dto.Reviews;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ReviewUtil {

    public static Map<Reviews, List<ReviewReplies>> mapReviewsWithReplies(
            List<Reviews> reviewList,
            List<ReviewReplies> replyList) {

        // 결과를 담을 Map 생성
        Map<Reviews, List<ReviewReplies>> reviewMap = new LinkedHashMap<>();

        // 1. reviewList를 기반으로 빈 List를 초기화
        for (Reviews review : reviewList) {
            reviewMap.put(review, new ArrayList<>());
        }

        // 2. replyList를 순회하며 매핑
        for (ReviewReplies reply : replyList) {
            for (Reviews review : reviewList) {
                if (review.getReviewId() == reply.getReviewId()) {
                    reviewMap.get(review).add(reply);
                    break;  // 해당 리뷰에 매핑했으면 더 이상 순회할 필요 없음
                }
            }
        }

        return reviewMap;
    }
}
