package com.mc.app.service;

import com.mc.app.dto.ReviewImage;
import com.mc.app.dto.Reviews;
import com.mc.app.dto.SimpReview;
import com.mc.app.frame.MCService;
import com.mc.app.repository.ReviewImageRepository;
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
public class ReviewService implements MCService<Reviews, Integer> {

    private final ReviewRepository reviewRepository;
    private final ReviewImageRepository reviewImageRepository;

    @Value("${app.dir.uploadimgdir}")
    String uploadDir;

    @Override
    public void add(Reviews reviews) throws Exception {
        reviewRepository.insert(reviews); // insert 후 reviewId 자동 세팅되도록 할 것 (Mapper 에서 반환)

        int reviewId = reviews.getReviewId();  // 이미지 저장을 위해 DTO 에서 리뷰 아이디 가져옴

        // 2. 이미지 저장
        if (reviews.getImages() != null) {
            for (MultipartFile mf : reviews.getImages()) {
                if (mf != null && !mf.isEmpty()) {
                    String originalFilename = mf.getOriginalFilename(); // ex: 리뷰업로드(1).jpg

                    // UUID로 고유한 파일명 생성
                    String uuid = UUID.randomUUID().toString();
                    String savedFilename = uuid + "_" + originalFilename; // ex: 123e4567_리뷰업로드(1).jpg

                    // UUID 포함된 이름으로 저장만 수행(UUID 붙인 이름을 업로드 유틸에 보냄)
                    FileUploadUtil.saveFile(mf, uploadDir, savedFilename);

                    // DB에는 고유 파일명을 저장
                    ReviewImage img = ReviewImage.builder()
                            .reviewId(reviewId)
                            .imageUrl(savedFilename)  // UUID가 붙은 고유 파일명
                            .build();
                    reviewImageRepository.insert(img);
                }
            }
        }
    }

    @Override
    public void mod(Reviews reviews) throws Exception {
        // 1. 리뷰 정보 업데이트
        reviewRepository.update(reviews);

        // 2. 기존 이미지 로컬 파일 삭제 + DB 삭제
        List<ReviewImage> existingImages = reviewImageRepository.selectByReviewId(reviews.getReviewId());
        if (existingImages != null) {
            for (ReviewImage image : existingImages) {
                // image.getImageUrl() 예: /upload/reviews/abc123_file.jpg
                String imageUrl = image.getImageUrl();
                String filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);  // 파일명만 추출

                try {
                    FileUploadUtil.deleteFile(filename, uploadDir);
                } catch (IOException e) {
                    // 로그 남기고 계속 진행
                    e.printStackTrace();
                }
            }
        }
        reviewImageRepository.delete(reviews.getReviewId());

        // 3. 새 이미지 업로드 및 DB 저장
        List<MultipartFile> images = reviews.getImages();
        if (images != null && !images.isEmpty()) {
            for (MultipartFile mf : images) {
                if (!mf.isEmpty()) {
                    String originalFilename = mf.getOriginalFilename();
                    String uuid = UUID.randomUUID().toString();
                    String savedFilename = uuid + "_" + originalFilename;

                    // 파일 저장
                    FileUploadUtil.saveFile(mf, uploadDir, savedFilename);

                    // DB 저장
                    ReviewImage img = ReviewImage.builder()
                            .reviewId(reviews.getReviewId())
                            .imageUrl(savedFilename)     // URL 경로
                            .build();
                    reviewImageRepository.insert(img);
                }
            }
        }
    }

    @Override
    public void del(Integer integer) throws Exception {
        // 1. 이미지 리스트 조회
        List<ReviewImage> imageList = reviewImageRepository.selectByReviewId(integer);

        // 2. 로컬 파일 삭제
        for (ReviewImage img : imageList) {
            String filename = img.getImageUrl();  // ex: UUID_원본.jpg
            try {
                FileUploadUtil.deleteFile(filename, uploadDir);  // 로컬 삭제
            } catch (IOException e) {
                e.printStackTrace();  // 삭제 실패 로그
            }
        }

        // 3. 이미지 레코드 삭제
        reviewImageRepository.delete(integer);

        // 4. 리뷰 삭제
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

    private void setImageUrls(List<Reviews> reviews) {
        for (Reviews r : reviews) {
            List<ReviewImage> images = reviewImageRepository.selectByReviewId(r.getReviewId());
            List<String> urls = images.stream()
                    .map(ReviewImage::getImageUrl)
                    .collect(Collectors.toList());
            r.setImageUrl(urls);
        }
    }

    public List<Reviews> selectReviewsAll(Integer integer) throws Exception {
        List<Reviews> reviewList = reviewRepository.selectReviewsAll(integer);
        setImageUrls(reviewList);
        return reviewList;

    }

    public List<Reviews> getMyReviews(Reviews reviews) throws Exception {
        List<Reviews> reviewList = reviewRepository.getMyReviews(reviews);
        setImageUrls(reviewList);
        return reviewList;
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

    // admin 모듈 추가
    // 호스트의 특정 숙소에 대한 리뷰
    public List<SimpReview> getByHostIdAndAccId(Map<String, Object> params) throws Exception{
        return reviewRepository.selectByHostIdAndAccId(params);
    }

    // 호스트의 모든 숙소에 대한 리뷰
    public List<SimpReview> getByHostId(String hostId) throws Exception {
        return reviewRepository.selectByHostId(hostId);
    }

    // 호스트의 모든 숙소에 대한 리뷰 + 리뷰 답글

}