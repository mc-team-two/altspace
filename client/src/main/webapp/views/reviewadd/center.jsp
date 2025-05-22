<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!doctype html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="<c:url value="styles/blog_styles.css"/>">
    <link rel="stylesheet" href="<c:url value="styles/blog_responsive.css"/>">
    <link rel="stylesheet" href="<c:url value="styles/darkmode.css"/>">
    <!-- Google Fonts - 감성 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">

    <style>
        .star-rating {
            direction: rtl;
            display: inline-flex;
            font-size: 2rem;
            justify-content: center;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s;
        }

        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #00c9a7;
        }

        .custom-textarea {
            border: 2px solid #dcdcdc;
            border-radius: 10px;
            box-shadow: none;
            padding: 1rem;
        }

        .custom-btn-purple {
            background-color: #7c4dff;
            color: #fff;
            border: none;
        }

        .custom-btn-purple:hover {
            background-color: #854dff;
        }

        .review-box {
            max-width: 640px; /* 또는 720px */
            margin: auto;
            animation: fadeIn 0.8s ease-in-out;
            border-radius: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
        }
    </style>

</head>
<body>
<script>
    const change = {
        init: function () {

            $('#review_btn').click(()=>{
                this.review();
            });
        },
        review:function(){
            const grade = $('input[name="grade"]:checked').val();
            const comment = $('#comment').val();

            if (!grade || !comment) {
                alert("별점과 리뷰를 모두 작성해주세요.");
                return;
            }

            $('#data_add').attr({
                'method':'post',
                'action':'<c:url value="/review/reviewUpload?id=${accomm.accommodationId}"/>'
            });
            $('#data_add').submit();
        }
    }
    $(document).ready(function () {
        change.init();
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
            <li class="menu_item"><a href="<c:url value="/details"/> ">마이페이지</a></li>
        </ul>
    </div>
</div>
<!-- 홈 -->
<div class="home">
    <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/offer_background.jpg"></div>
    <div class="home_content">
        <div class="home_title">여행의 추억, 지금 남겨보세요</div>
    </div>
</div>

<!-- 센터 -->
<div class="container mt-5 mb-5">
    <div class="card p-4 review-box mx-auto">

        <!-- 숙소 정보 -->
        <div class="mb-3 text-center">
            <h2 class="font-weight-bold mb-1">${accomm.name}</h2>
            <h5 class="text-muted mb-2">${accomm.location}</h5>
        </div>

        <form id="data_add" enctype="multipart/form-data">
            <input type="hidden" name="accommodationId" value="${accomm.accommodationId}">
            <input type="hidden" name="guestId" value="${sessionScope.user.userId}">

            <!-- 작성자 이름 -->
            <div class="mb-4 text-center">
                <p class="mb-0 text-dark font-weight-bold" style="font-size: 1rem;">작성자</p>
                <p class="font-weight-bold" style="font-size: 1.2rem;">${sessionScope.user.name}</p>
            </div>

            <!-- 별점 -->
            <div class="mb-4 text-center">
                <label class="font-weight-bold d-block mb-2">별점 등록</label>
                <div class="star-rating d-inline-flex">
                    <input type="radio" id="star5" name="grade" value="5"><label for="star5">★</label>
                    <input type="radio" id="star4" name="grade" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="grade" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="grade" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="grade" value="1"><label for="star1">★</label>
                </div>
            </div>

            <!-- 리뷰 내용 -->
            <div class="mb-4">
                <label for="comment" class="font-weight-bold">리뷰</label>
                <textarea class="form-control custom-textarea" id="comment" name="comment" rows="4"
                          placeholder="리뷰를 작성해주세요" required></textarea>
            </div>

            <!-- 이미지 업로드 -->
            <div class="mb-4">
                <label for="image" class="font-weight-bold">이미지 업로드</label>
                <input type="file" class="form-control-file" id="image" name="images" multiple>
            </div>

            <c:if test="${not empty errorMessage}">
                <script>
                    alert(`${errorMessage}`);
                </script>
            </c:if>
        </form>

        <!-- 등록 버튼 -->
        <div class="d-flex justify-content-between">
            <button class="btn custom-btn-purple px-4 ml-auto" id="review_btn">등록</button>
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
</div>

</body>
</html>

<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/offers_custom.js"></script>