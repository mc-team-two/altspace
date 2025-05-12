package com.mc.app.repository;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.SimpReview;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ReviewRepliesRepository extends MCRepository<ReviewReplies,Integer> {
    List<ReviewReplies> selectByHostId(String hostId);
}
