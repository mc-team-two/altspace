<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container my-4">

  <!-- 1행: 요약 카드 -->
  <div class="row text-center mb-4">

    <!-- 다가오는 예약 (오늘, 내일 체크인) -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body p-4">
          <h6 class="card-title mb-3 text-primary">📌 다가오는 예약</h6>
          <div class="d-flex justify-content-around">
            <div>
              <div class="fw-bold text-muted">오늘</div>
              <div class="text-primary fw-bold fs-4">${todayCheckInCount}건</div>
            </div>
            <div>
              <div class="fw-bold text-muted">내일</div>
              <div class="text-primary fw-bold fs-4">${tomorrowCheckInCount}건</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 현재 예약 건수 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column p-4">
          <h6 class="card-title mb-2">📅 현재 예약 건수</h6>
          <div class="flex-grow-1 d-flex align-items-center justify-content-center">
            <h2 class="fw-bold mb-0 text-info">${reservationCount}건</h2>
          </div>
        </div>
      </div>
    </div>

    <!-- 호스팅 중 숙소 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column p-4">
          <h6 class="card-title mb-2">🏨 호스팅 중 숙소</h6>
          <div class="flex-grow-1 d-flex align-items-center justify-content-center">
            <h2 class="fw-bold mb-0 text-success">${hostingCount}개</h2>
          </div>
        </div>
      </div>
    </div>

    <!-- 체크아웃 예정 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body p-4">
          <h6 class="card-title mb-3 text-danger">🚪 체크아웃 예정</h6>
          <div class="d-flex justify-content-around">
            <div>
              <div class="fw-bold text-muted">오늘</div>
              <div class="text-danger fw-bold fs-4">${todayCheckOutCount}건</div>
            </div>
            <div>
              <div class="fw-bold text-muted">내일</div>
              <div class="text-danger fw-bold fs-4">${tomorrowCheckOutCount}건</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 전체 예약 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column p-4">
          <h6 class="card-title mb-2">📂 전체 예약</h6>
          <div class="flex-grow-1 d-flex align-items-center justify-content-center">
            <h2 class="fw-bold mb-0 text-secondary">${totalReservationCount}건</h2>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- 2행: 요약 카드 -->
  <div class="row text-center mb-4">

    <!-- 이번달 수익 카드-->
    <div class="col-md-3 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center align-items-center p-4">
          <h6 class="card-title mb-2">📊 이번달 수익</h6>
          <h2 class="text-success fw-bold mb-0" id="monthTotal" data-total="${monthTotal}">0원</h2>
        </div>
      </div>
    </div>

    <!-- 현재 예약 건수-->
    <div class="col-md-3 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center align-items-center p-4">
          <h6 class="card-title mb-2">📅 현재 예약 건수</h6>
          <h2 class="fw-bold mb-0" style="color: #696cff; font-size: 2rem;">${reservationCount}건</h2>
        </div>
      </div>
    </div>

    <!-- 오늘 체크인-->
    <div class="col-md-3 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center align-items-center p-4">
          <h6 class="card-title mb-2">🏠 오늘 체크인</h6>
          <h2 id="todayCheckInCount" class="text-danger fw-bold" style="font-size: 2rem; margin-bottom: 0;">${todayCheckInCount}건</h2>
        </div>
      </div>
    </div>

    <!-- 신규 리뷰-->
    <div class="col-md-3 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center align-items-center p-4">
          <h6 class="card-title mb-2">⭐ 신규 리뷰</h6>
          <h2 class="text-warning fw-bold" style="margin-bottom: 0;">2건</h2>
        </div>
      </div>
    </div>

  </div>

  <!-- 3행: 다가오는 예약, 인기 스페이스-->
  <div class="row">

    <!-- 다가오는 예약 -->
    <div class="col-md-8 mb-4">

      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center p-4">
          <h6 class="card-title mb-2">📌 다가오는 예약</h6>
          <div class="card-body p-4">
            <table class="table table-bordered table-hover">
              <thead class="table-light">
              <tr>
                <th class="text-center">이름</th>
                <th class="text-center">스페이스</th>
                <th class="text-center">체크인</th>
                <th class="text-center">체크아웃</th>
              </tr>
              </thead>
              <tbody>
              <c:choose>
                <c:when test="${not empty upcoming7DaysReservations}">
                  <c:forEach var="reservation" items="${upcoming7DaysReservations}">
                    <tr>
                      <td class="text-center">${reservation.userName}</td>
                      <td class="text-center">${reservation.name}</td>
                      <td class="text-center">${reservation.checkIn}</td>
                      <td class="text-center">${reservation.checkOut}</td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="3" class="text-center text-muted">📅 다가오는 예약이 없습니다.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- 이번 달 인기 스페이스 -->
    <c:choose>
      <c:when test="${not empty popularSpace}">
        <div class="col-md-4 mb-4">
          <div class="card shadow-sm h-100">
            <div class="card-body d-flex flex-column justify-content-center p-4">
              <h6 class="card-title mb-2">🏠 이번 달 인기 스페이스</h6>
              <div class="text-center">
                <h5 class="card-title mb-3 text-primary fw-bold" style="line-height: 1.1;">
                    ${popularSpace.name}
                </h5>
                <p class="card-text text-muted mb-3" style="line-height: 0.5;">
                  총 <strong>${popularSpace.reservationsCount}</strong>건의 예약이 완료되었습니다.
                </p>
                <img src="${pageContext.request.contextPath}/imgs/${popularSpace.image1Name}"
                     alt="숙소 이미지"
                     class="img-fluid rounded"
                     style="max-height: 180px;">
              </div>
            </div>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <div class="col-md-4 mb-4">
          <div class="card shadow-sm h-100">
            <div class="card-body d-flex flex-column justify-content-center p-4 text-center">
              <h6 class="card-title mb-2">🏠 이번 달 인기 스페이스</h6>
              <p class="card-text text-muted">데이터가 없습니다.</p>
            </div>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- 4행: 수익 차트 -->
  <div class="card shadow-sm mb-4">
    <div class="card-header bg-light fw-bold">📈 최근 6개월 수익 추이</div>
    <div class="card-body">
      <canvas id="earningsChart" style="max-height: 300px; height: 300px;"></canvas>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    // 수익 숫자 애니메이션
    const monthTotalElement = document.getElementById('monthTotal');
    const finalAmount = parseInt('${monthTotal}'.replace(/,/g, '')); // 서버에서 받은 수익값

    if (isNaN(finalAmount)) {
      console.error('서버에서 받은 값이 올바르지 않습니다.');
      return;
    }

    let currentAmount = 0;
    const duration = 3000;
    const frameRate = 60;
    const totalFrames = Math.round(duration / (2000 / frameRate));
    const increment = finalAmount / totalFrames;

    const counter = setInterval(() => {
      currentAmount += increment;
      if (currentAmount >= finalAmount) {
        currentAmount = finalAmount;
        clearInterval(counter);
      }
      // 소수점 반올림 후 천 단위 구분
      monthTotalElement.innerText = Math.round(currentAmount).toLocaleString() + "원";
    }, 1000 / frameRate);

    // 오늘 체크인 애니메이션
    const todayCheckInCountElement = document.getElementById('todayCheckInCount');
    let todayCheckInCount = parseInt(todayCheckInCountElement.innerText.trim(), 10);

    if (isNaN(todayCheckInCount) || todayCheckInCount <= 0) {
      console.error("유효한 숫자가 아닙니다:", todayCheckInCountElement.innerText);
      todayCheckInCount = 0;  // 값이 0이거나 유효하지 않으면 애니메이션을 멈추도록 설정
    }

    let currentCount = 0;
    const todayCheckInInterval = setInterval(() => {
      if (currentCount < todayCheckInCount) {
        currentCount++;
        todayCheckInCountElement.innerText = `${currentCount}건`;
      } else {
        clearInterval(todayCheckInInterval);
        // 애니메이션 끝나면 마지막 값을 갱신한 후 종료
        todayCheckInCountElement.innerText = `${todayCheckInCount}건`;  // 최종 값이 그대로 남게 설정
      }
    }, 30);

    // 수익 데이터 가져오기
    const earningsData = JSON.parse('${earningsDataJson}');

    // Chart.js - 월별 수익 그래프
    const ctx = document.getElementById('earningsChart').getContext('2d');
    const earningsChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: earningsData.map(data => data.month), // 월 정보
        datasets: [{
          label: '월별 수익 (₩)',
          data: earningsData.map(data => data.total), // 수익 정보
          borderColor: 'rgba(75, 192, 192, 1)',
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          tension: 0.3,
          fill: true,
          pointRadius: 4
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: false,
            ticks: {
              callback: function(value) {
                return '₩' + value.toLocaleString();
              }
            }
          }
        }
      }
    });
  });
</script>