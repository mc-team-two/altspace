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

    @NotBlank(message = "작성자 ID는 필수입니다.")
    private String guestId;

    @Min(value = 1)
    private int accommodationId;

    @Min(value = 1)
    @Max(value = 5)
    private int grade;

    @NotBlank(message = "리뷰 내용을 입력해주세요.")
    @Size(max = 1000, message = "리뷰는 1000자 이내로 작성해주세요.")
    private String comment;

    private String name;
    private String location;
    private Timestamp createDay;
    private Timestamp updateDay;

    private List<MultipartFile> images;
    private List<String> imageUrl;
    private double rating;

    private Integer replyId;
    private String userId;
    private String replyComment;
    private Timestamp replyCreateDay;
    private Timestamp replyUpdateDay;
}