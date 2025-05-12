package com.mc.app.service;

import com.mc.app.dto.ReviewImage;
import com.mc.app.dto.ReviewReplies;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.SimpReview;
import com.mc.app.frame.MCService;
import com.mc.app.repository.ReviewImageRepository;
import com.mc.app.repository.ReviewRepliesRepository;
import com.mc.app.repository.ReviewRepository;
import com.mc.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

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

}