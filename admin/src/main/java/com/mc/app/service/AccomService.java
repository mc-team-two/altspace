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
    public void mod(Accommodations acc) throws Exception {
        accomRepository.updateAccommodation(acc);
    }

    @Override
    public void del(Integer accId) throws Exception {
        accomRepository.delete(accId);
    }

    @Override
    public Accommodations get(Integer integer) throws Exception {
        return accomRepository.selectOne(integer);
    }

    @Override
    public List<Accommodations> get() throws Exception {
        return accomRepository.select();
    }

    public List<Accommodations> getByHostId(String s) throws Exception {
        return accomRepository.selectByHostId(s);
    }
}
