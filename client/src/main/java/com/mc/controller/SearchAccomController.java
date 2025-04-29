package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.service.AccomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class SearchAccomController {

    @Autowired
    private AccomService accomService;

    @GetMapping("/search-accommodations")
    @ResponseBody
    public List<Accommodations> searchAccommodations(@RequestParam("location") String location) {
        List<Accommodations> accommodations = accomService.getAccommodationsByLocation(location);
        return accommodations.stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
    }

    private Accommodations convertToResponseDTO(Accommodations accommodation) {

        return Accommodations.builder()
                .accommodationId(accommodation.getAccommodationId())
                .name(accommodation.getName())
                .location(accommodation.getLocation())
                .priceNight(accommodation.getPriceNight())
                .description(accommodation.getDescription())
                .image1Name(accommodation.getImage1Name())
                .image2Name(accommodation.getImage2Name())
                .image3Name(accommodation.getImage3Name())
                .image4Name(accommodation.getImage4Name())
                .image5Name(accommodation.getImage5Name())
                .build();
    }
}
