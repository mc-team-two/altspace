package com.mc.app.repository;

import com.mc.app.dto.Payments;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PaymentRePository extends MCRepository<Payments,Integer> {
    Payments selectOneTwo(Payments payments) throws Exception;
    // 추가: guestId로 모든 결제 내역 조회
    List<Payments> selectPyAll(Payments payments) throws Exception;
    Payments selectPayment(Integer integer) throws Exception;
}
