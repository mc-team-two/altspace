// AccomSuggestion.java
package com.mc.app.dto;

import jakarta.validation.constraints.*;
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
    @NotBlank(message = "위치를 입력해주세요.")
    private String location;

    @NotBlank
    private String checkIn;

    @NotBlank
    private String checkOut;

    @Min(1)
    private int personnel;

    private List<String> extras;
}
