package com.mc.app.service;

import com.mc.app.dto.Payments;
import com.mc.app.frame.MCService;
import com.mc.app.repository.PaymentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PaymentService implements MCService<Payments,Integer> {

    final PaymentRepository paymentRepository;

    @Override
    public void add(Payments payments) throws Exception {
        paymentRepository.insert(payments);
    }

    @Override
    public void mod(Payments payments) throws Exception {
        paymentRepository.update(payments);
    }

    @Override
    public void del(Integer integer) throws Exception {
        paymentRepository.delete(integer);
    }

    @Override
    public Payments get(Integer integer) throws Exception {
        return paymentRepository.selectOne(integer);
    }

    @Override
    public List<Payments> get() throws Exception {
        return paymentRepository.select();
    }

    public Payments getOneTwo(Payments payments) throws Exception {
        return paymentRepository.selectOneTwo(payments);
    }

    public List<Payments> selectPyAll(Payments payments) throws Exception {
        return paymentRepository.selectPyAll(payments);
    }

    public Payments selectPayment(Integer integer) throws Exception {
        return paymentRepository.selectPayment(integer);
    }

    public List<Payments> getByHostId(String s) throws Exception {
        return paymentRepository.selectByHostId(s);
    }

    public List<Payments> getByAccommodationId(int accommodationId) throws Exception {
        return paymentRepository.selectByAccommodationId(accommodationId);
    }

    public Integer getMonthTotal() throws Exception {
        return paymentRepository.selectMonthTotal();
    }

    // 내일 이후의 완료된 예약 건수 가져오기
    public List<Payments> getUpcomingReservations() throws Exception {
        return paymentRepository.selectUpcomingReservations();
    }

    // 오늘 체크인 예약 건수 가져오기
    public Integer getTodayCheckInCount() throws Exception {
        return paymentRepository.countTodayCheckIn();
    }

    public List<Payments> getUpcoming7DaysReservations() throws Exception {
        return paymentRepository.selectUpcoming7DaysReservations();
    }

    public List<Map<String, Object>> getLast6MonthsEarnings() {
        return paymentRepository.selectLast6MonthsEarnings();
    }

    public Payments getPopularSpaceThisMonth() throws Exception {
        return paymentRepository.selectPopularSpaceThisMonth();
    }
}
