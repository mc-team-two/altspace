package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ReviewReplies {
    private int replyId;
    private int reviewId;
    private String userId;
    private String comment;
    private Timestamp createDay;
    private Timestamp updateDay;
}
