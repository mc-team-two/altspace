<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- ✅ FullCalendar 스타일 -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet"/>
<style>
    #calendar {
        max-width: 900px;
        margin: 0 auto;
    }

    /* 이벤트 박스를 크게 블럭형으로 */
    .fc-daygrid-event {
        display: block;
        padding: 8px;
        font-size: 16px;
        border-radius: 6px;
        line-height: 1.6;
        height: auto;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>

<!-- ✅ 캘린더 초기화 -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const events = [
            <c:forEach var="pay" items="${payments}" varStatus="loop">
            <c:if test="${pay.payStatus eq '완료'}">
            {
                title: '[ID: ${pay.guestId}]님 예약 - ${pay.payAmount}원',
                start: '${pay.checkIn}',
                end: '${pay.checkOut}',
                color: '#696cff',
                guestId: '${pay.guestId}'
            }<c:if test="${!loop.last}">,</c:if>
            </c:if>
            </c:forEach>
        ];

        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,listMonth'
            },
            eventDisplay: 'block',
            events: events,
            eventDidMount: function(info) {
                // 툴팁에 전체 텍스트 표시
                tippy(info.el, {
                    content: info.event.title,
                    theme: 'light',
                    placement: 'top',
                    delay: [200, 0]
                });
            }
        });

        calendar.render();
    });
</script>

<div class="container my-4">
    <h3 class="mb-4">${payments[0].name} 예약 내역</h3>
    <a href="<c:url value='/space/booking'/>" class="btn btn-outline-secondary btn-sm mb-3">내 스페이스 목록</a>
    <div id="calendar"></div>
</div>