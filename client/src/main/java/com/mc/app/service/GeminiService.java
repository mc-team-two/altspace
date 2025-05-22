package com.mc.app.service;

import com.mc.app.dto.PopularLocation;
import com.mc.app.repository.GeminiRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GeminiService {
    private final GeminiRepository geminiRepository;

    public List<PopularLocation> getPopularStats() throws Exception {
        return geminiRepository.selectPopularLocations();
    }
}