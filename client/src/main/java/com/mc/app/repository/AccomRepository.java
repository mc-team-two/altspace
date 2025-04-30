package com.mc.app.repository;

import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface AccomRepository extends MCRepository<Accommodations,Integer> {

    List<Accommodations> searchAccommodationsByLocation(String location);
    List<Accommodations> searchAccommodationsByGeoLocation(Map<String, Object> params);
    // 위치 기반 검색 메서드 (MyBatis Mapper XML에 구현)
    // 변경: extras를 List<String> 타입으로 직접 받도록 수정
    List<Accommodations> searchAccommodationsByLocation(String location, List<String> extras);
}