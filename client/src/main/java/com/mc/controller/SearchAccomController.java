package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.AccomodationsWithRating;
import com.mc.app.service.AccomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

@Controller
public class SearchAccomController {

    @Autowired
    private AccomService accomService;

    private AccomodationsWithRating accomodationsWithRating;

    @GetMapping("/search-accommodations")
    @ResponseBody
    public Object searchAccommodations(
            @RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "checkInDate", required = false) String checkInDate,
            @RequestParam(value = "checkOutDate", required = false) String checkOutDate,
            @RequestParam(value = "personnel", required = false) String personnel,
            @RequestParam(value = "extras[]", required = false) List<String> extras,
            @RequestParam(value = "withRating", required = false, defaultValue = "false") boolean withRating
    ) throws Exception {
        List<Accommodations> accommodations = accomService.getAccommodationsByLocation(location, checkInDate, checkOutDate, personnel, extras);
        if (withRating) {
            return accomService.getAccommodationsWithRating(accommodations);
        } else {
            return accommodations;
        }
    }

    @GetMapping("/search-accommodations-geo")
    @ResponseBody
    public List<AccomodationsWithRating> searchAccommodationsByGeoLocation(
            @RequestParam("latitude") double latitude,
            @RequestParam("longitude") double longitude,
            @RequestParam("radius") double radius,
            @RequestParam(value = "extras[]", required = false) List<String> extras,
            @RequestParam(value = "withRating", required = false, defaultValue = "false") boolean withRating
    ) throws Exception {
        return accomService.searchAccommodationsByGeoLocation(latitude, longitude, radius, extras, withRating);
    }
}