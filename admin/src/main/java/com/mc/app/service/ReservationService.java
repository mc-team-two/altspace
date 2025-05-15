package com.mc.app.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.mc.app.dto.Accommodations;
import com.mc.app.dto.Reservations;
import com.mc.app.frame.MCService;
import com.mc.app.repository.AccomRepository;
import com.mc.app.repository.ReservationRepository;
import com.mc.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservationService implements MCService<Reservations,String> {

    private final ReservationRepository reservationRepository;

    @Override
    public void add(Reservations reservations) throws Exception {
    }

    @Override
    public void mod(Reservations reservations) throws Exception {
    }

    @Override
    public void del(String s) throws Exception {
    }

    @Override
    public Reservations get(String s) throws Exception {
        return null;
    }

    @Override
    public List<Reservations> get() throws Exception {
        return List.of();
    }

    /**
     *  결제 상태가 '완료'이고 호스팅 완료되지 않은 모든 예약
     */
    public List<Reservations> getCurrentReservations(String hostId) {
        return reservationRepository.selectCurrentReservations(hostId);
    }

    /**
     *  결제 상태가 '완료'이고 오늘/내일 중으로 체크인 예정된 예약
     */
    public List<Reservations> getUpcomingCheckIns(String hostId) {
        return reservationRepository.selectUpcomingCheckIns(hostId);
    }

    /**
     *  결제 상태가 '완료'이고 오늘/내일 중으로 체크아웃 예정된 예약
     */
    public List<Reservations> getUpcomingCheckOuts(String hostId) {
        return reservationRepository.selectUpcomingCheckOuts(hostId);
    }

    /**
     *  현재 호스팅 중인 예약
     */
    public List<Reservations> getHostingNow(String hostId) {
        return reservationRepository.selectHostingNow(hostId);
    }
}
