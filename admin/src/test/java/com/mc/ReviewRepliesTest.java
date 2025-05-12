package com.mc;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.service.ReviewRepliesService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class ReviewRepliesTest {
    @Autowired
    private ReviewRepliesService reviewRepliesService;

    @Test
    void addTest() throws Exception {
        ReviewReplies reply = ReviewReplies
                .builder()
                .reviewId(75)
                .userId("aaebc224")
                .comment("호스트 답글 테스트 입니다.")
                .build();
        reviewRepliesService.add(reply);
    }

    @Test
    void updateTest() throws Exception {
        ReviewReplies reply = ReviewReplies
                .builder()
                .replyId(1)
                .comment("호스트 답글 테스트 updateTest 입니다.")
                .build();
        reviewRepliesService.mod(reply);
    }

    @Test
    void deleteTest() throws Exception {
        reviewRepliesService.del(2);
    }

    @Test
    void selectAllTest() throws Exception {
        List<ReviewReplies> list = reviewRepliesService.get();
        log.info(list.toString());
    }

    @Test
    void selectOneTest() throws Exception {
        ReviewReplies reply = reviewRepliesService.get(5);
        log.info(reply.toString());
    }
}
