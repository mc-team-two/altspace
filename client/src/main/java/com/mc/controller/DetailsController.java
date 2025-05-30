package com.mc.controller;

import com.mc.app.dto.Accommodations;
import com.mc.app.dto.User;
import com.mc.app.dto.Payments;
import com.mc.app.service.AccomService;
import com.mc.app.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/details")
public class DetailsController {

    private final PaymentService paymentService;
    private final AccomService accomService;

    String dir ="details/";

    @RequestMapping("")
    public String details(Model model, HttpSession httpSession) throws Exception {

        User user = (User)httpSession.getAttribute("user");

        if (user == null) {
            return "redirect:/login"; // 세션 만료나 비로그인 처리
        }

        // user 객체에서 아이디 가져오기
        String userId = user.getUserId();

        // DB 조회용 객체 생성
        Payments payments = new Payments();
        payments.setGuestId(userId);

        // 실제 DB 조회(여러 건 가져올 수 있음)
        List<Payments> paymentList = paymentService.selectPyAll(payments);

        model.addAttribute("paymentList", paymentList);
        model.addAttribute("center", dir + "center");
        return "index";
    }

    @GetMapping("/payment/modal")
    public String getPaymentModal(Model model,
                                  @RequestParam("id") int id,
                                  @RequestParam("pyStatus") String pyStatus,
                                  @RequestParam("paymentId") Integer paymentId) throws Exception {

        if (!"완료".equals(pyStatus) || paymentId == null) {
            model.addAttribute("error", "예약 상태가 완료가 아닙니다.");
            return "details/modalBox";
        }
        Payments payInfo = paymentService.selectPayment(paymentId);
        Accommodations accomm = accomService.get(id);
        Date checkInDate = Date.valueOf(payInfo.getCheckIn());
        Date checkOutDate = Date.valueOf(payInfo.getCheckOut());

        model.addAttribute("accomm", accomm);
        model.addAttribute("payInfo", payInfo);
        model.addAttribute("checkInDate", checkInDate);
        model.addAttribute("checkOutDate", checkOutDate);

        return "details/modalBox";
    }
}
