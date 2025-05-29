<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="plugins/font-awesome-4.7.0/css/font-awesome.min.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">
    <script src="<c:url value="js/jquery-3.2.1.min.js"/>"></script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJSApiKey}&libraries=services"></script>
<style>
    .submenu {
        display: none;
        margin-top: 6px; /* 상단 여백 추가 */
        padding-left: 18px; /* 좌측 들여쓰기 */
        padding-top: 6px; /* 내부 위쪽 여백 */
        list-style-type: circle;
        font-size: 14px;
        color: #555;
    }

    .submenu li {
        margin: 6px 0; /* 각 항목 간 간격 */
    }

    .has-submenu > a {
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 5px 0;
    }

    .has-submenu.active > .submenu {
        display: block;
        animation: slideDown 0.3s ease;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-5px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @media (min-width: 992px) {
        .pl-lg-5 {
            padding-left: 5rem !important; /* 간격 확보 */
        }
    }

    .sidebar-link {
        display: flex;
        align-items: center;
        gap: 10px; /* 아이콘과 텍스트 간격 */
        font-size: 16px;
        color: #333;
        text-decoration: none;
        transition: all 0.2s ease-in-out;
    }

    .sidebar-link:hover {
        color: #007bff;
        transform: translateX(4px);
    }

    .sidebar-link i {
        font-size: 16px;
        width: 20px; /* 아이콘 영역 고정 */
        text-align: center;
    }

    /* 나의 정보 라인도 동일하게 맞추기 */
    .has-submenu > .sidebar-link {
        justify-content: space-between;
        padding-right: 8px; /* 드롭다운 아이콘 여유 공간 */
    }

    /* 드롭다운 아이콘 위치 조정 */
    .has-submenu .fa-chevron-down {
        margin-left: auto;
        font-size: 12px;
    }
</style>
</head>
<script>
    const change = {
        init: function () {
            // 모달 버튼 클릭 이벤트 위임
            $(document).on('click', '.payment-modal-btn', (e) => {
                this.paymentModal(e);
            });
        },

        paymentModal: function (e) {
            const $btn = $(e.currentTarget);
            const id = $btn.data('id');
            const status = $btn.data('status');
            const paymentId = $btn.data('payment-id');

            $('#paymentModalBody').html('<div class="text-center text-muted py-5">불러오는 중...</div>');

            $.ajax({
                url: '/details/payment/modal',
                method: 'GET',
                data: { id, pyStatus: status, paymentId },
                success: function (data) {
                    $('#paymentModalBody').html(data);

                    $('#review_btn').off().on('click', function () {
                        const accommId = $('#data_del input[name="accommodationId"]').val();
                        $('#data_del').attr({
                            method: 'post',
                            action: '/reviewAdd?id=' + accommId
                        }).submit();
                    });

                    $('#cancel_btn').off().on('click', function () {
                        const impUid = $('#data_del input[name="impUid"]').val();
                        if (!impUid) {
                            alert("결제 내역이 없습니다.");
                            return;
                        }

                        if (!confirm("정말로 결제를 취소하시겠습니까?")) return;

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
                                try {
                                    const errorMsg = JSON.parse(err.responseText).message;
                                    alert("취소 실패: " + errorMsg);
                                } catch (e) {
                                    alert("취소 실패: 알 수 없는 오류");
                                }
                            }
                        });
                    });

                    $('#paymentModal').modal('show');
                },
                error: function () {
                    $('#paymentModalBody').html('<div class="text-danger text-center py-5">불러오기 실패</div>');
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
            <li class="menu_item"><a href="<c:url value="/faq1"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/mypage/aireport"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">나의 예약</div>
    </div>
</div>

<!-- 센터 -->
<div class="blog">
    <div class="container">
        <div class="row align-items-start" style="min-height: 100vh;">

            <!-- 예약 내역 (왼쪽 8열) -->
            <div class="col-lg-8">
                <c:choose>
                    <c:when test="${empty paymentList}">
                        <div class="card mb-6 p-4 shadow-sm text-center item_none">
                            <img src="images/avatar.png" alt="여행을 계획하러 가볼까요?" class="img-fluid mb-3"
                                 style="max-width: 120px;">
                            <h5 class="mb-1 font-weight-bold text-dark">아직 예약을 하지 않았어요!</h5>
                            <p class="text-muted mb-0">여행을 계획하러 가볼까요?</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="py" items="${paymentList}">
                                <div class="col-md-6 mb-4">
                                    <div class="card shadow-sm h-100 offers_item">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">${py.name}</h5>
                                        </div>
                                        <img src="/imgs/${py.image1Name}"
                                             class="card-img-top" alt="숙소 이미지"
                                             style="height: 200px; object-fit: cover;">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between mb-2" style="margin-top: -5px;">
                                                <span class="badge bg-info text-dark" style="font-size: 0.85rem;">
                                                  결제 상태: ${py.payStatus}
                                                </span>
                                                <span style="font-size: 0.85rem; color: black;">
                                                  체크인: ${py.checkIn}
                                                </span>
                                            </div>
                                            <div class="d-flex flex-column gap-1">
                                                <a class="btn btn-outline-secondary btn-sm"
                                                   href="<c:url value='/detail?id=${py.accommodationId}'/>">숙소 정보</a>
                                                <button class="btn btn-outline-primary btn-sm payment-modal-btn"
                                                        data-id="${py.accommodationId}"
                                                        data-status="${py.payStatus}"
                                                        data-payment-id="${py.paymentId}">
                                                    결제 정보
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 사이드바 (오른쪽 4열) -->
            <div class="col-lg-4">
                <div class="position-sticky sidebar_list4css" style="top: 100px; z-index: 10;">
                    <div class="sidebar_archives" style="margin-left: 100px;">
                        <div class="sidebar_title" style="font-size: 20px; font-weight: bold; margin-bottom: 20px;">MENU</div>
                        <div class="sidebar_list">
                            <ul style="list-style: none; padding-left: 0;">
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/details'/>" class="sidebar-link">
                                        <i class="fas fa-calendar-check"></i>
                                        <span>나의 예약</span>
                                    </a>
                                </li>
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/review'/>" class="sidebar-link">
                                        <i class="fas fa-star"></i>
                                        <span>나의 리뷰</span>
                                    </a>
                                </li>
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/wishlist'/>" class="sidebar-link">
                                        <i class="fas fa-heart"></i>
                                        <span>찜 목록</span>
                                    </a>
                                </li>
                                <li style="margin-bottom: 12px;">
                                    <a href="<c:url value='/mypage/aireport'/>" class="sidebar-link">
                                        <i class="fas fa-robot"></i>
                                        <span>AI 분석</span>
                                    </a>
                                </li>
                                <li class="has-submenu" style="margin-bottom: 12px;">
                                    <a href="javascript:void(0)" class="sidebar-link" style="display: flex; justify-content: space-between; align-items: center;">
                                        <span style="display: flex; align-items: center; gap: 10px;">
                                            <i class="fas fa-user"></i>
                                            나의 정보
                                        </span>
                                        <i class="fa fa-chevron-down"></i>
                                    </a>
                                    <ul class="submenu" style="padding-left: 20px; margin-top: 10px;">
                                        <li><a href="<c:url value='/mypage'/>">📄 내 정보</a></li>
                                        <li><a href="<c:url value='/mypage/modify-info'/>">✏️ 내 정보 수정</a></li>
                                        <li><a href="<c:url value='/mypage/reset-password'/>">🔒 비밀번호 재설정</a></li>
                                        <li><a href="<c:url value='/mypage/delete-account'/>">⛔ 회원 탈퇴</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div> <!-- row 끝 -->
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
                <i class="fab fa-google" aria-hidden="true"></i>
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
    </div>
</div>
<!-- 결제 정보 모달 -->
<div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
        <div class="modal-content rounded-lg shadow">
            <!-- 헤더 -->
            <div class="modal-header bg-primary text-white rounded-top">
                <h5 class="modal-title font-weight-bold mb-0">
                    <i class="fa fa-credit-card mr-2"></i> 예약 상세 정보
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" style="font-size: 1.4rem;">&times;</span>
                </button>
            </div>

            <!-- 본문 -->
            <div class="modal-body py-4 px-4" id="paymentModalBody">
                <div class="text-center text-muted py-5">
                    <div class="fa fa-spinner fa-spin fa-2x mb-3 text-primary"></div>
                    <p class="mb-0">불러오는 중...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="styles/bootstrap4/popper.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/bootstrap.min.js"/>"></script>
<script src="<c:url value="plugins/Isotope/isotope.pkgd.min.js"/>"></script>
<script src="<c:url value="plugins/easing/easing.js"/>"></script>
<script src="<c:url value="plugins/parallax-js-master/parallax.min.js"/>"></script>
<script src="<c:url value="js/offers_custom.js"/>"></script>
<script defer src="<c:url value='js/chatbot.js'/>"></script>
<script src="<c:url value='js/GeminiChatbot.js'/>"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const submenuToggles = document.querySelectorAll(".has-submenu > a");

        submenuToggles.forEach(function (toggle) {
            toggle.addEventListener("click", function () {
                const parent = this.parentElement;
                parent.classList.toggle("active");
            });
        });
    });
</script>