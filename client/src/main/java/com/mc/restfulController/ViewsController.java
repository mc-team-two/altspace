package com.mc.restfulController;

import com.mc.app.service.AccomService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api")
@RestController
@RequiredArgsConstructor
@Slf4j
public class ViewsController {

    private final AccomService accomService;

    @RequestMapping("/update-views")
    public ResponseEntity<Void> updateViews(@RequestParam("accId") int accId) {
        accomService.updateAccommodationViews(accId);
        return ResponseEntity.noContent().build(); // 204 No Content
    }

}
