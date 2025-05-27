<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- jQuery 라이브러리 CDN 추가 (반드시 먼저 위치시켜야 함) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_styles.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/blog_responsive.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="styles/darkmode.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="plugins/font-awesome-4.7.0/css/font-awesome.min.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css"/>">
    <link rel="stylesheet"
          href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>">

    <style>
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
            width: 36px; /* 정사각형 너비 */
            height: 36px; /* 정사각형 높이 */
            border-radius: 50%; /* 완전한 원 */
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
            background-color: rgba(0, 0, 0, 0.6); /* hover 시 더 진한 배경 */
            color: rgba(255, 255, 255, 0.95); /* hover 시 글자 색 선명 */
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
            background: linear-gradient(to right, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
        }

        .right-fade {
            right: 0;
            background: linear-gradient(to left, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
        }

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
    </style>
</head>

<script>
    const reviewEdit = {
        init: function () {
            // 수정하기 버튼 클릭 시 수정폼 토글
            $(document).on('click', '.review-edit-btn', function () {
                const id = $(this).data('review-id');   // 여기서 화살표 함수 사용하면 this 에러
                reviewEdit.toggleForm(id);
            });

            // 저장 버튼 클릭 시 업데이트
            $(document).on('click', '.review-save-btn', function () {
                const id = $(this).data('review-id');

                const grade = $('#gradeInput-' + id).val();
                const comment = $('#commentInput-' + id).val();

                if (!grade || grade === "") {
                    alert("평점을 선택해주세요.");
                    return;
                }

                if (!comment || comment.trim() === "") {
                    alert("리뷰 내용을 작성해주세요.");
                    return;
                }

                reviewEdit.update(id);
            });

            // 취소 버튼 클릭 시 폼 닫기
            $(document).on('click', '.review-cancel-btn', function () {
                const id = $(this).data('review-id');
                reviewEdit.toggleForm(id);
            });

            // 슬라이더 버튼 기능 초기화
            reviewEdit.initSlider();
        },

        toggleForm: function (id) {
            const form = $('#editForm-' + id);            // 수정폼 DOM
            const commentText = $('#commentText-' + id);  // 원래 텍스트 코멘트
            const gradeText = $('#gradeText-' + id);      // 원래 평점 텍스트

            /* form 이 현재 화면에 보이면 실행 */
            if (form.is(':visible')) {
                form.hide();          // 이미 보이면 닫고
                commentText.show();   // 텍스트 다시 보여줌
                gradeText.show();
            } else {
                form.show();          // 폼이 안 보이면 보여주고
                commentText.hide();   // 기존 텍스트는 숨김
                gradeText.hide();
            }
        },

        update: function (id) {
            $('#editForm-' + id + '-form').attr({
                'method': 'post',
                'action': '<c:url value="/review/update"/>'
            });
            $('#editForm-' + id + '-form').submit();
        },
        initSlider: function () {
            $('.review-slider-wrapper').each(function () {
                const $wrapper = $(this);
                const $container = $wrapper.find('.review-slider-container');
                const $leftBtn = $wrapper.find('.left-arrow');
                const $rightBtn = $wrapper.find('.right-arrow');
                const $leftFade = $wrapper.find('.left-fade');
                const $rightFade = $wrapper.find('.right-fade');

                // 스크롤 위치를 보고 fade & 버튼을 토글하는 함수
                const updateFade = () => {
                    const scrollLeft = $container.scrollLeft();
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
                        {scrollLeft: '-=300'},
                        400,
                        updateFade
                    );
                });
                $rightBtn.on('click', function () {
                    $container.animate(
                        {scrollLeft: '+=300'},
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
        reviewEdit.init();
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
        <div class="home_title">나의 리뷰</div>
    </div>
</div>

<!-- 센터 -->
<div class="blog">
    <div class="container">
        <div class="row">
            <!-- 리뷰 리스트 (왼쪽) -->
            <div class="col-lg-8">
                <c:choose>
                    <c:when test="${empty ReviewList}">
                        <div class="card mb-4 p-4 shadow-sm text-center item_none">
                            <img src="images/avatar.png" alt="리뷰를 남겨주세요!" class="img-fluid mb-3"
                                 style="max-width: 120px;">
                            <h5 class="mb-1 font-weight-bold text-dark">아직 리뷰를 하지 않았어요!</h5>
                            <p class="text-muted mb-0">소중한 후기를 남겨주세요.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 내가 작성한 리뷰 리스트 출력 -->
                        <c:forEach var="rv" items="${ReviewList}">
                            <div class="card mb-4 p-3 shadow-sm" style="border-radius: 12px;">
                                <!-- 숙소 이름 + 수정/삭제 드롭다운 -->
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="mb-1 font-weight-bold">${rv.name}</h5>
                                        <p class="mb-2 text-muted">${rv.location}</p>
                                    </div>
                                    <div class="dropdown">
                                        <button class="btn btn-light btn-sm dropdown-toggle p-1" type="button"
                                                id="dropdownMenu${rv.reviewId}" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false">
                                            <i class="fa fa-ellipsis-v"></i> <%-- 네모난 점은 이미지로 대체하거나 그냥 쓰든가 해야함. 4버전엔 동그라미 점 지원을 안해줌 --%>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-right"
                                             aria-labelledby="dropdownMenu${rv.reviewId}" style="min-width: 120px;">
                                            <a class="dropdown-item d-flex justify-content-between align-items-center px-3 py-2 small text-muted review-edit-btn"
                                               href="javascript:void(0);"
                                               data-review-id="${rv.reviewId}"> <%-- javascript:void(0) : a 태그 클릭해도 아무 동작 안하도록 하는 코드 --%>
                                                수정하기
                                                <i class="fas fa-pencil-alt"></i>
                                            </a>
                                            <a href="<c:url value='/review/delete?rvId=${rv.reviewId}'/>"
                                               class="dropdown-item d-flex justify-content-between align-items-center px-3 py-2 small text-muted"
                                               onclick="return confirm('정말 삭제하시겠습니까?');">
                                                삭제하기
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- 유저 이름과 별점 -->
                                <div class="d-flex align-items-center mb-2">
                                    <span id="gradeText-${rv.reviewId}" class="text-warning mr-3">★ ${rv.grade}</span>
                                    <span class="text-primary font-weight-semibold">${rv.guestId}</span>
                                </div>

                                <!-- 이미지 슬라이더 영역 -->
                                <c:if test="${not empty rv.imageUrl}">
                                    <div class="review-slider-wrapper">
                                        <div class="slider-fade left-fade"></div>
                                        <button class="arrow left-arrow">&#10094;</button>

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

                                <!-- 리뷰 내용 -->
                                <p class="mb-2" id="commentText-${rv.reviewId}">${rv.comment}</p>

                                <!-- 수정 폼 (처음엔 숨김) -->
                                <div id="editForm-${rv.reviewId}" style="display: none;">
                                    <form id="editForm-${rv.reviewId}-form" enctype="multipart/form-data">
                                        <div class="form-group mb-2">
                                            <input type="hidden" name="reviewId" value="${rv.reviewId}">
                                            <label for="gradeInput-${rv.reviewId}">평점</label>
                                            <select class="form-control" id="gradeInput-${rv.reviewId}" name="grade"
                                                    required>
                                                <option value="">선택</option>
                                                <c:forEach var="i" begin="1" end="5">
                                                    <option value="${i}" ${rv.grade == i ? 'selected' : ''}>${i}점</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group mb-2">
                                            <label for="commentInput-${rv.reviewId}">리뷰 내용</label>
                                            <textarea class="form-control" id="commentInput-${rv.reviewId}"
                                                      name="comment" rows="4" required>${rv.comment}</textarea>
                                        </div>
                                        <!-- 이미지 업로드 추가 -->
                                        <div class="form-group mb-2">
                                            <label for="imageInput-${rv.reviewId}">이미지 수정</label>
                                            <input type="file" class="form-control" name="images"
                                                   id="imageInput-${rv.reviewId}" multiple>
                                        </div>
                                    </form>
                                    <div class="text-right mt-2">
                                        <button class="btn btn-sm btn-primary review-save-btn"
                                                data-review-id="${rv.reviewId}">저장
                                        </button>
                                        <button class="btn btn-sm btn-secondary review-cancel-btn"
                                                data-review-id="${rv.reviewId}">취소
                                        </button>
                                    </div>

                                </div>

                                <!-- 작성일 -->
                                <small class="text-muted"><fmt:formatDate value="${rv.createDay}"
                                                                          pattern="yyyy-MM-dd HH:mm:ss"/></small>

                                <!-- 호스트 답글 영역 -->
                                <c:if test="${not empty rv.replyComment}">
                                    <div class="mt-3 p-3 bg-light rounded border">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                  <span class="text-secondary">
                                      <strong style="font-size: 0.85rem;">🏠 호스트의 답글</strong>
                                      <span class="ml-1" style="font-size: 0.85rem;">(${rv.userId})님</span>
                                  </span>
                                            <small class="text-muted"><fmt:formatDate value="${rv.replyCreateDay}"
                                                                                      pattern="yyyy-MM-dd HH:mm:ss"/></small>
                                        </div>
                                        <p class="mb-0 text-dark">${rv.replyComment}</p>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty errorMessage}">
                <script>
                    alert(`${errorMessage}`);
                </script>
            </c:if>
            <!-- 사이드바 (오른쪽) -->
            <div class="col-lg-4 sidebar_list4css">
                <div class="sidebar_archives" style="margin-left: 100px;">
                    <div class="sidebar_title">MENU</div>
                    <div class="sidebar_list">
                        <ul>
                            <li><a href="<c:url value='/mypage/aireport'/>">AI 분석</a></li>
                            <li><a href="<c:url value="/details"/> ">나의 예약</a></li>
                            <li><a href="<c:url value="/review"/> ">나의 리뷰</a></li>
                            <li><a href="<c:url value="/wishlist"/> ">찜 목록</a></li>
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