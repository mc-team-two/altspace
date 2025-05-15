<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="ko">
<head>
    <script src="<c:url value="js/jquery-3.2.1.min.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_responsive.css"/>">
    <%--<link rel="stylesheet" type="text/css" href="<c:url value="styles/about_styles.css"/>">--%>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/about_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/payment_styles.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">

    <style>
        .btn-custom-small {
            padding: 15px 45px;
            font-size: 1rem;
            width: auto;
            min-width: 0;
            border-radius: 8px;
            margin-left: auto;
        }

        /* 기본 상태 (흰 배경, 파란 글자) */
        .translate-btn {
            background-color: white;
            color: #0d6efd; /* Bootstrap primary */
            border: 1px solid #0d6efd;
            transition: all 0.2s ease;
        }

        /* hover 상태 (파란 배경, 흰 글자) */
        .translate-btn:hover {
            background-color: #0d6efd;
            color: white;
        }

        /* 번역된 상태: 항상 파란 배경과 흰 글자 유지 */
        .translate-btn.translated {
            background-color: #0d6efd;
            color: white;
            border-color: #0d6efd;
        }

        /* 번역된 상태에서도 hover는 유지되도록 (시각적으로 동일하게) */
        .translate-btn.translated:hover {
            background-color: #0b5ed7; /* 조금 더 진한 파랑으로 효과 */
            color: white;
        }
    </style>
