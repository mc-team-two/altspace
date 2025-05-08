package com.mc.app.service;

import com.mc.app.dto.ReviewImage;
import com.mc.app.frame.MCService;
import com.mc.app.repository.ReviewImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewImageService implements MCService<ReviewImage, Integer> {

    private final ReviewImageRepository reviewImageRepository;

    @Override
    public void add(ReviewImage reviewImage) throws Exception {
        reviewImageRepository.insert(reviewImage);
    }

    @Override
    public void mod(ReviewImage reviewImage) throws Exception {

    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public ReviewImage get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public List<ReviewImage> get() throws Exception {
        return List.of();
    }
}
