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
    ///  호스트가 등록한 모든 숙소 조회 (페이지로 가져오기)
    Page<Accommodations> selectPageByHostId(String hostId) throws Exception;
    
    ///  호스트가 등록한 모든 숙소 조회 (리스트로 가져오기)
    List<Accommodations> selectListByHostId(String hostId) throws Exception;  // update 메서드 추가

    /// 호스트 ID에 해당하는 숙소 개수
    int countByHostId(String hostId) throws Exception;
}