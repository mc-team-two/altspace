package com.mc.app.repository;

import com.github.pagehelper.Page;
import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
@Mapper
public interface AccomRepository extends MCRepository<Accommodations,Integer> {
    Page<Accommodations> selectPageByHostId(String hostId);
    void insertAccommodation(Accommodations acc);
    List<Accommodations> selectByHostId(String hostId);
    void updateAccommodation(Accommodations accommodation);  // update 메서드 추가
    List<Accommodations> findByUserId(String userId);

    // 호스트 ID에 해당하는 숙소 개수
    int countByHostId(String hostId);
}