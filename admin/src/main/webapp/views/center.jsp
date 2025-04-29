<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container my-4">

  <!-- 요약 카드 -->
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
          <h6 class="card-title text-muted mb-2">📅 현재 예약 건수</h6>
          <h2 class="fw-bold mb-0" style="color: #696cff; font-size: 2rem;">${reservationCount}건</h2>
        </div>
      </div>
    </div>

    <!-- 오늘 체크인-->
    <div class="col-md-3 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center align-items-center p-4">
          <h6 class="card-title text-muted mb-2">🏠 오늘 체크인</h6>
          <h2 id="todayCheckInCount" class="text-danger fw-bold" style="font-size: 2rem; margin-bottom: 0;">${todayCheckInCount}건</h2>
        </div>
      </div>
    </div>

    <!-- 신규 리뷰-->
    <div class="col-md-3 mb-3">
      <div class="card shadow-sm h-100">
        <div class="card-body d-flex flex-column justify-content-center align-items-center p-4">
          <h6 class="card-title text-muted mb-2">⭐ 신규 리뷰</h6>
          <h2 class="text-warning fw-bold" style="margin-bottom: 0;">2건</h2>
        </div>
      </div>
    </div>

  </div>

  <!-- 다가오는 예약 -->
  <div class="row">
    <div class="col-md-8 mb-4">
      <div class="card">
        <div class="card-header bg-light">📌 다가오는 예약</div>
        <div class="card-body p-0">
          <table class="table table-striped mb-0">
            <thead class="table-light">
            <tr>
              <th>게스트 이름</th>
              <th>체크인</th>
              <th>체크아웃</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>김민지</td>
              <td>2025-04-30</td>
              <td>2025-05-02</td>
            </tr>
            <tr>
              <td>이서준</td>
              <td>2025-05-01</td>
              <td>2025-05-03</td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- 알림 -->
    <div class="col-md-4 mb-4">
      <div class="card">
        <div class="card-header bg-light">🔔 알림</div>
        <div class="card-body">
          <ul class="list-unstyled mb-0">
            <li>📩 박지훈님으로부터 새 메시지</li>
            <li>📆 5월 5일 예약 요청</li>
            <li>⭐ 신규 리뷰가 등록되었습니다</li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <!-- 수익 차트 -->
  <div class="card">
    <div class="card-header bg-light">
      📈 월별 수익 추이
    </div>
    <div class="card-body">
      <canvas id="earningsChart" height="100"></canvas>
    </div>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    // 수익 숫자 애니메이션
    const monthTotalElement = document.getElementById('monthTotal');
    const finalAmount = parseInt('${monthTotal}'); // 서버에서 받은 수익값
    let currentAmount = 0;
    const duration = 1000; // 1초
    const frameRate = 60;
    const totalFrames = Math.round(duration / (1000 / frameRate));
    const increment = finalAmount / totalFrames;

    const counter = setInterval(() => {
      currentAmount += increment;
      if (currentAmount >= finalAmount) {
        currentAmount = finalAmount;
        clearInterval(counter);
      }
      monthTotalElement.innerText = Math.floor(currentAmount).toLocaleString() + "원";
    }, 1000 / frameRate);

    const todayCheckInCountElement = document.getElementById('todayCheckInCount');
    const todayCheckInCount = parseInt(todayCheckInCountElement.innerText);

    let currentCount = 0;
    let interval = setInterval(() => {
      if (currentCount < todayCheckInCount) {
        currentCount++;
        todayCheckInCountElement.innerText = `${currentCount}건`;
      } else {
        clearInterval(interval);
      }
    }, 30); // 30ms마다 1씩 증가

    // Chart.js - 월별 수익 그래프
    const ctx = document.getElementById('earningsChart').getContext('2d');
    const earningsChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: ['1월', '2월', '3월', '4월', '5월'],
        datasets: [{
          label: '월별 수익 (₩)',
          data: [800000, 950000, 1200000, 1100000, 1300000],
          borderColor: 'rgba(75, 192, 192, 1)',
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          tension: 0.3,
          fill: true,
          pointRadius: 4
        }]
      },
      options: {
        responsive: true,
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