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
    label {
        cursor: pointer;
    }
    .fc-daygrid-event {
        margin-bottom: 5px;
/*        display: block;
        padding: 8px;
        font-size: 16px;
        border-radius: 6px;
        line-height: 1.6;
        height: auto;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;*/
    }
</style>

<script>
    const bookingPage = {
        events: [],
        calendar: null,
        lastFetchTime: null,
        init: function () {
            this.makeCalendar();
            this.bindEvents();
            this.loadData();
        },

        // ajax 요청 (data)
        loadData: function () {
            this.lastFetchTime = new Date(); // 기준 시간 저장

            $.ajax({
                url: "<c:url value='/api/booking/reservations'/>",
                data: { hostId: "${sessionScope.user.userId}" },
                success: (resp) => {
                    console.log(resp);
                    console.log(resp.canceled);
                    bookingPage.bindCounts(resp);      // 이벤트 카운트 표시 (사이드바)
                    bookingPage.populateEvents(resp);  // 이벤트 푸시
                    bookingPage.renderCalendar();      // 캘린더 갱신
                    bookingPage.updateTimestamp();     // 데이터 기준일자 갱신
                },
                error: (xhr) => { alert(xhr.responseText); }
            });
        },

        // 캘린더 만들기
        makeCalendar: function () {
            const calendarEl = document.getElementById("calendar");

            this.calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                displayEventTime: false,
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,listMonth'
                },
                eventDisplay: 'block',
                events: [],  // 초기 빈 이벤트
                eventDidMount: function (info) {
                    // extendedProps에서 데이터 추출
                    let ep = info.event.extendedProps;
                    let guestName = ep.guestName;
                    let location  = ep.location;
                    let paymentId = ep.paymentId;

                    // 문자열 연결로 툴팁 HTML 구성
                    let tooltipContent =
                        '<div style="font-weight:bold; margin-bottom:4px;">' +
                            info.event.title +
                        '</div>' +
                        '<div>게스트: ' + guestName + '</div>' +
                        '<div>위치: '   + location  + '</div>' +
                        '<div>결제ID: ' + paymentId + '</div>';

                    tippy(info.el, {
                        content: tooltipContent,
                        allowHTML: true,
                        theme: 'light-border',
                        placement: 'top',
                        delay: [200, 0]
                    });
                }
            });

            this.calendar.render();
        },

        // 이벤트 배열에 데이터 추가
        populateEvents: function (resp) {
            const statusColors = {
                upcoming: '#ffc107',
                finished: '#696cff',
                hostingNow: '#28a745',
                canceled: '#dc3545'
            };

            const statusLabels = {
                upcoming: '[예정]',
                finished: '[완료]',
                hostingNow: '[진행]',
                canceled: '[취소]'
            };

            const types = ['upcoming', 'finished', 'hostingNow', 'canceled'];

            this.events = [];  // 기존 이벤트 초기화

            types.forEach(type => {
                const eventsForType = resp[type]?.data || [];
                eventsForType.forEach(event => {
                    this.events.push({
                        title: statusLabels[type] + ' ' + event.accommodationName,
                        start: event.checkIn,
                        end: event.checkOut,
                        color: statusColors[type],
                        extendedProps: {
                            paymentId: event.paymentId,
                            guestId: event.guestId,
                            guestName: event.guestName,
                            location: event.location,
                            status: type,
                            hostId: event.hostId
                        }
                    });
                });
            });

            // 데이터가 추가되면 필터링 함수 호출
            this.filterEvents();
        },

        // 캘린더 갱신
        renderCalendar: function () {
            this.filterEvents();  // 필터링된 이벤트로 렌더링
        },

        // 필터링된 이벤트만 표시
        filterEvents: function () {
            const filters = {
                upcoming: $('#upcoming').is(':checked'),
                finished: $('#finished').is(':checked'),
                hostingNow: $('#hostingNow').is(':checked'),
                canceled: $('#canceled').is(':checked')
            };

            const filteredEvents = this.events.filter(event => {
                if (event.color === '#ffc107' && filters.upcoming) return true;
                if (event.color === '#696cff' && filters.finished) return true;
                if (event.color === '#28a745' && filters.hostingNow) return true;
                if (event.color === '#dc3545' && filters.canceled) return true;
                return false;
            });

            // 캘린더에 필터링된 이벤트만 추가
            this.calendar.removeAllEvents();
            this.calendar.addEventSource(filteredEvents);
        },

        // 데이터 기준일자 계산 및 표시
        updateTimestamp: function () {
            const now = new Date();
            const diffMs = now - this.lastFetchTime;
            const diffM = Math.floor(diffMs / 60000);
            let agoText;
            if (diffM < 1) {
                agoText = '방금 전';
            } else if (diffM < 60) {
                agoText = diffM + '분 전';
            } else {
                const diffH = Math.floor(diffM / 60);
                agoText = diffH + '시간 전';
            }

            // 날짜 포맷: YYYY-MM-DD 오전/오후 HH:MM
            const pad = n => n.toString().padStart(2,'0');
            const d = this.lastFetchTime;
            const Y = d.getFullYear();
            const M = pad(d.getMonth()+1);
            const D = pad(d.getDate());
            let h = d.getHours();
            const ampm = h >= 12 ? '오후' : '오전';
            h = h % 12 || 12;
            const H = pad(h);
            const m = pad(d.getMinutes());
            const formatted = Y + '-' + M + '-' + D + ' ' + ampm + ' ' + H + ':' + m;

            const text = '데이터 기준일자: ' + agoText + " (" + formatted + ")";
            $('#dataTimestamp').text(text);
        },

        // 사이드바 - 체크박스 이벤트 기능
        bindEvents: function () {
            $('#all').on('change', function () {
                const isChecked = $(this).is(':checked');
                $('#upcoming, #finished, #hostingNow, #canceled').prop('checked', isChecked);
                bookingPage.filterEvents();
            });

            $('#upcoming, #finished, #hostingNow, #canceled').on('change', function () {
                const allChecked = $('#upcoming').is(':checked') &&
                    $('#finished').is(':checked') &&
                    $('#hostingNow').is(':checked') &&
                    $('#canceled').is(':checked');
                $('#all').prop('checked', allChecked);
                bookingPage.filterEvents();
            });
        },

        // 사이드바 - 이벤트 카운트 표시
        bindCounts: function(resp) {
            $('#canceledLabel').append(" (" + resp.canceled.count + ")");
            $('#upcomingLabel').append(" (" +resp.upcoming.count + ")");
            $('#hostingNowLabel').append(" (" +resp.hostingNow.count + ")");
            $('#finishedLabel').append(" (" +resp.finished.count + ")");
        }
    };

    $(function () {
        bookingPage.init();
    });
