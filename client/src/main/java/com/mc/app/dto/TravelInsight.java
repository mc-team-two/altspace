package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TravelInsight {
    private String weather;
    private String festival;
    private String food;
    private String tips;
    private Integer maxTemp;
    private Integer minTemp;
}