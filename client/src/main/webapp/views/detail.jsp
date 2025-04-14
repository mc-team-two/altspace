<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>숙박 시설 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <%-- Date Range Picker --%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
<script>
    const change = {
        init: function () {
            const priceNight = Number("${accomm.priceNight}");

            $('input[name="dates"]').daterangepicker({
                autoApply: true,
                minDate: moment().add(1, 'days'),
                locale: {
                    format: 'YYYY-MM-DD',
                    applyLabel: "적용",
                    cancelLabel: "취소",
                    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
                        "7월", "8월", "9월", "10월", "11월", "12월"],
                    firstDay: 0
                }
            });

            $('input[name="dates"]').on('apply.daterangepicker', function(ev,picker) {
                const checkin = picker.startDate;
                const checkout = picker.endDate;

                const delDays = checkout.diff(checkin, 'days');
                const total = delDays * priceNight;

                $('#checkIn').val(checkin.format('YYYY-MM-DD'));
                $('#checkOut').val(checkout.format('YYYY-MM-DD'));
                $('#totalPrices').val(total);

                setTimeout(() => {
                    $('#totalPrice').text('총 ' + delDays + '박, 총 금액: ' + total.toLocaleString() + '원');
                }, 100);
            });

            $('#sales_add_btn').click(()=>{
                this.reqPay();
            });
            $('#cancel_btn').click(()=>{
                this.cancel();
            });
            $('#review_btn').click(()=>{
                this.review();
            });
        },
        reqPay:function(){
            var IMP = window.IMP;
            IMP.init("imp35658175"); // 가맹점 식별코드로 Iamport 초기화

            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: "ORD" + new Date().getTime(),
                name: "${accomm.name}",
                amount: Number($('#totalPrices').val()),
                buyer_email: "guest@example.com",
                buyer_name: "홍길동",
                buyer_tel: "010-0000-0000",
                buyer_addr: "서울시 강남구",
                buyer_postcode: "12345"
            }, function(rsp) {
                if (rsp.success) {
                    $('#imp_hidden').val(rsp.imp_uid);
                    // 실제 결제 정보 검증 (선택)
                    $.ajax({
                        type: 'POST',
                        url: '/payment/verify/' + rsp.imp_uid,
                        data: $('#data_add').serialize(),  // ← form 전체를 직렬화해서 같이 보냄
                    }).done(function(data) {
                        if (data.response && rsp.paid_amount === data.response.amount) {
                            // 결제 성공 및 금액 검증 완료 => 서버로 데이터 전송
                            alert(data.message || "결제 성공");
                            console.log("Payment ID : " + rsp.imp_uid);
                            console.log("Order ID : " + rsp.merchant_uid);
                            console.log("Payment Amount : " + rsp.paid_amount);
                        } else {
                            alert(data.message || "결제 금액 불일치. 결제를 취소합니다.");
                        }
                    });
                } else {
                    alert("결제 실패: " + rsp.error_msg);
                }
            });
        },
        cancel:function(){
            var impUid = $('#imp_hidden').val(); // 저장된 imp_uid 가져오기

            if (!impUid) {
                alert("결제 내역이 없습니다.");
                return;
            }

            $.ajax({
                type: "POST",
                url: "/payment/cancel/" + impUid,
                data: $('#data_add').serialize(),
                success: function(res) {
                    alert(res.message);
                    location.reload(); // 취소 후 새로고침
                },
                error: function(err) {
                    try { // err는 실패한 응답이라 자동 파싱 x
                        const errorMsg = JSON.parse(err.responseText).message;
                        alert("취소 실패: " + errorMsg);
                    } catch (e) {
                        alert("취소 실패: 알 수 없는 오류");
                    }
                }
            });
        },
        review:function(){
            $('#data_add').attr({
                'method':'post',
                'action':'<c:url value="/review?id=${accomm.accommodationId}"/>'
            });
            $('#data_add').submit();
        }
    }
    $(document).ready(function () {
        change.init();
    });
</script>

<div class="container mt-5">
    <h2 class="mb-4">숙박 시설 상세 정보</h2>
    <div class="card mb-4 shadow-sm">
        <div class="card-body">
            <h4 class="card-title font-weight-bold">${accomm.name}</h4>
            <p><strong>위치:</strong> ${accomm.location}</p>
            <p><strong>1박 가격:</strong> <fmt:formatNumber value="${accomm.priceNight}" type="number"/> 원</p>
            <p><strong>최대 인원:</strong> ${accomm.personMax} 명</p>
            <p><strong>상태:</strong> ${accomm.status}</p>
            <p><strong>카테고리:</strong> ${accomm.category}</p>
            <p><strong>객실 유형:</strong> ${accomm.roomType}</p>
            <p><strong>조식:</strong> ${accomm.breakfast ? 'O' : 'X'}</p>
            <p><strong>수영장:</strong> ${accomm.pool ? 'O' : 'X'}</p>
            <p><strong>바베큐:</strong> ${accomm.barbecue ? 'O' : 'X'}</p>
            <p><strong>반려동물:</strong> ${accomm.pet ? 'O' : 'X'}</p>
        </div>
    </div>
    <div class="card mb-4 shadow-sm">
        <form id="data_add">
            <div class="card-body">
                <input type="hidden" name="guestId" value="guest001">
                <input type="hidden" name="accommodationId" value="${accomm.accommodationId}">
                <input type="hidden" name="checkIn" id="checkIn">
                <input type="hidden" name="checkOut" id="checkOut">
                <input type="hidden" name="payAmount" id="totalPrices">
                <input type="hidden" name="payStatus" value="완료">
                <input type="hidden" name="payMeans" value="카드">
                <input type="hidden" id="imp_hidden" name="impUid">

                <h5 class="mb-3">숙박 날짜 선택</h5>
                <div class="form-group">
                    <label for="dates">체크인 / 체크아웃 날짜</label>
                    <input type="text" name="dates" class="form-control" id="dates"/>
                </div>
                <div class="mt-3" id="totalPrice" style="font-weight: bold;"></div>
            </div>
        </form>
        <button id="sales_add_btn" class="btn btn-primary">결제</button>
        <button id="cancel_btn" class="btn btn-danger">결제 취소</button>
        <button id="review_btn" class="btn btn-primary">리뷰 작성</button>
    </div>
</div>
</body>
</html>
