<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/about_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/about_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
    <style>
        /* --- Basic Layout --- */
        .listing {
            padding-top: 50px;
            padding-bottom: 50px;
            background-color: #f8f9fa; /* Light background */
        }

        .container {
            max-width: 960px;
            margin: 0 auto;
            padding: 0 15px;
        }

        .single_listing {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .hotel_info {
            margin-bottom: 20px;
            text-align: center;
        }

        .hotel_title_container {
            margin-bottom: 20px;
        }

        .hotel_title {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 10px;
        }

        .hotel_image img {
            width: 150px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        /* --- User Information Styling --- */
        .hotel_info_text {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
        }

        .user-info-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .user-info-label {
            font-weight: bold;
            color: #555;
            width: 120px; /* Adjust width as needed */
            margin-right: 15px;
        }

        .user-info-value {
            color: #333;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
        }

        .no-update-message {
            color: #777;
        }
    </style>
</head>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container"><div class="menu_close"></div></div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/contacts"/> ">고객센터</a></li>
            <li class="menu_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>

<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="/images/single_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">My Page</div>
    </div>
</div>
<div class="listing">

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="single_listing">

                    <div class="hotel_info">

                        <div class="hotel_title_container d-flex flex-lg-row flex-column">
                            <div class="hotel_title_content">
                                <h1 class="hotel_title">개인 정보</h1>
                            </div>
                        </div>

                        <div class="hotel_image">
                            <img src="/images/avatar.png" alt="User Profile">
                        </div>
                    </div>
                </div>

                <div class="hotel_info_text">
                    <c:if test="${errorMessage != null}">
                        <p class="error-message">${errorMessage}</p>
                    </c:if>

                    <c:if test="${not empty user}">  <%-- user 객체 존재 여부로 분기 --%>
                        <div class="user-info-item">
                            <span class="user-info-label">이메일:</span>
                            <span class="user-info-value">${user.email}</span>
                        </div>
                        <div class="user-info-item">
                            <span class="user-info-label">이름:</span>
                            <span class="user-info-value">${user.name}</span>
                        </div>
                        <div class="user-info-item">
                            <span class="user-info-label">전화번호:</span>
                            <span class="user-info-value">${user.phone}</span>
                        </div>
                        <div class="user-info-item">
                            <span class="user-info-label">가입일:</span>
                            <span class="user-info-value">${user.createDay}</span>
                        </div>
                        <div class="user-info-item">
                            <span class="user-info-label">정보 수정일:</span>
                            <span class="user-info-value">
                                    <c:choose>
                                        <c:when test="${user.updateDay == null}">
                                            <span class="no-update-message">수정 기록 없음</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${user.updateDay}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                        </div>
                    </c:if>
                </div>

            </div>
        </div>
        <div id="chatbot" class="chatbot">
            <div id="chat-icon" class="chat-icon">
                <i class="fa fa-comment" aria-hidden="true"></i>
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
    </div>
</div>

<script src="<c:url value="js/jquery-3.2.1.min.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/popper.js"/>"></script>
<script src="<c:url value="styles/bootstrap4/bootstrap.min.js"/>"></script>
<script src="<c:url value="plugins/Isotope/isotope.pkgd.min.js"/>"></script>
<script src="<c:url value="plugins/easing/easing.js"/>"></script>
<script src="<c:url value="plugins/parallax-js-master/parallax.min.js"/>"></script>
<script src="<c:url value="js/offers_custom.js"/>"></script>

<script src="<c:url value="js/darkmode.js"/>"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
<script src="<c:url value="js/chatbot.js"/>"></script>