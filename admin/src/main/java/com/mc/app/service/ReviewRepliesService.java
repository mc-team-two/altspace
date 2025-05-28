package com.mc.app.service;

import com.mc.app.dto.ReviewReplies;
import com.mc.app.frame.MCService;
import com.mc.app.repository.ReviewRepliesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewRepliesService implements MCService<ReviewReplies, Integer> {

    private final ReviewRepliesRepository reviewRepliesRepository;

    @Override
    public void add(ReviewReplies reviewReplies) throws Exception {
        reviewRepliesRepository.insert(reviewReplies);
    }

    @Override
    public void mod(ReviewReplies reviewReplies) throws Exception {
        reviewRepliesRepository.update(reviewReplies);
    }

    @Override
    public void del(Integer replyId) throws Exception {
        reviewRepliesRepository.delete(replyId);
    }

    @Override
    public ReviewReplies get(Integer replyId) throws Exception {
       return reviewRepliesRepository.selectOne(replyId);
    }

    @Override
    public List<ReviewReplies> get() throws Exception {
        return reviewRepliesRepository.select();
    }

    public List<ReviewReplies> getByHostId(String hostId) throws Exception {
        return reviewRepliesRepository.selectByHostId(hostId);
    }

}