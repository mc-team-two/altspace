package com.mc.app.repository;

import com.mc.app.dto.Payments;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

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

    // 오늘/내일 체크인 건수 조회
    int countTodayCheckIn() throws Exception;
    int countTomorrowCheckIn() throws Exception;

    // 오늘/내일 체크아웃 건수 조회
    int countTodayCheckOut() throws Exception;
    int countTomorrowCheckOut() throws Exception;

    int countTotalReservations() throws Exception;

    // 오늘부터 7일 이내의 다가오는 예약 목록
    List<Payments> selectUpcoming7DaysReservations() throws Exception;

    // 이번 달 인기 스페이스 (예약 완료 수 기준 최다)
    Payments selectPopularSpaceThisMonth() throws Exception;

    // 최근 6개월간의 수익 조회
    List<Map<String, Object>> selectLast6MonthsEarnings();
}
