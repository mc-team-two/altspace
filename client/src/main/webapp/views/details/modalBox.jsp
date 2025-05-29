<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 예약 정보 박스 -->
<div id="content">
    <form id="data_del">
        <input type="hidden" name="guestId" value="${sessionScope.user.userId}">
        <input type="hidden" name="accommodationId" value="${accomm.accommodationId}">
        <input type="hidden" name="impUid" value="${payInfo.impUid}">
        <input type="hidden" name="paymentId" value="${payInfo.paymentId}">

        <!-- 숙박시설 이름 표시 -->
        <h3 class="font-weight-bold mb-4 text-center text-dark">
            ${accomm.name}
        </h3>

        <ul class="list-unstyled mb-0">
            <li class="mb-3 d-flex align-items-center">
                <i class="fas fa-calendar-alt text-primary mr-2"></i>
                <span><strong>체크인:</strong>&nbsp;
          <fmt:formatDate value="${checkInDate}" pattern="yyyy-MM-dd"/>
        </span>
            </li>
            <li class="mb-3 d-flex align-items-center">
                <i class="fas fa-calendar-check text-success mr-2"></i>
                <span><strong>체크아웃:</strong>&nbsp;
          <fmt:formatDate value="${checkOutDate}" pattern="yyyy-MM-dd"/>
        </span>
            </li>
            <li class="mb-3 d-flex align-items-center">
                <i class="fas fa-wallet text-warning mr-2"></i>
                <span><strong>결제 금액:</strong>&nbsp;
          <fmt:formatNumber value="${payInfo.payAmount}" type="number"/> 원
        </span>
            </li>
        </ul>
    </form>

    <div class="alert alert-danger mt-4 py-2 px-3" role="alert" style="font-size: 0.95rem;">
        <i class="fas fa-exclamation-triangle mr-2"></i>
        체크인 2일 전부터는 예약 취소가 불가합니다.
    </div>

    <div class="d-flex justify-content-between mt-3 px-1" style="gap: 10px;">
        <button id="review_btn" class="btn btn-primary flex-fill font-weight-bold rounded-pill">
            <i class="fas fa-pen mr-1"></i> 리뷰 작성
        </button>
        <button id="cancel_btn" class="btn btn-danger flex-fill font-weight-bold rounded-pill">
            <i class="fas fa-times mr-1"></i> 예약 취소
        </button>
    </div>
</div>