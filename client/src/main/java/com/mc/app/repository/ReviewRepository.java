package com.mc.app.repository;

import com.mc.app.dto.Reviews;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ReviewRepository extends MCRepository<Reviews,Integer> {
    Reviews getMyReviewById(Integer integer);
    List<Reviews> selectReviewsAll(Integer integer);
    List<Reviews> getMyReviews(Reviews reviews);
    List<Reviews> getReviewSummary(Integer integer);

}
