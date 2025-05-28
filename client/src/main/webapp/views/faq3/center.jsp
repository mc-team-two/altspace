<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<head>
    <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
    <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
    <link rel="stylesheet" type="text/css" href="styles/darkmode.css">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/chatbot.css"/>">

    <style>
        /* 이미지 반응형 및 가운데 정렬 스타일 */
        .faq_etc_image img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        /* 이미지 컨테이너 간격 */
        .faq_etc_image {
            margin-top: 100px;
            margin-bottom: 50px;
        }

        /* 각 FAQ 항목 사이의 간격 */
        .faq_etc {
            margin-bottom: 50px;
        }
    </style>
</head>

<body>

<div class="menu trans_500">
    <div class="menu_content d-flex flex-column align-items-center justify-content-center text-center">
        <div class="menu_close_container">
            <div class="menu_close"></div>
        </div>
        <div class="logo menu_logo"><a href="/"><img src="images/logo.png" alt=""></a></div>
        <ul>
            <li class="menu_item"><a href="<c:url value="/"/> ">홈</a></li>
            <li class="menu_item"><a href="<c:url value="/about"/> ">Altspace란</a></li>
            <li class="menu_item"><a href="<c:url value="/faq1"/> ">고객센터/FAQ</a></li>
            <li class="menu_item"><a href="<c:url value="/mypage/aireport"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>

<!-- 배너 -->

<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll"
         data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">기타 FAQ</div>
    </div>
</div>

<!-- 예약 -->

<div class="faq">
    <div class="container">
        <div class="row">

            <!-- 예약 FAQ -->

            <div class="col-lg-8">
                <div class="faq_contents_area">

                    <!-- 질문 1 -->

                    <div class="faq_etc">
                        <div class="faq_etc_image">
                            <img src="images/faq_etc_1.JPG">
                        </div>
                        <div class="faq_etc_title"><h3>리뷰 작성을 하고 싶어요.</h3></div>
                        <div class="faq_etc_text">
                            <p>마이페이지 > 결제 정보 > 리뷰 작성을 통해 작성하실 수 있습니다. 이후 작성한 리뷰는 마이페이지 > 나의 리뷰 에서 확인하실 수 있습니다.</p>
                        </div>
                    </div>

                    <!-- 질문 2 -->

                    <div class="faq_etc">
                        <div class="faq_etc_image">
                            <img src="images/faq_etc_2.JPG">
                        </div>
                        <div class="faq_etc_title"><h3>자세한 문의 사항이나 분쟁 사항이 발생했어요.</h3></div>
                        <div class="faq_etc_text">
                            <p>상단 메뉴의 'Altspace란' 페이지에 접속하시면 다양한 연락 채널이 표기되어 있습니다.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 챗봇 -->

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
            <!-- 사이드바 -->

            <div class="col-lg-4 sidebar_col">
                <div class="position-sticky" style="top: 100px; z-index: 10;">
                    <!-- 사이드바 메뉴 -->
                    <div class="sidebar_archives" style="margin-left: 100px;">
                        <div class="sidebar_title">MENU</div>
                        <div class="sidebar_list">
                            <ul>
                                <li><a href="<c:url value="/faq1"/> ">홈 FAQ</a></li>
                                <li><a href="<c:url value="/faq2"/> ">예약 FAQ</a></li>
                                <li><a href="<c:url value="/faq3"/> ">기타 FAQ</a></li>
                                <li><a href="<c:url value="/contacts"/> ">고객센터 문의</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/offers_custom.js"></script>
<script src="js/darkmode.js"></script>
<script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/> "></script>
<script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/> "></script>
