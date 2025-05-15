package com.mc.controller;

import com.mc.app.dto.Payments;
import com.mc.app.service.PaymentService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/payment")
public class PaymentController {

    // IamportClient 객체를 두 API KEY를 인자로 넘겨서 생성하면
    // 이 객체를 통해 iamport 함수들을 사용
    private IamportClient iamportClient;
    final PaymentService paymentService;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    @PostConstruct
    public void init() {
        this.iamportClient = new IamportClient(apiKey, secretKey);
    }

    // 결제 검증 API (imp_uid를 이용하여 결제 내역 확인)
    @ResponseBody
    @RequestMapping("/verify/{imp_uid}")
    public ResponseEntity<?> paymentByImpUid(@PathVariable("imp_uid") String imp_uid,
                                             Payments payments) throws Exception {

        // imp_uid를 이용해서 아임포트 서버에서 결제 내역을 가져옴
        IamportResponse<Payment> response = iamportClient.paymentByImpUid(imp_uid);
        // 응답 자체를 못받았을 때 or response 객체는 왔는데 결제 정보가 없을 때
        if (response == null || response.getResponse() == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "결제 정보를 불러오지 못했습니다."));
        } // js에서 data.response.amount으로 메시지 불러올 수 있게 통일

        // 실제로 필요한 결제 정보만 꺼냄
        Payment payment = response.getResponse();
        BigDecimal paidAmount = payment.getAmount();
        String payMethod = payment.getPayMethod();

        // 결제 수단 한글 매핑
        String displayMethod = switch (payMethod) {
            case "card"     -> "신용카드";  // 페이북
            case "trans"    -> "계좌이체";
            case "vbank"    -> "가상계좌";
            case "phone"    -> "휴대폰결제";
            case "kakaopay" -> "카카오페이"; // point
            case "tosspay"  -> "토스페이";
            case "payco"    -> "페이코";
            default         -> "기타";
        };

        // 여기에 DB에 저장할 로직 추가
        // 아임포트에서 결제가 완료된 경우 paid 상태
        // 실패 / 취소, failed / cancelled
        // 검증 및 DB 저장
        if (payment.getStatus().equals("paid")) {
            if (paidAmount.compareTo(payments.getPayAmount()) == 0) {
                // 정상 결제일 경우 DB에 저장
                payments.setPayStatus("완료");
                payments.setPayMeans(payMethod);  // 결제수단 알게되면 여기에 displayMethod 넣기
                paymentService.add(payments);

                // 성공한 결제 객체를 JSON으로 반환
                return ResponseEntity.ok(Map.of(
                        "message", "결제가 완료되었습니다.",
                        "response", payment
                ));
            } else {
                // 금액이 다르면 결제 취소 진행
                CancelData cancelData = new CancelData(imp_uid, true); // 전액 환불
                IamportResponse<Payment> cancelResponse = iamportClient.cancelPaymentByImpUid(cancelData);
                log.info("자동 취소 응답: " + cancelResponse.getResponse().toString());

                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("message", "금액 불일치로 결제를 자동 취소했습니다."));
            }
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("message", "결제 실패"));
    }

    @ResponseBody
    @RequestMapping("/cancel/{imp_uid}")
    public ResponseEntity<?> cancelPayment(@RequestParam("guestId") String guestId,
                                           @RequestParam("impUid") String impUid,
                                           @RequestParam("accommodationId") int accommodationId,
                                           @RequestParam("paymentId") int paymentId) throws Exception {

        // 1. 결제 정보 검색 (db조회 조건으로 사용)
        Payments payments = new Payments();
        payments.setGuestId(guestId);
        payments.setImpUid(impUid);
        payments.setAccommodationId(accommodationId);
        payments.setPaymentId(paymentId);

        // DB 에서 찾아온 데이터
        Payments targetPayment = paymentService.getOneTwo(payments);
        if (targetPayment == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "해당 결제 정보를 찾을 수 없습니다."));
        }

        // 2. 날짜 비교
        LocalDate today = LocalDate.now();
        if (!today.isBefore(targetPayment.getCheckIn().minusDays(2))) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("message", "체크인 2일 전까지만 취소가 가능합니다."));
        }

        // 3. imp_uid 가져오기
        String impUids = targetPayment.getImpUid(); // 여기서 가져옴!
        if (impUids == null || impUids.isBlank()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("message", "결제 고유 ID가 존재하지 않습니다."));
        }

        // 4. 아임포트 결제 취소
        CancelData cancelData = new CancelData(impUids, true);
        iamportClient.cancelPaymentByImpUid(cancelData);

        // 5. 결제 상태 DB 업데이트
        targetPayment.setPayStatus("취소");
        paymentService.mod(targetPayment);

        return ResponseEntity.ok(Map.of("message", "결제가 정상적으로 취소되었습니다."));
    }

}