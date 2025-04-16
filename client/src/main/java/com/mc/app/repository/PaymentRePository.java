package com.mc.app.repository;

import com.mc.app.dto.Payments;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface PaymentRePository extends MCRepository<Payments,Integer> {
    Payments selectOneTwo(Payments payments) throws Exception;
}
