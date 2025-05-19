package com.mc.app.repository;

import com.mc.app.dto.Reservations;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface ReservationRepository extends MCRepository<Reservations,String> {
    List<Reservations> selectCurrentReservations(String hostId);
    List<Reservations> selectUpcomingCheckIns(String hostId);
    List<Reservations> selectUpcomingCheckOuts(String hostId);
    List<Reservations> selectHostingNow(String hostId);
}