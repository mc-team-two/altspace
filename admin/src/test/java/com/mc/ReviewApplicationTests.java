package com.mc;

import com.mc.app.dto.SimpReview;
import com.mc.app.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@SpringBootTest
@Slf4j
public class ReviewApplicationTests {

    @Autowired
    private ReviewService reviewService;

    @Test
    void getByHostId() {
        try {
            List<SimpReview> list = reviewService.getByHostId("cb55f65d");
            System.out.println(list);
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    @Test
    void contextLoads2() {
        try {
            // 파라미터 맵 생성
            Map<String, Object> params = new HashMap<>();
            params.put("hostId", "cb55f65d");
            params.put("accId", 1); // map으로 쓰기 때문에 키 값이 정확히 일치해야함

            List<SimpReview> list = reviewService.getByHostIdAndAccId(params);
            System.out.println(list);
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
