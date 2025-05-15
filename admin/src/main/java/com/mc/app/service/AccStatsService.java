package com.mc.app.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.mc.app.dto.AccStats;
import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCService;
import com.mc.app.repository.AccStatsRepository;
import com.mc.app.repository.AccomRepository;
import com.mc.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AccStatsService implements MCService<AccStats,String> {

    final AccStatsRepository accStatsRepository;

    public List<AccStats> getTopViews(String hostId) {
        return accStatsRepository.selectTopViews(hostId);
    }

    public List<AccStats> getTopReviews(String hostId) {
        return accStatsRepository.selectTopReviews(hostId);
    }

    public List<AccStats> getTopWishlists(String hostId) {
        return accStatsRepository.selectTopWishlists(hostId);
    }

    public List<AccStats> getTopBookingsThisMonth(String hostId) {
        return accStatsRepository.getTopBookingsThisMonth(hostId);
    }

    public List<AccStats> getTopSalesAllTime(String hostId) {
        return accStatsRepository.selectTopSalesAllTime(hostId);
    }

    public List<AccStats> getTopSalesThisMonth(String hostId) {
        return accStatsRepository.selectTopSalesThisMonth(hostId);
    }


    @Override
    public void add(AccStats accStats) throws Exception {
    }

    @Override
    public void mod(AccStats accStats) throws Exception {
    }

    @Override
    public void del(String s) throws Exception {
    }

    @Override
    public AccStats get(String s) throws Exception {
        return null;
    }

    @Override
    public List<AccStats> get() throws Exception {
        return List.of();
    }
}
