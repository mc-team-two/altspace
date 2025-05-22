package com.mc.app.repository;

import com.mc.app.dto.Reviews;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ReviewRepository extends MCRepository<Reviews,Integer> {
    Reviews getMyReviewById(Integer integer);
    List<Reviews> selectReviewsAll(Integer integer);
    List<Reviews> getMyReviews(Reviews reviews);

    // admin 모듈 추가
    List<Reviews> selectByHostIdAndAccId(Map<String, Object> params) throws Exception;
    List<Reviews> selectByHostId(String s) throws Exception;
    // 오늘 작성된 리뷰
    List<Reviews> selectTodayReview(String hostId);
    // 호스트 답글이 없는 리뷰
    List<Reviews> selectNoReplyReview(String hostId);
}
