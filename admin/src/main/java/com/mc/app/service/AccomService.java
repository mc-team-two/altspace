package com.mc.app.service;

import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCService;
import com.mc.app.repository.AccomRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AccomService implements MCService<Accommodations,Integer> {

    final AccomRepository accomRepository;

    @Override
    public void add(Accommodations acc) throws Exception {
        accomRepository.insertAccommodation(acc);
    }

    @Override
    public void mod(Accommodations accommodations) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public Accommodations get(Integer integer) throws Exception {
        return accomRepository.selectOne(integer);
    }

    @Override
    public List<Accommodations> get() throws Exception {
        return accomRepository.select();
    }
}
