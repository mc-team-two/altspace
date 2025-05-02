package com.mc.app.dto;

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
    private String guestId;         // 리뷰 작성한 게스트
    private int accommodationId;    // 리뷰 대상 숙박시설
    private int grade;              // 평점
    private String comment;         // 내용
    private String name;            // 숙소 이름(조인해서 받아오는 값)
    private String location;        // 숙소 주소(조인해서 받아오는 값)
    private Timestamp createDay;
    private Timestamp updateDay;
    private List<MultipartFile> images; // 파일 업로드용 (폼에서 들어오는 다중 파일)
    private List<String> imageUrl;  // 이미지 URL 리스트 추가


}
