package com.mc.app.repository;

import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AccomRepository extends MCRepository<Accommodations,Integer> {

}
