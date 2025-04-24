package com.mc.app.repository;

import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface AccomRepository extends MCRepository<Accommodations,Integer> {

    List<Accommodations> selectAllAccommodations();
}
