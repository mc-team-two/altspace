package com.mc.app.repository;

import com.mc.app.dto.Payments;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PaymentRepository extends MCRepository<Payments,Integer> {
    Payments selectOneTwo(Payments payments) throws Exception;
    // guestId로 모든 결제 내역 조회
    List<Payments> selectPyAll(Payments payments) throws Exception;
    Payments selectPayment(Integer integer) throws Exception;
    List<Payments> selectByHostId(String s) throws Exception;
    List<Payments> selectByAccommodationId(int accommodationId);

    // 이번 달 수익 합계
    Integer selectMonthTotal() throws Exception;

    // 내일 이후의 완료된 예약 건수 조회
    List<Payments> selectUpcomingReservations() throws Exception;

    // 오늘 체크인 예약 건수 조회
    int countTodayCheckIn() throws Exception;

}
