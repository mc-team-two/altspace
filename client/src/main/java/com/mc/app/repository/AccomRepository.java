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

    List<Accommodations> selectAllAccommodations();

    List<Accommodations> searchAccommodations(Map<String, Object> searchMap);

    // 키워드(이름, 위치, 설명) 기반 검색 메서드
    List<Accommodations> searchAccommodationsByKeyword(String keyword);

    // 위치 기반 검색 메서드 (MyBatis Mapper XML에 구현)
    List<Accommodations> searchAccommodationsByLocation(String location);

    List<Accommodations> searchAccommodationsByGeoLocation(Map<String, Object> params);
}