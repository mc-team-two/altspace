package com.mc.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class AccomSuggestion {
    private String location;
    private String checkIn;
    private String checkOut;
    private int personnel;
    private List<String> extras;
}
