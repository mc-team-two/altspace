package com.mc.app.service;

import com.mc.app.dto.Guide;
import com.mc.app.repository.GuideRepository;
import com.mc.app.frame.MCService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GuideService implements MCService<Guide, Integer> {

    private final GuideRepository guideRepository;

    @Override
    public void add(Guide guide) throws Exception {
        // 가이드 추가 로직
    }

    @Override
    public void mod(Guide guide) throws Exception {
        // 가이드 수정 로직
    }

    @Override
    public void del(Integer guideNumber) throws Exception {
        // 가이드 삭제 로직
    }

    @Override
    public Guide get(Integer guideNumber) throws Exception {
        return guideRepository.selectOne(guideNumber);
    }

    @Override
    public List<Guide> get() throws Exception {
        return guideRepository.select();
    }

}