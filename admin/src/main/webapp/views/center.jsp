<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .list-group-item {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
  }

  /* 애니메이션 순차적으로 나오게 delay 주기 */
  .list-group-item:nth-child(1) { animation-delay: 0.1s; }
  .list-group-item:nth-child(2) { animation-delay: 0.3s; }
  .list-group-item:nth-child(3) { animation-delay: 0.5s; }
  .list-group-item:nth-child(4) { animation-delay: 0.7s; }
  .list-group-item:nth-child(5) { animation-delay: 0.9s; }
</style>

<div class="container my-4">

  <!-- 1행: 요약 카드 -->
  <div class="row text-center mb-4">

    <!-- 다가오는 예약 (오늘, 내일 체크인) -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body p-4">
          <h6 class="card-title mb-3 text-primary">📌 체크인 예정</h6>
          <div class="d-flex justify-content-around">
            <div>
              <div class="fw-bold text-muted">오늘</div>
              <div class="text-primary fw-bold fs-4" id="todayCheckIn">0건</div>
            </div>
            <div>
              <div class="fw-bold text-muted">내일</div>
              <div class="text-primary fw-bold fs-4" id="tomorrowCheckIn">0건</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 현재 예약 건수 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column p-4">
          <h6 class="card-title mb-2">📅 예정된 예약</h6>
          <div class="flex-grow-1 d-flex align-items-center justify-content-center">
            <h2 class="fw-bold mb-0 text-info" id="reservationCount">0건</h2>
          </div>
        </div>
      </div>
    </div>

    <!-- 호스팅 중 스페이스 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column p-4">
          <h6 class="card-title mb-2">🏨 호스팅 중 스페이스</h6>
          <div class="flex-grow-1 d-flex align-items-center justify-content-center">
            <h2 class="fw-bold mb-0 text-success" id="hostingCount">0개</h2>
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
              <div class="text-danger fw-bold fs-4" id="todayCheckOut">0건</div>
            </div>
            <div>
              <div class="fw-bold text-muted">내일</div>
              <div class="text-danger fw-bold fs-4" id="tomorrowCheckOut">0건</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 전체 예약 -->
    <div class="col-12 col-sm-6 col-lg-4 col-xl">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column p-4">
          <h6 class="card-title mb-2">📂 다가오는 예약</h6>
          <div class="flex-grow-1 d-flex align-items-center justify-content-center">
            <a href="<c:url value='/space/booking'/>" class="text-decoration-none">
              <h2 class="fw-bold mb-0 text-secondary" id="totalReservationCount" style="cursor: pointer;">
                <span class="count-text">0건</span>
                <i class="bi bi-arrow-right-circle fs-6 text-muted ms-2" style="vertical-align: middle;"></i>
              </h2>
            </a>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- 2행: Top5 요약 카드 (1번째 줄 - 3개) -->
  <div class="row text-center mb-4">

    <!-- 조회수 Top5 -->
    <div class="col-12 col-md-6 col-lg-4 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body p-3">
          <h6 class="card-title text-primary mb-2">👁️ 조회수 Top5</h6>
          <ul id="topViews" class="top-item list-group small text-muted">로딩 중...</ul>
        </div>
      </div>
    </div>

    <!-- 리뷰수 Top5 -->
    <div class="col-12 col-md-6 col-lg-4 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body p-3">
          <h6 class="card-title text-warning mb-2">⭐ 리뷰수 Top5</h6>
          <div id="topReviews" class="top-item small text-muted">로딩 중...</div>
        </div>
      </div>
    </div>

    <!-- 찜 Top5 -->
    <div class="col-12 col-md-6 col-lg-4 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body p-3">
          <h6 class="card-title text-danger mb-2">💖 찜 Top5</h6>
          <div id="topWishlists" class="top-item small text-muted">로딩 중...</div>
        </div>
      </div>
    </div>
  </div>

  <!-- 3행: Top5 요약 카드 (2번째 줄 - 3개) -->
  <div class="row text-center mb-4">

    <!-- 누적 매출 Top5 -->
    <div class="col-12 col-md-6 col-lg-4 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body p-3">
          <h6 class="card-title text-success mb-2">💰 누적 매출 Top5</h6>
          <div id="topSalesAllTime" class="top-item small text-muted">로딩 중...</div>
        </div>
      </div>
    </div>

    <!-- 이번 달 매출 Top5 -->
    <div class="col-12 col-md-6 col-lg-4 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body p-3">
          <h6 class="card-title text-info mb-2">📈 이번 달 매출 Top5</h6>
          <div id="topSalesThisMonth" class="top-item small text-muted">로딩 중...</div>
        </div>
      </div>
    </div>

    <!-- 이번 달 예약 Top5 -->
    <div class="col-12 col-md-6 col-lg-4 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body p-3">
          <h6 class="card-title text-secondary mb-2">📅 이번 달 예약 Top5</h6>
          <div id="topBookingsThisMonth" class="top-item small text-muted">로딩 중...</div>
        </div>
      </div>
    </div>
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
  // 공통 리스트 렌더링 함수
  function renderList(selector, dataList, valueKey) {
    const container = $(selector);
    container.empty();

    if (dataList && dataList.length > 0) {
      const rankLabels = ['1위 🥇', '2위 🥈', '3위 🥉', '4위', '5위'];
      const colors = ['#b8860b', '#6c757d', '#8b4513', '#5a2d82', '#0d6efd']; // 진한 금색, 은색, 동색, 보라, 파랑

      dataList.forEach((item, index) => {
        const rank = rankLabels[index] || `${index + 1}위`;
        const color = colors[index] || '#000';

        container.append(
                '<li class="list-group-item d-flex justify-content-between align-items-center" ' +
                'style="color:' + color + '; font-weight: 400; font-size: 1rem;">' +
                '<span>' + rank + ' - ' + item.name + '</span>' +
                '</li>'
        );
      });
    } else {
      container.append('<li class="list-group-item" style="font-size: 1.2rem;">데이터 없음</li>');
    }
  }

  $(function () {
    // ✅ 수익 차트
    const earningsData = ${earningsDataJson}; // 서버에서 JSON.stringify()로 전달
    const ctx = document.getElementById('earningsChart').getContext('2d');
    const earningsChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: earningsData.map(data => data.month),
        datasets: [{
          label: '월별 수익 (₩)',
          data: earningsData.map(data => data.total),
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
            ticks: {
              callback: value => '₩' + value.toLocaleString()
            }
          }
        }
      }
    });

    // ✅ 예약 관련 데이터
    const hostId = '${hostId}'; // 서버에서 전달
    $.ajax({
      url: '/api/dashboard/reservations',
      method: 'GET',
      data: { hostId: hostId },
      dataType: 'json',
      success: function (response) {
        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(today.getDate() + 1);

        const formatDate = d => d.toISOString().split('T')[0];
        const todayStr = formatDate(today);
        const tomorrowStr = formatDate(tomorrow);

        const checkIns = response.upcomingCheckIns.data;
        const checkOuts = response.upcomingCheckOuts.data;

        $('#todayCheckIn').text(checkIns.filter(d => d.checkIn.startsWith(todayStr)).length + '건');
        $('#tomorrowCheckIn').text(checkIns.filter(d => d.checkIn.startsWith(tomorrowStr)).length + '건');
        $('#todayCheckOut').text(checkOuts.filter(d => d.checkOut.startsWith(todayStr)).length + '건');
        $('#tomorrowCheckOut').text(checkOuts.filter(d => d.checkOut.startsWith(tomorrowStr)).length + '건');

        $('#reservationCount').text(response.currentReservations.count + '건');
        $('#hostingCount').text(response.hostingNow.count + '개');

        const totalReservationCount =
                response.currentReservations.count +
                response.upcomingCheckIns.count +
                response.upcomingCheckOuts.count;

        $('#totalReservationCount .count-text').text(totalReservationCount + '건');
      },
      error: function () {
        console.error('API 호출 실패');
      }
    });

    // ✅ Top5 통계 API
    $.ajax({
      url: '/api/dashboard/accommodations',
      method: 'GET',
      data: { hostId: hostId },
      dataType: 'json',
      success: function (data) {

        console.log("Top5 데이터", data); // 🔍 데이터 확인

        renderList("#topViews", data.topViews, "views");
        renderList("#topReviews", data.topReviews, "reviews");
        renderList("#topWishlists", data.topWishlists, "wishlists");
        renderList("#topBookingsThisMonth", data.topBookingsThisMonth, "bookingCount");
        renderList("#topSalesAllTime", data.topSalesAllTime, "totalSales");
        renderList("#topSalesThisMonth", data.topSalesThisMonth, "totalSales");
      },
      error: function (xhr) {
        alert("Top5 데이터를 불러오는 데 실패했습니다: " + xhr.responseText);
      }
    });
  });
</script>