</script>


<div class="col-sm-12">
    <p class="text-muted">스페이스 관리 > 내 스페이스 > <strong>예약 캘린더</strong></p>
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-sm-3">
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex align-items-center justify-content-between"
                        style="background-color: #f5f5f9">
                            <label for="all"><strong>전체보기</strong></label>
                            <input type="checkbox" class="form-check-input" id="all" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="upcoming" id="upcomingLabel">
                                호스팅 예정된 예약
                            </label>
                            <input type="checkbox" class="form-check-input" id="upcoming" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="finished" id="finishedLabel">호스팅 완료된 예약</label>
                            <input type="checkbox" class="form-check-input" id="finished" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="hostingNow" id="hostingNowLabel">호스팅 진행중 예약</label>
                            <input type="checkbox" class="form-check-input" id="hostingNow" checked>
                        </li>
                        <li class="list-group-item d-flex align-items-center justify-content-between">
                            <label for="canceled" id="canceledLabel">취소/환불된 예약</label>
                            <input type="checkbox" class="form-check-input" id="canceled" checked>
                        </li>
                    </ul>
                    <small class="text-muted px-1" id="dataTimestamp"></small>
                </div>
                <div class="col-sm-9">
                    <div id="calendar" class="ms-0">
                        <div class="p-5 d-flex justify-content-center align-items-center flex-column">
                            <span class="mb-2">예약 일정을 불러오는 중...</span>
                            <p class="spinner-border text-primary mt-2"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>