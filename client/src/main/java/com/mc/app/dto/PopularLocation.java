package com.mc.app.dto;

import lombok.Data;

@Data
public class PopularLocation {
    private String name;
    private int totalViews;
    private int bookingCount;
    private Double avgRating;
}
