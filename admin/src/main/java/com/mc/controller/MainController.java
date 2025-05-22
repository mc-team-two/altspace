package com.mc.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.app.dto.Payments;
import com.mc.app.dto.SocialUser;
import com.mc.app.dto.User;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import com.mc.app.service.SocialUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;
import java.util.Map;

import static net.sf.jsqlparser.util.validation.metadata.NamedObject.user;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    final SocialUserService socialUserService;
    final PaymentService paymentService;
    final AccomService accomService;

    @RequestMapping("/")
    public String main(Model model, HttpSession httpSession) throws Exception {
        // 로그인 했을 때만 접속 가능함
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }

        User user = (User) httpSession.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }

        String hostId = user.getUserId();
        model.addAttribute("hostId", hostId);

        // 이번 달 총 결제 금액 가져오기
        Integer monthTotal = paymentService.getMonthTotal();
        String formattedMonthTotal = String.format("%,d", monthTotal);

        // 현재 예약 건수 계산
        List<Payments> upcomingReservations = paymentService.getUpcomingReservations();
        int reservationCount = upcomingReservations.size();

        // 오늘/내일 체크인 예약 건수 가져오기
        Integer todayCheckInCount = paymentService.getTodayCheckInCount();
        Integer tomorrowCheckInCount = paymentService.getTomorrowCheckInCount();

        // 오늘/내일 체크아웃 예약 건수 가져오기
        Integer todayCheckOutCount = paymentService.getTodayCheckOutCount();
        Integer tomorrowCheckOutCount = paymentService.getTomorrowCheckOutCount();

        // 다가오는 7일 이내의 예약 정보 가져오기
        List<Payments> upcoming7DaysReservations = paymentService.getUpcoming7DaysReservations();

        // 이번 달 인기 스페이스
        Payments popularSpace = paymentService.getPopularSpaceThisMonth();

        // 월별 수익 데이터 가져오기
        List<Map<String, Object>> earningsList = paymentService.getLast6MonthsEarnings();
        model.addAttribute("earningsDataJson", new ObjectMapper().writeValueAsString(earningsList));

        // 호스트 숙소 수 조회
        int accommodationCount = accomService.getAccommodationCountByHost(hostId);

        // 전체 예약 건수 가져오기
        Integer totalReservationCount = paymentService.getTotalReservationCount();

        // 모델에 데이터 추가
        model.addAttribute("reservationCount", reservationCount);
        model.addAttribute("monthTotal", formattedMonthTotal);
        model.addAttribute("todayCheckInCount", todayCheckInCount);
        model.addAttribute("tomorrowCheckInCount", tomorrowCheckInCount);
        model.addAttribute("todayCheckOutCount", todayCheckOutCount);
        model.addAttribute("tomorrowCheckOutCount", tomorrowCheckOutCount);
        model.addAttribute("upcoming7DaysReservations", upcoming7DaysReservations);
        model.addAttribute("popularSpace", popularSpace);
        model.addAttribute("last6MonthsEarnings", earningsList);
        model.addAttribute("accommodationCount", accommodationCount);
        model.addAttribute("totalReservationCount", totalReservationCount);
        model.addAttribute("center","center");

        return "index";
    }

    @RequestMapping("/mypage")
    public String mypage(Model model, HttpSession httpSession) throws Exception {
        // 로그인 했을 때만 접속 가능함
        if (httpSession.getAttribute("user") == null) {
            return "redirect:/auth/login";
        }
        User user = (User) httpSession.getAttribute("user");
        SocialUser socialUser = socialUserService.get(user.getUserId());

        model.addAttribute("socialUser", socialUser);
        model.addAttribute("user", user);
        model.addAttribute("center","mypage");
        return "index";
    }

}
