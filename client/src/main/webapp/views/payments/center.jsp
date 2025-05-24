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
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/about_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/payment_styles.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">
    <style>
        /* 번역 버튼 */
        .btn-custom-small {
            padding: 15px 45px;
            font-size: 1rem;
            width: auto;
            min-width: 0;
            border-radius: 8px;
            margin-left: auto;
        }

        .translate-select-wrapper {
            display: inline-block; /* 혹은 flex-container 안이면 flex로 설정 */
            position: relative;
            margin-left: auto;
            margin-top: 8px;
            text-align: right; /* 오른쪽 정렬 */
        }

        .translate-lang-select {
            display: inline-block;
            font-size: 0.9rem;
            padding: 8px 10px 8px 28px;
            border: 1px solid #0d6efd;
            color: #0d6efd;
            border-radius: 50rem;
            background-color: white;
            transition: all 0.2s ease;
            box-shadow: 0 0 5px rgba(13, 110, 253, 0.15);
            background-position: right 12px center; /* 화살표 위치 */
        }

        .translate-lang-select:focus {
            border-color: #0b5ed7;
            box-shadow: 0 0 6px rgba(13, 110, 253, 0.35);
        }

        .translate-lang-select:hover {
            background-color: #f0f8ff;
        }

        .translate-icon {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #0d6efd;
            font-size: 0.9rem;
            pointer-events: none;
        }

        /* 이미지 슬라이드 */
        .review-slider-wrapper {
            position: relative;
            width: 100%;
            overflow: hidden;
            margin: 1rem 0;
        }

        .review-slider-container {
            overflow: hidden;
        }

        .review-slider-inner {
            display: flex;
            gap: 10px;
            transition: scroll-left 0.4s ease-in-out;
            scroll-behavior: smooth;
        }

        .slider-image-wrapper {
            flex: 0 0 auto;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .slider-image {
            height: 180px;
            display: block;
            object-fit: cover;
            border-radius: 12px;
        }

        /* 버튼 기본 숨김 처리 */
        .arrow {
            width: 36px;               /* 정사각형 너비 */
            height: 36px;              /* 정사각형 높이 */
            border-radius: 50%;        /* 완전한 원 */
            font-size: 20px;
            background-color: rgba(0, 0, 0, 0.2);
            color: rgba(255, 255, 255, 0.5);
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            cursor: pointer;
            z-index: 10;
            display: none;
            transition: all 0.3s ease;
        }

        .arrow:hover {
            background-color: rgba(0, 0, 0, 0.6);  /* hover 시 더 진한 배경 */
            color: rgba(255, 255, 255, 0.95);      /* hover 시 글자 색 선명 */
        }

        .left-arrow {
            left: 10px;
        }

        .right-arrow {
            right: 10px;
        }

        .slider-fade {
            position: absolute;
            top: 0;
            width: 50px;
            height: 100%;
            z-index: 5;
            pointer-events: none;
            display: none; /* 기본은 숨김 */
        }

        .left-fade {
            left: 0;
            background: linear-gradient(to right, rgba(255,255,255,1), rgba(255,255,255,0));
        }

        .right-fade {
            right: 0;
            background: linear-gradient(to left, rgba(255,255,255,1), rgba(255,255,255,0));
        }


        .viewing-info {
            color: #d9534f;          /* 부드러운 빨간색 (부트스트랩 danger 톤) */
            font-weight: bold;
            background-color: rgba(255, 0, 0, 0.05); /* 은은한 빨간 배경 */
            padding: 0.5rem 1rem;
            border-radius: 4px;
            margin-top: 0.5rem;
            font-size: 1rem;         /* 적당한 크기 */
            transition: opacity 0.3s;

        /* 모달 */
        .text-truncate-multiline {
            display: -webkit-box;
            -webkit-line-clamp: 7;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .accomm-notice-text {
            font-size: 1rem;
            line-height: 1.4;
        }

        .modal-title {
            font-size: 1.6rem; /* 제목 크게 */
            font-weight: 700;

        }
    </style>
</head>
<body>
<script>
    const translateOptionsText = {
        "ko": {
             placeholder: "번역",
            ko: "한국어",
            en: "영어",
            "zh-CN": "중국어",
            ja: "일본어"
        },
        "en": {
            placeholder: "Translate",
            ko: "Korean",
            en: "English",
            "zh-CN": "Chinese",
            ja: "Japanese"
        },
        "zh-CN": {
            placeholder: "翻译",
            ko: "韩语",
            en: "英语",
            "zh-CN": "中文",
            ja: "日语"
        },
        "ja": {
            placeholder: "翻訳",
            ko: "韓国語",
            en: "英語",
            "zh-CN": "中国語",
            ja: "日本語"
        }
    };
    const change = {
        updateSelectOptionsText: function ($select, lang) {
            const labels = translateOptionsText[lang];
            if (!labels) return;

            $select.find('option').each(function () {
                const val = $(this).val();
                if (!val) {
                    $(this).text(labels.placeholder);
                } else {
                    $(this).text(labels[val] || val);
                }
            });
        },
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
                const userId = '${sessionScope.user.userId}';
                if (!userId || userId.trim() === '') {
                    alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.');
                    location.href = '/login';
                    return;
                }
                // 로그인 되어 있으면 결제 요청 함수 실행
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
            $('.translate-lang-select').change(function() {
                const $select = $(this);
                const selectedLang = $select.val();

                change.translate.call(this); // 번역 실행
                change.updateSelectOptionsText($select, selectedLang); // 옵션 텍스트도 변경
            });
            $('#summaryBtn').click(function() {
                change.reviewSummary.call(this);
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
            if (!confirm("정말로 결제를 취소하시겠습니까?")) {
                return; // 사용자가 취소를 원하지 않으면 함수 종료
            }

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
                    location.href = '/details';
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

            // 지도 컨트롤
            var mapTypeControl = new kakao.maps.MapTypeControl();
            this.map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            var zoomControl = new kakao.maps.ZoomControl();
            this.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            // 숙소 마커 표시
            var markerPosition = new kakao.maps.LatLng(${accomm.latitude}, ${accomm.longitude});
            this.marker = new kakao.maps.Marker({
                position: markerPosition,
                image: new kakao.maps.MarkerImage(
                    '/images/markers/accomMaker.png', // 집 아이콘
                    new kakao.maps.Size(64, 64), // 큼직하게
                    { offset: new kakao.maps.Point(32, 64) } // 중앙 하단 꼭짓점이 위치
                )
            });
            this.marker.setMap(this.map);

            // 장소 검색 서비스 사용
            var ps = new kakao.maps.services.Places();

            // 중심 좌표 기준 음식점 검색
            var lat = ${accomm.latitude};
            var lng = ${accomm.longitude};
            var loc = new kakao.maps.LatLng(lat, lng);

            ps.categorySearch('FD6', function (data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    for (var i = 0; i < data.length; i++) {
                        displayRestaurantMarker(data[i]);
                    }
                }
            }, {
                location: loc,
                radius: 2000 // 2000미터 반경
            });

            const displayRestaurantMarker = (place) => {
                // 마커 이미지 설정
                const imageSrc = '/images/markers/RestaurantMaker.png'; // 음식점 아이콘
                const imageSize = new kakao.maps.Size(48, 48); // 작게 표시
                const imageOption = {
                    offset: new kakao.maps.Point(20, 40) // 꼭짓점이 아래로 향하도록
                };

                const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

                const marker = new kakao.maps.Marker({
                    map: this.map,
                    position: new kakao.maps.LatLng(place.y, place.x),
                    title: place.place_name,
                    image: markerImage
                });

                // 마커에 간단한 인포윈도우 추가
                const infowindow = new kakao.maps.InfoWindow({
                    content: `<div style="padding:5px;font-size:12px;">${place.place_name}</div>`
                });

                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    infowindow.open(this.map, marker);
                });
                kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                });
            }
        },
        wishlistToggle: function() {
            const accommId = parseInt("${accomm.accommodationId}");
            const wishlistIdStr = $(".wishlist-btn").data("wishlist-id"); // data-wishlist-id 값 가져오기
            const wishlistId = wishlistIdStr ? parseInt(wishlistIdStr) : null;

            const isWished = $(".wishlist-btn").hasClass("btn-danger"); // 이미 찜한 상태인지 확인

            if(isWished) {
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
                    success: function(response) {
                        if (response.success) {
                            alert("찜 목록에서 취소되었습니다.");
                            $(".wishlist-btn")
                                .removeClass("btn-danger")
                                .addClass("btn-outline-danger")
                                .html('<i class="bi bi-heart"></i> 찜');
                            location.reload(); // 페이지 새로고침

                        } else {
                            alert("찜 삭제에 실패했습니다.");
                        }
                    },
                    error: function() {
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
                    success: function(response) {
                        if (response.success) {
                            alert("찜 목록에 추가되었습니다!");
                            // 버튼 UI 변경
                            $(".wishlist-btn")
                                .removeClass("btn-outline-danger")
                                .addClass("btn-danger")
                                .html('<i class="bi bi-heart-fill"></i> 찜');
                            location.reload(); // 페이지 새로고침

                        } else {
                            alert("이미 찜한 숙소입니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("찜 추가에 실패했습니다. 다시 시도해주세요.");
                        console.error("Error:", error);
                    }
                });
            }
        },
        translate: function(){
            const $select = $(this);
            const reviewId = $select.data('review-id');
            const selectedLang = $select.val();
            const originalText = $select.data('original');
            const $comment = $('.review-comment[data-review-id="' + reviewId + '"]');

            if (selectedLang === 'ko') {
                $comment.text(originalText);
                return;
            }

            $.ajax({
                type: 'POST',
                url: '/review/translate',
                contentType: 'application/json',
                data: JSON.stringify({ msg: originalText, target: selectedLang }),
                success: function (translatedText) {
                    $comment.text(translatedText);
                },
                error: function () {
                    alert('번역 중 오류가 발생했습니다.');
                }
            });
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
    const rvImg = {
        initSlider: function () {
            $('.review-slider-wrapper').each(function () {
                const $wrapper   = $(this);
                const $container = $wrapper.find('.review-slider-container');
                const $leftBtn   = $wrapper.find('.left-arrow');
                const $rightBtn  = $wrapper.find('.right-arrow');
                const $leftFade  = $wrapper.find('.left-fade');
                const $rightFade = $wrapper.find('.right-fade');

                // 스크롤 위치를 보고 fade & 버튼을 토글하는 함수
                const updateFade = () => {
                    const scrollLeft    = $container.scrollLeft();
                    const maxScrollLeft = $container[0].scrollWidth - $container.outerWidth();

                    // 왼쪽
                    if (scrollLeft > 5) {
                        $leftFade.fadeIn();   // fade 효과 보이기
                        $leftBtn.fadeIn();    // 버튼 보이기
                    } else {
                        $leftFade.fadeOut();  // fade 효과 숨기기
                        $leftBtn.fadeOut();   // 버튼 숨기기
                    }

                    // 오른쪽
                    if (scrollLeft < maxScrollLeft - 5) {
                        $rightFade.fadeIn();
                        $rightBtn.fadeIn();
                    } else {
                        $rightFade.fadeOut();
                        $rightBtn.fadeOut();
                    }
                };

                // 1) 초기 상태에서 한 번 실행
                updateFade();

                // 2) 버튼 클릭 시 스크롤 + 상태 업데이트
                $leftBtn.on('click', function () {
                    $container.animate(
                        { scrollLeft: '-=300' },
                        400,
                        updateFade
                    );
                });
                $rightBtn.on('click', function () {
                    $container.animate(
                        { scrollLeft: '+=300' },
                        400,
                        updateFade
                    );
                });

                // 3) 사용자가 직접 스크롤해도 상태 업데이트
                $container.on('scroll', updateFade);

                // 4) 창 크기 바뀌어도 상태 업데이트
                $(window).on('resize', updateFade);
            });
        }
    };

    $(document).ready(function () {
        change.init();
        rvImg.initSlider();
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
    <div id="viewing-info" class="viewing-info" style="color: red; font-weight: bold;"></div>
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

    <div class="row mb-2">
        <!-- 호스트 카드 + 상세 설명 -->
        <div class="col-md-8 mb-2">
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
            <div class="card shadow-sm p-4 rounded-4 position-relative" style="min-height: 250px;">
                <div id="accommNotice" class="text-truncate-multiline accomm-notice-text" style="white-space: pre-line;">
                    ${accomm.notice}
                </div>
                <button class="btn btn-link p-0 mt-2" onclick="$('#noticeModal').modal('show')">더보기</button>
            </div>
            <!-- 모달 -->
            <div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content rounded-4">
                        <div class="modal-header">
                            <h5 class="modal-title" id="noticeModalLabel">숙소 설명</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body accomm-notice-text" style="white-space: pre-line; max-height: 70vh; overflow-y: auto;">
                            <c:out value="${accomm.notice}" escapeXml="false" />
                        </div>
                    </div>
                </div>
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
                                                                          type="number"/></span> / 박
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
                        <div class="review-slider-wrapper me-3" style="flex: 1 1 400px; max-width: 100%;">
                            <div class="slider-fade left-fade"></div>
                            <button class="arrow left-arrow">&#10094;</button>

                            <!-- 기존 컨테이너 -->
                            <div class="review-slider-container">
                                <div class="review-slider-inner">
                                    <c:forEach var="img" items="${rv.imageUrl}">
                                        <div class="slider-image-wrapper">
                                            <img src="/imgs/${img}" class="slider-image"/>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="slider-fade right-fade"></div>
                            <button class="arrow right-arrow">&#10095;</button>
                        </div>
                    </c:if>
                </div>

                <!-- 번역 셀렉트 -->
                <div class="d-flex justify-content-end w-100 mb-2">
                    <div class="translate-select-wrapper position-relative">
                        <i class="fa fa-globe position-absolute translate-icon" aria-hidden="true"></i>
                        <select class="form-select form-select-sm translate-lang-select"
                                data-review-id="${rv.reviewId}"
                                data-original="${rv.comment}">
                            <option value="" selected disabled hidden>번역</option>
                            <option value="ko">한국어</option>
                            <option value="en">영어</option>
                            <option value="zh-CN">중국어</option>
                            <option value="ja">일본어</option>
                        </select>
                    </div>
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

<div id="chatbot" class="chatbot">
    <div id="chat-icon" class="chat-icon">
        <i class="fas fa-comments" aria-hidden="true"></i>
    </div>
    <div id="chat-window" class="chat-window">
        <div class="chat-header">
            <span>챗봇과 대화하기</span>
            <button id="chat-close-btn" class="chat-close-btn">&times;</button>
        </div>
        <div class="chat-messages" id="chat-messages">

        </div>
        <div class="chat-input">
            <input type="text" id="chat-input" placeholder="메세지를 입력해주세요">
            <button id="chat-send-btn">보내기</button>
        </div>
    </div>
</div>
<div id="gemini-chatbot" class="chatbot chatbot-gemini">
    <div id="gemini-chat-icon" class="chat-icon gemini-icon">
        <i class="fab fa-android" aria-hidden="true"></i>
    </div>
    <div id="gemini-chat-window" class="chat-window gemini-window">
        <div class="chat-header gemini-header">
            <span>Gemini 챗봇</span>
            <button id="gemini-chat-close-btn" class="chat-close-btn">&times;</button>
        </div>
        <div class="chat-messages" id="gemini-chat-messages"></div>
        <div class="chat-input">
            <input type="text" id="gemini-chat-input" placeholder="Gemini에게 물어보세요">
            <button id="gemini-chat-send-btn">보내기</button>
        </div>
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
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
<script src="<c:url value="js/viewing.js"/>"></script>


