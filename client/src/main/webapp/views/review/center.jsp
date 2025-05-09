<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- jQuery 라이브러리 CDN 추가 (반드시 먼저 위치시켜야 함) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
  <link rel="stylesheet" type="text/css" href="styles/blog_styles.css">
  <link rel="stylesheet" type="text/css" href="styles/blog_responsive.css">
  <link rel="stylesheet" type="text/css" href="styles/darkmode.css">

    <style>
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

        @media (min-width: 992px) {
            .pl-lg-5 {
                padding-left: 5rem !important;  /* 간격 확보 */
            }
        }

    </style>
</head>

<script>
    const reviewEdit = {
        init: function () {
            // 수정하기 버튼 클릭 시 수정폼 토글
            $(document).on('click', '.review-edit-btn', function() {
                const id = $(this).data('review-id');   // 여기서 화살표 함수 사용하면 this 에러
                reviewEdit.toggleForm(id);
            });

            // 저장 버튼 클릭 시 업데이트
            $(document).on('click', '.review-save-btn', function() {
                const id = $(this).data('review-id');
                reviewEdit.update(id);
            });

            // 취소 버튼 클릭 시 폼 닫기
            $(document).on('click', '.review-cancel-btn', function() {
                const id = $(this).data('review-id');
                reviewEdit.toggleForm(id);
            });
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
        }

    };

    $(document).ready(function () {
        reviewEdit.init();
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
    <div class="home_title">나의 리뷰</div>
  </div>
</div>

<!-- 센터 -->
<div class="blog">
  <div class="container">
      <div class="row">
          <!-- 리뷰 리스트 (왼쪽) -->
          <div class="col-lg-8">
              <!-- 내가 작성한 리뷰 리스트 출력 -->
              <c:forEach var="rv" items="${ReviewList}">
                  <div class="card mb-4 p-3 shadow-sm">
                      <!-- 숙소 이름 + 수정/삭제 드롭다운 -->
                      <div class="d-flex justify-content-between align-items-center">
                          <div>
                              <h5 class="mb-1 font-weight-bold">${rv.name}</h5>
                              <p class="mb-2 text-muted">${rv.location}</p>
                          </div>
                          <div class="dropdown">
                              <button class="btn btn-light btn-sm dropdown-toggle p-1" type="button"
                                      id="dropdownMenu${rv.reviewId}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  <i class="fa fa-ellipsis-v"></i> <%-- 네모난 점은 이미지로 대체하거나 그냥 쓰든가 해야함. 4버전엔 동그라미 점 지원을 안해줌 --%>
                              </button>
                              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu${rv.reviewId}" style="min-width: 120px;">
                                  <a class="dropdown-item d-flex justify-content-between align-items-center px-3 py-2 small text-muted review-edit-btn"
                                     href="javascript:void(0);" data-review-id="${rv.reviewId}"> <%-- javascript:void(0) : a 태그 클릭해도 아무 동작 안하도록 하는 코드 --%>
                                      수정하기
                                      <i class="fa fa-pencil"></i>
                                  </a>
                                  <a href="<c:url value='/review/delete?rvId=${rv.reviewId}'/>"
                                     class="dropdown-item d-flex justify-content-between align-items-center px-3 py-2 small text-muted"
                                     onclick="return confirm('정말 삭제하시겠습니까?');">
                                      삭제하기
                                      <i class="fa fa-trash"></i>
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

                      <!-- 리뷰 내용 -->
                      <p class="mb-2" id="commentText-${rv.reviewId}">${rv.comment}</p>

                      <!-- 수정 폼 (처음엔 숨김) -->
                      <div id="editForm-${rv.reviewId}" style="display: none;">
                          <form id="editForm-${rv.reviewId}-form" enctype="multipart/form-data">
                              <div class="form-group mb-2">
                                  <input type="hidden" name="reviewId" value="${rv.reviewId}">
                                  <label for="gradeInput-${rv.reviewId}">평점</label>
                                  <select class="form-control" id="gradeInput-${rv.reviewId}" name="grade" required>
                                      <option value="">선택</option>
                                      <c:forEach var="i" begin="1" end="5">
                                          <option value="${i}" ${rv.grade == i ? 'selected' : ''}>${i}점</option>
                                      </c:forEach>
                                  </select>
                              </div>
                              <div class="form-group mb-2">
                                  <label for="commentInput-${rv.reviewId}">리뷰 내용</label>
                                  <textarea class="form-control" id="commentInput-${rv.reviewId}" name="comment" rows="4" required>${rv.comment}</textarea>
                              </div>
                              <!-- 이미지 업로드 추가 -->
                              <div class="form-group mb-2">
                                  <label for="imageInput-${rv.reviewId}">이미지 수정</label>
                                  <input type="file" class="form-control" name="images" id="imageInput-${rv.reviewId}" multiple>
                              </div>
                          </form>
                          <button class="btn btn-sm btn-primary review-save-btn" data-review-id="${rv.reviewId}">저장</button>
                          <button class="btn btn-sm btn-secondary review-cancel-btn" data-review-id="${rv.reviewId}">취소</button>
                      </div>

                      <!-- 작성일 -->
                      <small class="text-muted">${rv.createDay}</small>
                  </div>
              </c:forEach>
          </div>

          <!-- 사이드바 (오른쪽) -->
          <div class="col-lg-4 pl-lg-5">
              <div class="sidebar_archives">
                  <div class="sidebar_title">MENU</div>
                  <div class="sidebar_list">
                      <ul>
                          <li><a href="<c:url value='/details'/>">나의 예약</a></li>
                          <li><a href="<c:url value='/review'/>">나의 리뷰</a></li>
                      </ul>
                  </div>
              </div>
          </div>
      </div>
  </div>
</div>

<script src="js/darkmode.js"></script>