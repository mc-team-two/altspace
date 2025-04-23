package com.mc.controller;

import com.mc.app.dto.Accommodations;
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

    @GetMapping("/search-accommodations")
    @ResponseBody
    public List<Accommodations> searchAccommodations(@RequestParam("location") String location) {
        return accomService.getAccommodationsByLocation(location);
    }

}
