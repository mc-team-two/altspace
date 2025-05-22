package com.mc.app.dto;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Reviews {
    private int reviewId;

    @NotBlank(message = "작성자 정보가 없습니다. 로그인 페이지로 이동합니다.")
    private String guestId;         // 리뷰 작성한 게스트

    @Positive(message = "숙소 정보가 없습니다. 로그인 페이지로 이동합니다.")
    private int accommodationId;    // 리뷰 대상 숙박시설

    @Min(value = 1, message = "평점은 필수 항목입니다.")
    @Max(value = 5, message = "평점은 1~5 사이여야 합니다.")
    private int grade;              // 평점

    @NotBlank(message = "리뷰 내용을 작성해주세요.")
    @Size(max = 1000, message = "리뷰는 최대 1000자까지 작성할 수 있습니다.")
    private String comment;         // 내용
    private String name;            // 숙소 이름(조인해서 받아오는 값)
    private String location;        // 숙소 주소(조인해서 받아오는 값)
    private Timestamp createDay;
    private Timestamp updateDay;
    private List<MultipartFile> images; // 파일 업로드용 (폼에서 들어오는 다중 파일)
    private List<String> imageUrl;  // 이미지 URL 리스트 추가
    private double rating;
    // 답글 정보 추가
    private Integer replyId;
    private String userId;
    private String replyComment;
    private Timestamp replyCreateDay;
    private Timestamp replyUpdateDay;
}