</head>
<body>
<script>
    const change = {
        init: function () {
            const reservedRanges = [
                <c:forEach var="r" items="${chInChOut}" varStatus="status">
                ["${r.checkIn}", "${r.checkOut}"]<c:if test="${!status.last}">, </c:if>
                </c:forEach>                        // Status.last : 마지막 반복일 때만 true
            ];

            const bookedDates = [];
            reservedRanges.forEach(range => {
                let current = moment(range[0]);    // 시작 날짜(종료 날짜까지 하루씩 증가하면서 날짜를 추가함)
                const end = moment(range[1]);      // 종료 날짜

                while (current.isBefore(end, 'day')) {
                    bookedDates.push(current.format('YYYY-MM-DD'));  // 현재 날짜 추가
                    current.add(1, 'days');       // 하루 증가
                }
            });

            const priceNight = ${accomm.priceNight};
            $('input[name="dates"]').daterangepicker({
                autoApply: true,
                minDate: moment().add(1, 'days'),
                autoUpdateInput: false,
                isInvalidDate: function (date) {
                    return bookedDates.includes(date.format('YYYY-MM-DD'));
                },
                locale: {
                    format: 'YYYY-MM-DD',
                    applyLabel: "적용",
                    cancelLabel: "취소",
                    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
                        "7월", "8월", "9월", "10월", "11월", "12월"],
                    firstDay: 0
                },
            });

            $('input[name="dates"]').on('apply.daterangepicker', function (ev, picker) {
                // 수동으로 input에 세팅해야 함!(autoUpdateInput: false 이거 때문에)
                $(this).val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));

                const checkin = picker.startDate;
                const checkout = picker.endDate;
                const delDays = checkout.diff(checkin, 'days'); // 숙박일수
                const total = delDays * priceNight; // 숙박요금 합계

                // 체크인/체크아웃 날짜 세팅
                $('#checkIn').val(checkin.format('YYYY-MM-DD'));
                $('#checkOut').val(checkout.format('YYYY-MM-DD'));
                $('#totalPrices').text(total);

                // 금액 관련 세팅
                setTimeout(() => {
                    const serviceFee = Math.floor(total * 0.1); // 수수료 10% 고정
                    const totalAmount = total + serviceFee; // 총합 = 숙박요금 + 수수료

                    $('#nightsCount').text(delDays);                            // 몇 박
                    $('#totalPrices').text('₩' + total.toLocaleString());       // 숙박 금액
                    $('#serviceFee').text('₩' + serviceFee.toLocaleString());   // 수수료
                    $('#totalAmount').text('₩' + totalAmount.toLocaleString()); // 총합
                    $('#payAmount').val(totalAmount);                           // 숨겨진 input에도 세팅
                }, 100);
            });
            this.displayMap();

            $('#sales_add_btn').click(() => {
                this.reqPay();
            });
            $('#cancel_btn').click(() => {
                this.cancel();
            });
            $('#review_btn').click(() => {
                this.review();
            });
            $('.wishlist-btn').click(() => {
                this.wishlistToggle();
            });
            $('.translate-btn').click(function() {
                change.translate.call(this); // 버튼 this를 전달
            });
            $('#summaryBtn').click(function() {
                change.reviewSummary.call(this); // 버튼 this를 전달
            });
        },
        reqPay: function () {
            var IMP = window.IMP;
            IMP.init("imp35658175"); // 가맹점 식별코드로 Iamport 초기화

            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",   // 카드 결제 창을 띄어달라는 의미 / 카드 결제가 아님
                merchant_uid: "ORD" + new Date().getTime(),
                name: "${accomm.name}",
                amount: Number($('#payAmount').val()),
                buyer_email: "${sessionScope.user.email}",
                buyer_name: "${sessionScope.user.name}",
                buyer_tel: "${sessionScope.user.phone}"
            }, function (rsp) {
                if (rsp.success) {
                    $('#imp_hidden').val(rsp.imp_uid);  // 결제 완료 후 imp_uid input에 저장
                    // 실제 결제 정보 검증
                    $.ajax({
                        type: 'POST',
                        url: '/payment/verify/' + rsp.imp_uid,
                        data: $('#data_add').serialize(),  // ← form 전체를 직렬화해서 같이 보냄
                    }).done(function (data) {
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
        cancel: function () {
            let impUid = "${payInfo.impUid}"; // 저장된 imp_uid 가져오기

            if (!impUid) {
                alert("결제 내역이 없습니다.");
                return;
            }

            $.ajax({
                type: "POST",
                url: "/payment/cancel/" + impUid,
                data: $('#data_del').serialize(),
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                success: function (res) {
                    alert(res.message);
                    location.reload(); // 취소 후 새로고침
                },
                error: function (err) {
                    try {              // err는 실패한 응답이라 자동 파싱 x
                        const errorMsg = JSON.parse(err.responseText).message;
                        alert("취소 실패: " + errorMsg);
                    } catch (e) {
                        alert("취소 실패: 알 수 없는 오류");
                    }
                }
            });
        },
        review: function () {
            $('#data_del').attr({
                'method':'post',
                'action':'<c:url value="/reviewAdd?id=${accomm.accommodationId}"/>'
            });
            $('#data_del').submit();
        },
        displayMap: function () {
            var mapContainer = document.getElementById('kaoMap');
            var mapOption = {
                center: new kakao.maps.LatLng(${accomm.latitude}, ${accomm.longitude}),
                level: 4
            };
            this.map = new kakao.maps.Map(mapContainer, mapOption);

            // 마우스 휠 확대/축소 막기 (정확한 메서드 사용)
            this.map.setZoomable(false);

            var mapTypeControl = new kakao.maps.MapTypeControl();
            this.map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            var zoomControl = new kakao.maps.ZoomControl();
            this.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            // 바로 마커 표시
            var markerPosition = new kakao.maps.LatLng(${accomm.latitude}, ${accomm.longitude});
            this.marker = new kakao.maps.Marker({
                position: markerPosition
            });
            this.marker.setMap(this.map);
        },
        wishlistToggle: function () {
            const accommId = parseInt("${accomm.accommodationId}");
            const wishlistIdStr = $(".wishlist-btn").data("wishlist-id"); // data-wishlist-id 값 가져오기
            const wishlistId = wishlistIdStr ? parseInt(wishlistIdStr) : null;

            const isWished = $(".wishlist-btn").hasClass("btn-danger"); // 이미 찜한 상태인지 확인

            if (isWished) {
                // 찜 삭제 요청
                if (!wishlistId) {
                    alert("찜 ID 정보가 없습니다. 다시 시도해주세요.");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "/wishlist/delete",
                    data: {
                        wishlistId: wishlistId
                    },
                    success: function (response) {
                        if (response.success) {
                            alert("찜 목록에서 취소되었습니다.");
                            $(".wishlist-btn")
                                .removeClass("btn-danger")
                                .addClass("btn-outline-danger")
                                .html('<i class="bi bi-heart"></i> 찜');
                            location.reload(); // 페이지 새로고침

                            /*// 데이터 갱신: 버튼에서 data-wishlist-id를 삭제
                            $(".wishlist-btn").removeData("wishlist-id");*/
                        } else {
                            alert("찜 삭제에 실패했습니다.");
                        }
                    },
                    error: function () {
                        alert("서버 오류로 찜 삭제에 실패했습니다.");
                    }
                });
            } else {
                $.ajax({
                    type: "POST",
                    url: "/wishlist/add",
                    data: {
                        accommodationId: accommId
                    },
                    success: function (response) {
                        if (response.success) {
                            alert("찜 목록에 추가되었습니다!");
                            // 버튼 UI 변경
                            $(".wishlist-btn")
                                .removeClass("btn-outline-danger")
                                .addClass("btn-danger")
                                .html('<i class="bi bi-heart-fill"></i> 찜');
                            location.reload(); // 페이지 새로고침

                            /*// 새로 생성된 wishlistId 값 갱신 (서버에서 response로 받은 wishlistId)
                            $(".wishlist-btn").data("wishlist-id", response.wishlistId);*/
                        } else {
                            alert("이미 찜한 숙소입니다.");
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("찜 추가에 실패했습니다. 다시 시도해주세요.");
                        console.error("Error:", error);
                    }
                });
            }
        },
        translate: function(){
            const $btn = $(this);
            const reviewId = $btn.data('review-id');
            const originalText = $btn.data('original');
            const $comment = $('.review-comment[data-review-id="' + reviewId + '"]');

            // 이미 번역 상태인지 확인
            if ($btn.data('translated')) {
                // 원문으로 복원
                $comment.text(originalText);
                $btn.data('translated', false);
                $btn.removeClass('translated');
            } else {
                // 서버에 번역 요청
                $.ajax({
                    type: 'POST',
                    url: '/review/translate',
                    contentType: 'application/json',
                    data: JSON.stringify({ msg: originalText, target: 'en' }),
                    success: function (translatedText) {
                        $comment.text(translatedText);
                        $btn.data('translated', true);
                        $btn.addClass('translated');
                    },
                    error: function () {
                        alert('번역 중 오류가 발생했습니다.');
                    }
                });
            }
        },
        reviewSummary: function(){
            const btn = document.getElementById("summaryBtn");
            const summaryBox = document.getElementById("summaryContent");

            // 버튼 숨기고 로딩 문구 보여주기
            btn.style.display = "none";
            summaryBox.innerHTML = "<span class='text-muted'>🌀 AI가 요약 중입니다... 잠시만 기다려 주세요.</span>";

            $.ajax({
                url: `review/reviewSummary/${accomm.accommodationId}`,
                method: "GET",
                success: function(getResult) {
                    summaryBox.innerHTML = ""; // 이전 내용 제거
                    const lines = getResult.split('\n');

                    lines.forEach(line => {
                        const p = document.createElement("p");
                        p.className = "text-dark mb-0";
                        p.textContent = line;
                        summaryBox.appendChild(p);
                    });
                },
                error: function () {
                    summaryBox.innerHTML = "<span class='text-danger'>요약 중 오류가 발생했습니다.</span>";
                    // 버튼 다시 보이게 (선택 사항)
                    btn.style.display = "inline-block";
                }
            });
        }
    };

    $(document).ready(function () {
        change.init();
    });
</script>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">여행의 시작, 이곳에서</div>
    </div>
</div>

<!-- 센터 -->
<div class="container mt-4">
    <!-- 이미지 영역 -->
    <div class="row no-gutters">
        <!-- 대표 이미지 -->
        <div class="col-md-7 pr-md-1 mb-2">
            <div class="image-hover" style="height: 400px;">
                <img src="${pageContext.request.contextPath}/images/${accomm.image1Name}" alt="대표 이미지"
                     style="width: 100%; height: 100%; object-fit: cover;">
            </div>
        </div>

        <!-- 서브 이미지들 -->
        <div class="col-md-5">
            <div class="row no-gutters">
                <div class="col-6 pl-md-1 pr-1 mb-2">
                    <div class="image-hover" style="height: 195px;">
                        <img src="${pageContext.request.contextPath}/images/${accomm.image2Name}" alt="서브 이미지1"
                             style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                </div>
                <div class="col-6 pl-1 mb-2">
                    <div class="image-hover" style="height: 195px;">
                        <img src="${pageContext.request.contextPath}/images/${accomm.image3Name}" alt="서브 이미지2"
                             style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                </div>
                <div class="col-6 pl-md-1 pr-1">
                    <div class="image-hover" style="height: 195px;">
                        <img src="${pageContext.request.contextPath}/images/${accomm.image4Name}" alt="서브 이미지3"
                             style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                </div>
                <div class="col-6 pl-1 position-relative">
                    <div class="image-hover" style="height: 195px;">
                        <img src="${pageContext.request.contextPath}/images/${accomm.image5Name}" alt="서브 이미지4"
                             style="width: 100%; height: 100%; object-fit: cover;">
                        <!-- 모두 보기 버튼 -->
                        <div class="overlay-btn" data-toggle="modal" data-target="#photoModal">
                            사진 전체 보기
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h2>${accomm.name}</h2>
    <!-- 상단 정보 카드 3개 -->
    <div class="row mt-3 mb-4">
        <!-- 최근 리뷰 -->
        <div class="col-md-4">
            <div class="card shadow-sm p-3 rounded-4 h-100">
                <div class="d-flex align-items-center mb-2" style="font-size: 1rem; font-weight: bold;">
                    <span class="badge bg-warning text-dark mr-1">
                        <i class="bi bi-star-fill"></i>${averageRating}
                    </span>
                    <span>${reviewCount}개 리뷰</span>
                </div>
                <c:forEach var="rv" items="${review}" varStatus="status">
                    <c:if test="${status.index == 0}">
                        <p class="text-muted">${rv.comment}</p>
                    </c:if>
                </c:forEach>
                <a href="#reviewSection" class="text-decoration-none small text-primary">리뷰 전체 보기 →</a>
            </div>
        </div>
        <!-- 숙소 정보 카드 -->
        <div class="col-md-4">
            <div class="card shadow-sm p-3 rounded-4 h-100">
                <h6 class="mb-3"><strong>부대시설 및 서비스</strong></h6>

                <!-- 카테고리 · 룸타입 · 최대인원 -->
                <div class="text mb-3" style="font-size:0.85rem; margin-top:-13px;">
                    ${accomm.category} &middot; ${accomm.roomType} &middot; 최대 ${accomm.personMax}명
                </div>

                <!-- 부대시설 아이콘 -->
                <div class="d-flex justify-content-start flex-wrap">
                    <c:if test="${accomm.breakfast}">
                        <div class="text-center mx-2 mb-2" style="margin-top: -5px;">
                            <i class="fa fa-coffee text-danger" style="font-size: 1.25rem;"></i><br/>
                            <small>조식</small>
                        </div>
                    </c:if>
                    <c:if test="${accomm.pool}">
                        <div class="text-center mx-2 mb-2" style="margin-top: -5px;">
                            <i class="fa fa-swimmer text-primary" style="font-size: 1.25rem;"></i><br/>
                            <small>수영장</small>
                        </div>
                    </c:if>
                    <c:if test="${accomm.barbecue}">
                        <div class="text-center mx-2 mb-2" style="margin-top: -5px;">
                            <i class="fa fa-fire-alt text-warning" style="font-size: 1.25rem;"></i><br/>
                            <small>바베큐</small>
                        </div>
                    </c:if>
                    <c:if test="${accomm.pet}">
                        <div class="text-center mx-2 mb-2" style="margin-top: -5px;">
                            <i class="fa fa-paw text-info" style="font-size: 1.25rem;"></i><br/>
                            <small>반려동물</small>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        <!-- 위치 정보 카드 -->
        <div class="col-md-4">
            <div class="card shadow-sm p-3 rounded-4 h-100">
                <h6 class="mb-2"><strong>위치 정보</strong></h6>
                <p class="text-muted">${accomm.location}</p>
                <a href="#mapSection" class="text-primary small">지도보기 →</a>
            </div>
        </div>
    </div>

    <!-- 호스트 카드 + 상세 설명 -->
    <div class="row mb-4">
        <div class="col-md-8 mb-4">
            <!-- 호스트 카드 -->
            <div class="card shadow-sm p-4 rounded-4 mb-4"
                 style="border-left: 6px solid #007bff; background-color: #f8f9fa;">
                <div class="d-flex align-items-center">
                    <!-- 호스트 정보 -->
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-circle text-primary mr-3" style="font-size: 1.75rem;"></i>
                        <div>
                            <div class="font-weight-bold mb-1" style="font-size: 1rem;">호스트: ${accomm.hostId} 님</div>
                            <div class="text-muted" style="font-size: 0.8rem;">신입호스트 · 호스팅 경력 6개월</div>
                        </div>
                    </div>
                    <!-- 문의 버튼 -->
                    <a href="#"
                       onclick="window.open('<c:url
                               value="/chat/${accomm.accommodationId}"/>', 'chatWindow', 'width=480,height=650'); return false;"
                       class="btn btn-outline-primary btn-custom-small">
                        <i class="bi bi-chat-left-dots mr-1"></i>
                        <span>호스트에게 1:1 문의하기</span>
                    </a>
                </div>
            </div>

            <!-- 숙소 설명 -->
            <div class="card shadow-sm p-4 rounded-4">
                <div>${accomm.description}</div>
            </div>
        </div>
        <!-- 예약 박스 -->
        <div class="col-md-4 sticky-reservation">
            <div class="card shadow-sm p-4 rounded-4">
                <c:choose>
                    <c:when test="${pyStatus == '완료'}">
                        <h3 class="fw-bold text-center mb-4">예약 내역</h3>

                        <form id="data_del">
                            <input type="hidden" name="guestId" value="${sessionScope.user.userId}">
                            <input type="hidden" name="accommodationId" value="${accomm.accommodationId}">
                            <input type="hidden" name="impUid" value="${payInfo.impUid}">
                            <input type="hidden" name="paymentId" value="${payInfo.paymentId}">

                            <ul class="list-unstyled mb-0">
                                <li class="mb-2">
                                    <i class="bi bi-calendar-check me-2 text-success"></i>
                                    <strong>체크인:</strong>
                                    <fmt:formatDate value="${checkInDate}" pattern="yyyy-MM-dd"/>
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-calendar-x me-2 text-danger"></i>
                                    <strong>체크아웃:</strong>
                                    <fmt:formatDate value="${checkOutDate}" pattern="yyyy-MM-dd"/>
                                </li>
                                <li>
                                    <i class="bi bi-wallet2 me-2 text-warning"></i>
                                    <strong>결제 금액:</strong>
                                    <fmt:formatNumber value="${payInfo.payAmount}" type="number"/> 원
                                </li>
                            </ul>
                        </form>

                        <p class="text-danger small mt-3 mb-0">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i>
                            체크인 날짜로부터 <strong>2일 전</strong>에는 예약 취소가 불가합니다.
                        </p>

                        <div class="d-flex justify-content-between mt-4">
                            <button id="review_btn" class="btn btn-primary rounded-pill w-50 fw-bold mr-2">
                                리뷰 작성
                            </button>
                            <button id="cancel_btn" class="btn btn-danger rounded-pill w-50 fw-bold">
                                예약 취소
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="price-per-night mb-3">
                            <span class="price-amount">₩<fmt:formatNumber value="${accomm.priceNight}"
                                                                          type="number"/></span> /박
                        </div>

                        <form id="data_add">
                            <input type="hidden" name="guestId" value="${sessionScope.user.userId}"/>
                            <input type="hidden" name="accommodationId" value="${accomm.accommodationId}"/>
                            <input type="hidden" id="imp_hidden" name="impUid"/>
                            <input type="hidden" name="checkIn" id="checkIn"/>
                            <input type="hidden" name="checkOut" id="checkOut"/>
                            <input type="hidden" name="payAmount" id="payAmount"/> <%-- 서버에 값을 보내기 위함 --%>
                            <input type="hidden" name="payStatus" value="완료"/>

                            <div class="form-group mb-3">
                                <input type="text" name="dates" class="form-control text-center datepicker-input"
                                       id="dates" readonly placeholder="체크인 - 체크아웃">
                            </div>

                            <div class="price-box">
                                <div class="d-flex justify-content-between mb-2">
                                    <span><fmt:formatNumber value="${accomm.priceNight}" type="number"/> × <span
                                            id="nightsCount">0</span>박</span>
                                    <span id="totalPrices">₩0</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>알트스페이스 서비스 수수료</span>
                                    <span id="serviceFee">₩0</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between fw-bold fs-5">
                                    <span>총 결제 금액</span>
                                    <span id="totalAmount">₩0</span>
                                </div>
                            </div>
                        </form>

                        <div class="d-flex mt-3 mb-3" style="gap: 0.4rem;">
                            <!-- 찜 버튼 -->
                            <c:if test="${not empty resultWishlist}">
                                <c:set var="wishlistId" value="${resultWishlist.wishlistId}"/>
                            </c:if>
                            <button
                                    class="btn rounded-pill w-30 wishlist-btn
                                    ${not empty resultWishlist ? 'btn-danger' : 'btn-outline-danger'}"
                                    style="flex: 3;"
                                    data-wishlist-id="${not empty resultWishlist ? resultWishlist.wishlistId : ''}">
                                <i class="bi ${not empty resultWishlist ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                ${not empty resultWishlist ? '찜' : '찜'}
                            </button>

                            <!-- 예약하기 버튼 -->
                            <button id="sales_add_btn" type="button"
                                    class="btn btn-primary btn-reserve rounded-pill w-70"
                                    style="flex: 7;">
                                예약하기
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div id="mapSection" class="kakao-map-wrapper">
        <div class="map-header">위치</div>
        <div id="kaoMap" class="kakao-map"></div>
        <div class="map-footer">주소: ${accomm.location}</div>
    </div>

    <!-- AI 리뷰 요약 영역 -->
    <div id="aiReviewSummary" class="card mt-3 shadow-sm p-4 rounded-4" style="min-height: 200px;">
        <div class="d-flex justify-content-between align-items-center mb-1">
            <h5 class="mb-1 text-center w-100" style="font-size: 1rem;">AI가 도와주는 최근 3개월 리뷰 요약</h5>
        </div>
        <!-- 요약 결과, 버튼, 로딩 문구가 표시될 자리 -->
        <div id="summaryContent" class="d-flex justify-content-center align-items-center text-secondary text-center" style="min-height: 120px;">
            <button id="summaryBtn"
                    class="btn btn-outline-primary btn-sm"
                    style="width: 300px; font-size: 1rem;">
                요약 리뷰 보기
            </button>

        </div>
    </div>

    <!-- 리뷰 목록 -->
    <div id="reviewSection" class="card mt-3 shadow-sm p-4 rounded-4">
        <!-- 공통 폼 (id는 유일하게 하나만!) -->
        <form id="reviewForm"></form>
        <h5 class="card-title fw-bold mb-4">리뷰 목록</h5>
        <c:forEach var="rv" items="${review}">
            <div class="border-bottom mb-4 pb-4">
                <div class="d-flex justify-content-between align-items-start flex-wrap">
                    <!-- 왼쪽 : 작성자 및 별점 -->
                    <div class="mb-2" style="flex: 0 0 150px;">
                        <p class="mb-1 fw-semibold text-dark">👤 ${rv.guestId}</p>
                        <p class="mb-1 text-warning" style="font-size: 0.95rem;">
                            <c:forEach var="i" begin="1" end="5">
                                <c:choose>
                                    <c:when test="${i <= rv.grade}">★</c:when>
                                    <c:otherwise>☆</c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <span class="text-secondary small">(${rv.grade})</span>
                        </p>
                    </div>
                    <!-- 오른쪽 : 이미지 슬라이더 -->
                    <c:if test="${not empty rv.imageUrl}">
                        <div class="review-slider-container me-3" style="flex: 1 1 400px; max-width: 100%;">
                            <div class="review-slider-inner">
                                <c:forEach var="img" items="${rv.imageUrl}">
                                    <div class="slider-image-wrapper">
                                        <img src="/imgs/${img}" class="slider-image"/>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="d-flex justify-content-end w-100 mb-1">
                    <button type="button"
                            class="btn btn-outline-primary btn-sm rounded-pill translate-btn me-2"
                            style="font-size: 1rem; padding: 8px 15px; line-height: 1; width: auto; min-width: 0; margin-top: 8px"
                            data-review-id="${rv.reviewId}"
                            data-original="${rv.comment}">
                        <i class="fa fa-globe mr-1" aria-hidden="true"></i> Aa
                    </button>
                </div>
                <!-- 리뷰 내용 -->
                <p class="mt-2 mb-0 text-body review-comment" data-review-id="${rv.reviewId}">${rv.comment}</p>

                <!-- 답글이 있는 경우 표시 -->
                <c:if test="${not empty rv.replyComment}">
                    <div class="mt-3 p-3 bg-light border rounded">
                        <div class="d-flex align-items-center mb-1">
                            <span class="text-secondary small">
                                <strong>🏠 호스트의 답글</strong>
                                <span class="ml-1">(${rv.userId})님</span>
                            </span>
                            <!-- 작성 시각을 가장 오른쪽으로 -->
                            <span class="text-muted small ml-auto">
                                <fmt:formatDate value="${rv.replyCreateDay}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </span>
                        </div>
                        <!-- 답글 본문 -->
                        <p class="mb-0">${rv.replyComment}</p>
                    </div>
                </c:if>

            </div>
        </c:forEach>
        <c:if test="${empty review}">
            <p class="text-muted">아직 등록된 리뷰가 없습니다.</p>
        </c:if>
    </div>
</div>

<!-- 사진 전체 보기 모달 -->
<div class="modal fade" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="photoModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">사진 전체 보기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <img src="${pageContext.request.contextPath}/images/${accomm.image1Name}" class="img-fluid mb-3" alt="전체 대표 이미지">
                <img src="${pageContext.request.contextPath}/images/${accomm.image2Name}" class="img-fluid mb-3" alt="전체 서브 이미지1">
                <img src="${pageContext.request.contextPath}/images/${accomm.image3Name}" class="img-fluid mb-3" alt="전체 서브 이미지2">
                <img src="${pageContext.request.contextPath}/images/${accomm.image4Name}" class="img-fluid mb-3" alt="전체 서브 이미지3">
                <img src="${pageContext.request.contextPath}/images/${accomm.image5Name}" class="img-fluid mb-3" alt="전체 서브 이미지4">
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script src="<c:url value="styles/bootstrap4/popper.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/bootstrap.min.js"/>"></script>
<script src="<c:url value="plugins/Isotope/isotope.pkgd.min.js"/>"></script>
<script src="<c:url value="plugins/easing/easing.js"/>"></script>
<script src="<c:url value="plugins/parallax-js-master/parallax.min.js"/>"></script>
<script src="<c:url value="js/offers_custom.js"/>"></script>
<script src="<c:url value="js/darkmode.js"/>"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/>"></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/>"></script>
<script src="<c:url value="js/chatbot.js"/>"></script>

