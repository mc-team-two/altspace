package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Guide {
    private int guideNumber;
    private String guideCategory;
    private String guideTitle;
    private String guideContent;
}
