package com.mc.app.repository;

import com.mc.app.dto.ReviewImage;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ReviewImageRepository extends MCRepository<ReviewImage,Integer> {
    List<ReviewImage> selectByReviewId(Integer integer);
    List<ReviewImage> selectByHostId(String id) throws Exception;
}
