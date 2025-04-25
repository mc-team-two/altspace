package com.mc.app.service;

import com.mc.app.dto.Reviews;
import com.mc.app.frame.MCService;
import com.mc.app.repository.ReviewRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewService implements MCService<Reviews, Integer> {

    private final ReviewRepository reviewRepository;

    @Override
    public void add(Reviews reviews) throws Exception {
        reviewRepository.insert(reviews);
    }

    @Override
    public void mod(Reviews reviews) throws Exception {
        reviewRepository.update(reviews);
    }

    @Override
    public void del(Integer integer) throws Exception {
        reviewRepository.delete(integer);
    }

    @Override
    public Reviews get(Integer integer) throws Exception {
        return reviewRepository.selectOne(integer);
    }

    @Override
    public List<Reviews> get() throws Exception {
        return reviewRepository.select();
    }

    public List<Reviews> selectReviewsAll(Integer integer) throws Exception {
        return reviewRepository.selectReviewsAll(integer);
    }

    public List<Reviews> getMyReviews(Reviews reviews) throws Exception {
        return reviewRepository.getMyReviews(reviews);
    }

    public Reviews getMyReviewById(Integer integer) throws Exception {
        return reviewRepository.getMyReviewById(integer);
    }

    public int getAverageRating(long accommodationId) {
        List<Reviews> reviews = reviewRepository.selectReviewsAll((int) accommodationId);
        if (reviews.isEmpty()) {
            return 0;
        }

        int sum = 0;
        for (Reviews review : reviews) {
            sum += review.getGrade();
        }
        return sum / reviews.size();
    }

}