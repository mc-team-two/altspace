<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/blog_styles.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/blog_responsive.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='styles/darkmode.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='plugins/font-awesome-4.7.0/css/font-awesome.min.css'/>">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>

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
</style>
<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value='/'/>">홈</a></li>
            <li class="menu_item"><a href="<c:url value='/about'/>">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value='/contacts'/>">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value='/mypage/aireport'/>">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 영역 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">마이 페이지</div>
    </div>
</div>

<div class="blog">
    <div class="container">
        <div class="row">
            <!-- 왼쪽 본문 영역 -->
            <div class="col-lg-8 items_4css">
                <div class="single_listing"
                     style="margin-top: 0 !important; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.05);">
                    <h2 class="mb-4">회원 탈퇴</h2>
                    <p class="mb-3 text-danger"><strong>⚠️ 탈퇴 시, 복구할 수 없습니다. 정말 탈퇴하시겠습니까?</strong></p>

<%--                    소셜 로그인 이용자를 패스워드 유무로 확인.--%>
                    <c:choose>
                        <c:when test="${empty user.password}">
                            <form id="deleteSocialAccountForm" method="post"
                                  action="<c:url value='/mypage/delete-account'/>">
                                <input type="hidden" name="confirmPassword" value="social-user">
                                <button type="submit" class="btn btn-danger">탈퇴 확인</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form id="deleteAccountForm">
                                <input type="password" name="confirmPassword" placeholder="비밀번호 입력" required
                                       class="mb-3"><br>
                                <button type="submit" class="btn btn-danger">회원 탈퇴</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 오른쪽 사이드바 -->
            <div class="col-lg-4 sidebar_list4css">
                <div class="sidebar_archives">
                    <div class="sidebar_title">MENU</div>
                    <div class="sidebar_list">
                        <ul>
                            <li><a href="<c:url value='/details'/>">나의 예약</a></li>
                            <li><a href="<c:url value='/review'/>">나의 리뷰</a></li>
                            <li><a href="<c:url value='/wishlist'/>">찜 목록</a></li>
                            <li><a href="<c:url value='/mypage/aireport'/>">AI 분석</a></li>
                            <li class="has-submenu">
                                <a href="javascript:void(0)">나의 정보 <i class="fa fa-chevron-down ms-1"></i></a>
                                <ul class="submenu">
                                    <li><a href="<c:url value='/mypage'/>">내 정보</a></li>
                                    <li><a href="<c:url value='/mypage/modify-info'/>">내 정보 수정</a></li>
                                    <li><a href="<c:url value='/mypage/reset-password'/>">비밀번호 재설정</a></li>
                                    <li><a href="<c:url value='/mypage/delete-account'/>">회원 탈퇴</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 챗봇 영역 -->

<div id="chatbot" class="chatbot">
    <div id="chat-icon" class="chat-icon">
        <i class="fas fa-comments" aria-hidden="true"></i>
    </div>
    <div id="chat-window" class="chat-window">
        <div class="chat-header">
            <span><spring:message code="chat-header"/></span>
            <button id="chat-close-btn" class="chat-close-btn">&times;</button>
        </div>
        <div class="chat-messages" id="chat-messages">

        </div>
        <div class="chat-input">
            <input type="text" id="chat-input" placeholder="<spring:message code="chat-input"/>">
            <button id="chat-send-btn"><spring:message code="chat-send-btn"/></button>
        </div>
    </div>
</div>
<div id="gemini-chatbot" class="chatbot chatbot-gemini">
    <div id="gemini-chat-icon" class="chat-icon gemini-icon">
        <i class="fab fa-google" aria-hidden="true"></i>
    </div>
    <div id="gemini-chat-window" class="chat-window gemini-window">
        <div class="chat-header gemini-header">
            <span><spring:message code="gemini-header"/></span>
            <button id="gemini-chat-close-btn" class="chat-close-btn">&times;</button>
        </div>
        <div class="chat-messages" id="gemini-chat-messages"></div>
        <div class="chat-input">
            <input type="text" id="gemini-chat-input" placeholder="<spring:message code="gemini-chat-input"/>">
            <button id="gemini-chat-send-btn"><spring:message code="gemini-chat-send-btn"/></button>
        </div>
    </div>
</div>
<script src="<c:url value='/js/jquery-3.2.1.min.js'/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="<c:url value='/styles/bootstrap4/popper.js'/>"></script>
<script src="<c:url value='/styles/bootstrap4/bootstrap.min.js'/>"></script>
<script src="<c:url value='/plugins/Isotope/isotope.pkgd.min.js'/>"></script>
<script src="<c:url value='/plugins/easing/easing.js'/>"></script>
<script src="<c:url value='/plugins/parallax-js-master/parallax.min.js'/>"></script>

<script src="<c:url value='/js/custom.js'/>"></script>
<script src="<c:url value='/js/darkmode.js'/>"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const submenuToggles = document.querySelectorAll(".has-submenu > a");
        submenuToggles.forEach(function (toggle) {
            toggle.addEventListener("click", function () {
                this.parentElement.classList.toggle("active");
            });
        });
    });
</script>

<script>
        // 🔴 소셜 회원 탈퇴
        const deleteSocialBtn = document.getElementById("deleteSocialAccountBtn");
        if (deleteSocialBtn) {
            deleteSocialBtn.addEventListener("click", function () {
                if (confirm("정말 탈퇴하시겠습니까?")) {
                    fetch("<c:url value='/api/auth/del'/>", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: new URLSearchParams({
                            id: "${user.userId}"
                        })
                    }).then(response => response.text())
                        .then(msg => {
                            alert(msg);
                            window.location.href = "/";
                        }).catch(error => {
                        console.error(error);
                        alert("오류가 발생했습니다. 다시 시도해 주세요.");
                    });
                }
            });
        }

        // 🔴 일반 회원 탈퇴
        const deleteBtn = document.getElementById("deleteAccountBtn");
        if (deleteBtn) {
            deleteBtn.addEventListener("click", function () {
                const pwd = document.getElementById("confirmPassword").value.trim();
                if (!pwd) {
                    alert("비밀번호를 입력하세요!");
                    return;
                }
                if (confirm("정말 탈퇴하시겠습니까?")) {
                    fetch("<c:url value='/api/auth/del'/>", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: new URLSearchParams({
                            id: "${user.userId}"
                        })
                    }).then(response => response.text())
                        .then(msg => {
                            alert(msg);
                            window.location.href = "/";
                        }).catch(error => {
                        console.error(error);
                        alert("오류가 발생했습니다. 다시 시도해 주세요.");
                    });
                }
            });
        }
    });
</script>