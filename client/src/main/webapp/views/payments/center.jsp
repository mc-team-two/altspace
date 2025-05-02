<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="ko">
<head>
    <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
    <link rel="stylesheet" type="text/css" href="styles/darkmode.css">

    <style>
        /* 공통 이미지 스타일 */
        .image-hover {
            overflow: hidden;
            position: relative;
            border-radius: 10px;
        }

        .image-hover img {
            transition: transform 0.5s ease;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* 마우스 올리면 확대 */
        .image-hover:hover img {
            transform: scale(1.05);
        }

        /* 사진 전체 보기 버튼 스타일 */
        .overlay-btn {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            color: #fff;
            font-weight: bold;
            font-size: 16px;
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s;
            cursor: pointer;
        }

        /* 버튼은 hover시에만 나타남 */
        .image-hover:hover .overlay-btn {
            opacity: 1;
        }

        /* 예약 박스 고정 스타일 */
        .sticky-reservation {
            position: sticky;
            top: 100px; /* 화면 위에서 100px 내려온 곳에 고정 */
        }

        /* 모바일 대응 */
        @media (max-width: 768px) {
            .sticky-reservation {
                position: static; /* 모바일에서는 고정 안 하고 자연스럽게 */
                margin-top: 20px;
            }
        }

        .datepicker-input {
            background-color: #f8f9fa;
            cursor: pointer;
            border-radius: 20px;
            padding: 10px 20px;
            border: 1px solid #ced4da;
        }

        .datepicker-input:focus {
            border-color: #86b7fe;
            outline: 0;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }

        .price-box {
            font-size: 0.9rem;
            color: #555;
            background: #f1f3f5;
            padding: 15px;
            border-radius: 15px;
        }

        .rounded-4 {
            border-radius: 1.5rem;
        }

        .form-control {
            border-radius: 20px;
        }

        .btn{
            width: 100%;
            border-radius: 20px;
            padding: 12px 0;
            font-size: 1rem;
        }

        .price-per-night {
            font-size: 1.5rem; /* 조금 더 크게 */
            font-weight: bold;
        }

        .kakao-map-wrapper {
            width: 100%;
            margin-top: 1rem; /* 예약 박스와의 간격 확보 */
            border-radius: 1rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            font-family: 'Pretendard', sans-serif;
            background-color: white;
        }

        .map-header {
            text-align: left; /* 왼쪽 정렬 */
            padding: 0.5rem 1rem;
            font-size: 1rem; /* 큼 */
            font-weight: 600;
            background-color: #f5f5f5;
            color: #333;
        }

        .kakao-map {
            width: 100%;
            height: 450px;
            border-top: 1px solid #e0e0e0;
            border-bottom: 1px solid #e0e0e0;
        }

        .map-footer {
            text-align: left; /* 왼쪽 정렬 */
            padding: 0.5rem 1rem;
            font-size: 0.9rem; /* 작게 */
            font-weight: 400;
            background-color: #f5f5f5;
            color: #555;
        }

        .review-slider-container {
            overflow-x: auto;
            white-space: nowrap;
            padding-bottom: 8px;
        }

        .review-slider-inner {
            display: flex;
            gap: 10px;
            padding: 4px;
        }

        .slider-image-wrapper {
            flex: 0 0 auto;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .slider-image {
            height: 180px;
            width: auto;
            display: block;
            object-fit: cover;
            border-radius: 12px;
        }
    </style>
</head>

<body>
<script>
    const change = {
        init: function () {
            const priceNight = ${accomm.priceNight};

            $('input[name="dates"]').daterangepicker({
                autoApply: true,
                minDate: moment().add(1, 'days'),
                autoUpdateInput: false,
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

            $('input[name="dates"]').on('apply.daterangepicker', function(ev,picker) {
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
                pay_method: "card",   // 카드 결제 창을 띄어달라는 의미 / 카드 결제가 아님
                merchant_uid: "ORD" + new Date().getTime(),
                name: "${accomm.name}",
                amount: Number($('#payAmount').val()),
                buyer_email: "${sessionScope.user.email}",
                buyer_name: "${sessionScope.user.name}",
                buyer_tel: "${sessionScope.user.phone}",
                buyer_addr: "대구광역시",
                buyer_postcode: "12345"
            }, function(rsp) {
                if (rsp.success) {
                    $('#imp_hidden').val(rsp.imp_uid);  // 결제 완료 후 imp_uid input에 저장
                    // 실제 결제 정보 검증
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
                success: function(res) {
                    alert(res.message);
                    location.reload(); // 취소 후 새로고침
                },
                error: function(err) {
                    try {              // err는 실패한 응답이라 자동 파싱 x
                        const errorMsg = JSON.parse(err.responseText).message;
                        alert("취소 실패: " + errorMsg);
                    } catch (e) {
                        alert("취소 실패: 알 수 없는 오류");
                    }
                }
            });
        },
        review:function(){
            $('#data_del').attr({
                'method':'post',
                'action':'<c:url value="/review/dtadd?id=${accomm.accommodationId}"/>'
            });
            $('#data_del').submit();
        }
    };

    const mapCenter = {
        marker: null,
        map: null,
        init: function () {
            this.displayMap();
            this.getData(); // 최초 1회 호출
        },
        displayMap: function() {
            var mapContainer = document.getElementById('kaoMap');
            var mapOption = {
                center: new kakao.maps.LatLng(37.501634, 127.039886),
                level: 3
            };
            this.map = new kakao.maps.Map(mapContainer, mapOption);

            var mapTypeControl = new kakao.maps.MapTypeControl();
            this.map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            var zoomControl = new kakao.maps.ZoomControl();
            this.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
        },
        getData: function() {
            $.ajax({
                url: '/getlatlng',
                success: (result) => {
                    this.showMarker(result);
                }
            });
        },
        showMarker: function(result) {
            if (this.marker != null) {
                this.marker.setMap(null);
            }
            var markerPosition = new kakao.maps.LatLng(result.lat, result.lng);
            this.marker = new kakao.maps.Marker({
                position: markerPosition
            });
            this.marker.setMap(this.map);
        }
    };

    $(document).ready(function() {
        change.init();
        mapCenter.init();
    });
</script>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container"><div class="menu_close"></div></div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> ">예약 내역</a></li>
        </ul>
    </div>
</div>
<!-- 홈 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
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
                <img src="images/blog_1.jpg" alt="대표 이미지">
            </div>
        </div>

        <!-- 서브 이미지들 -->
        <div class="col-md-5">
            <div class="row no-gutters">
                <div class="col-6 pl-md-1 pr-1 mb-2">
                    <div class="image-hover" style="height: 195px;">
                        <img src="images/blog_1.jpg" alt="서브 이미지1">
                    </div>
                </div>
                <div class="col-6 pl-1 mb-2">
                    <div class="image-hover" style="height: 195px;">
                        <img src="images/blog_1.jpg" alt="서브 이미지2">
                    </div>
                </div>
                <div class="col-6 pl-md-1 pr-1">
                    <div class="image-hover" style="height: 195px;">
                        <img src="images/blog_1.jpg" alt="서브 이미지3">
                    </div>
                </div>
                <div class="col-6 pl-1 position-relative">
                    <div class="image-hover" style="height: 195px;">
                        <img src="images/blog_1.jpg" alt="서브 이미지4">
                        <!-- 모두 보기 버튼 -->
                        <div class="overlay-btn" data-toggle="modal" data-target="#photoModal">
                            사진 전체 보기
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 숙소 상세 정보 + 예약 박스 -->
    <div class="row mt-3">
        <!-- 숙소 상세 -->
        <div class="col-md-8 mb-4">
            <div class="card shadow-sm p-4 rounded-4">
                <h2 class="fw-bold mb-4">${accomm.name}</h2>
                <div class="row gy-3">
                    <div class="col-6">
                        <i class="bi bi-geo-alt-fill me-2 text-primary"></i><strong>위치:</strong> ${accomm.location}
                    </div>
                    <div class="col-6">
                        <i class="bi bi-people-fill me-2 text-info"></i><strong>최대 인원:</strong> ${accomm.personMax} 명
                    </div>
                    <div class="col-6">
                        <i class="bi bi-tag-fill me-2 text-secondary"></i><strong>카테고리:</strong> ${accomm.category}
                    </div>
                    <div class="col-6">
                        <i class="bi bi-house-door-fill me-2 text-dark"></i><strong>객실 유형:</strong> ${accomm.roomType}
                    </div>
                    <div class="col-6">
                        <i class="bi bi-cup-hot-fill me-2 text-danger"></i><strong>조식:</strong> ${accomm.breakfast ? '가능' : '불가능'}
                    </div>
                    <div class="col-6">
                        <i class="bi bi-water me-2 text-primary"></i><strong>수영장:</strong> ${accomm.pool ? '있음' : '없음'}
                    </div>
                    <div class="col-6">
                        <i class="bi bi-fire me-2 text-danger"></i><strong>바베큐:</strong> ${accomm.barbecue ? '가능' : '불가능'}
                    </div>
                    <div class="col-6">
                        <i class="bi bi-paw-fill me-2 text-info"></i><strong>반려동물:</strong> ${accomm.pet ? '가능' : '불가능'}
                    </div>
                </div>
            </div>
        </div>

        <!-- 예약 박스 -->
        <div class="col-md-4 sticky-reservation">
            <div class="card shadow-sm p-4 rounded-4">
                <c:choose>
                    <c:when test="${pyStatus == '완료'}">
                        <form id="data_del">
                            <h5 class="fw-bold mb-4">예약 내역</h5>
                            <input type="hidden" name="guestId" value="${sessionScope.user.userId}">
                            <input type="hidden" name="accommodationId" value="${accomm.accommodationId}">
                            <input type="hidden" name="impUid" value="${payInfo.impUid}">
                            <input type="hidden" name="paymentId" value="${payInfo.paymentId}">
                            <p><i class="bi bi-calendar-check me-2"></i>체크인: <fmt:formatDate value="${checkInDate}" pattern="yyyy-MM-dd" /></p>
                            <p><i class="bi bi-calendar-x me-2"></i>체크아웃: <fmt:formatDate value="${checkOutDate}" pattern="yyyy-MM-dd" /></p>
                            <p><i class="bi bi-wallet2 me-2"></i>결제 금액: <fmt:formatNumber value="${payInfo.payAmount}" type="number"/> 원</p>
                        </form>

                        <div class="d-grid gap-2 mt-4">
                            <button id="cancel_btn" class="btn btn-outline-danger rounded-pill">결제 취소</button>
                            <button id="review_btn" class="btn btn-primary rounded-pill">리뷰 작성</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="price-per-night mb-3">
                            <span class="price-amount">₩<fmt:formatNumber value="${accomm.priceNight}" type="number"/></span> /박
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
                                <input type="text" name="dates" class="form-control text-center datepicker-input" id="dates" readonly placeholder="체크인 - 체크아웃">
                            </div>

                            <div class="d-grid mt-3 mb-3">
                                <button id="sales_add_btn" type="button" class="btn btn-primary btn-reserve rounded-pill">예약하기</button>
                            </div>

                            <div class="price-box">
                                <div class="d-flex justify-content-between mb-2">
                                    <span><fmt:formatNumber value="${accomm.priceNight}" type="number"/> × <span id="nightsCount">0</span>박</span>
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
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="kakao-map-wrapper">
        <div class="map-header">위치</div>
        <div id="kaoMap" class="kakao-map"></div>
        <div class="map-footer">주소: ${accomm.location}</div>
    </div>

    <!-- 리뷰 작성 및 목록 -->
    <div class="card mt-3 shadow-sm p-4 rounded-4">
        <!-- 공통 폼 (id는 유일하게 하나만!) -->
        <form id="reviewForm"></form>
        <div class="card-body">
            <h5 class="card-title">리뷰 목록</h5>
            <c:forEach var="rv" items="${review}">
                <div class="border-bottom mb-3 pb-2">
                    <p><strong>작성자:</strong> ${rv.guestId}</p>
                    <p><strong>평점:</strong>★ ${rv.grade}</p>
                    <p><strong>내용:</strong> ${rv.comment}</p>

                    <!-- 이미지 슬라이더 영역 -->
                    <c:if test="${not empty rv.imageUrl}">
                        <div class="review-slider-container">
                            <div class="review-slider-inner">
                                <c:forEach var="img" items="${rv.imageUrl}">
                                    <div class="slider-image-wrapper">
                                        <img src="/imgs/${img}" class="slider-image" />
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
            <c:if test="${empty review}">
                <p class="text-muted">아직 등록된 리뷰가 없습니다.</p>
            </c:if>
        </div>
    </div>

</div>

<!-- 사진 전체 보기 모달 -->
<div class="modal fade" id="photoModal" tabindex="-1" role="dialog" aria-labelledby="photoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">사진 전체 보기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <img src="images/blog_1.jpg" class="img-fluid mb-3" alt="전체 대표 이미지">
                <img src="images/blog_1.jpg" class="img-fluid mb-3" alt="전체 서브 이미지1">
                <img src="images/blog_1.jpg" class="img-fluid mb-3" alt="전체 서브 이미지2">
                <img src="images/blog_1.jpg" class="img-fluid mb-3" alt="전체 서브 이미지3">
                <img src="images/blog_1.jpg" class="img-fluid mb-3" alt="전체 서브 이미지4">
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/offers_custom.js"></script>
<script src="js/darkmode.js"></script>