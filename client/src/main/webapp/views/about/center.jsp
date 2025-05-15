<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/about_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/about_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">
</head>

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
         data-image-src="images/about_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">알트스페이스란</div>
    </div>
</div>

<!-- Altspace 소개 -->

<div class="intro">
    <div class="container">
        <div class="row">
            <div class="col-lg-7">
                <div class="intro_image"><img src="images/intro.png" alt=""></div>
            </div>
            <div class="col-lg-5">
                <div class="intro_content">
                    <div class="intro_title">Altspace에 오신 것을 환영합니다!</div>
                    <div class="intro_text">
                        Altspace™는 메뉴를 빠르게 여는 Alt + Space 단축키에 간결하게 정리된 레이아웃을 가진 웹사이트를 통해 빠르고 편리한 공간 예약 서비스를 제공하고 있습니다.
                        <p></p>
                        Altspace에서 다양한 호텔 및 리조트는 물론 게스트하우스, 모텔, 파티룸 등 프라이빗한 공간을 안심하고 예약하실 수 있으며 이용 요금, 편의 시설과 서비스,
                        예약 가능 객실, 반려동물 동반 여부 등 등 모든 정보를 한 눈에 확인하실 수 있습니다.
                        <p></p>
                        본 웹사이트는 멀티캠퍼스 2조 운영진이 (이예진, 이황수, 임유경, 박정우, 김부건) 공동 운영합니다. 자세한 문의사항 또는 분쟁의 경우 아래 연락처로 연락 바랍니다.
                        <p></p>
                        02-1234-5678 / 1588-1588 / help.alt@altspace.com
                    </div>
                    <div class="button intro_button">
                        <div class="button_bcg"></div>
                        <a href="/">예약하러 가기<span></span><span></span><span></span></a></div>
                </div>
            </div>
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

<script src="<c:url value="js/darkmode.js"/>"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
<script src="<c:url value="js/chatbot.js"/>"></script>