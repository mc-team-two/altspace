package com.mc.app.repository;

import com.mc.app.dto.AccStats;
import com.mc.app.frame.MCRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface AccStatsRepository extends MCRepository<AccStats,String> {
    List<AccStats> selectTopViews(String hostId);
    List<AccStats> selectTopReviews(String hostId);
    List<AccStats> selectTopWishlists(String hostId);
    List<AccStats> getTopBookingsThisMonth(String hostId);
    List<AccStats> selectTopSalesAllTime(String hostId);
    List<AccStats> selectTopSalesThisMonth(String hostId);
}

