package com.mc.app.repository;

import com.mc.app.dto.PopularLocation;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface GeminiRepository extends MCRepository<PopularLocation, String> {

    // location별 통계 조회 전용
    List<PopularLocation> selectPopularLocations() throws Exception;

}
