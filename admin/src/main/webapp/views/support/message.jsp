<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<head>
    <title> 고객 메시지 | 알트스페이스</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%-- jQuery CDN --%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <%--Bootstrap 5--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <%--Bootstrap Icon--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.12.1/font/bootstrap-icons.min.css">

    <%-- WebSocket Libraries --%>
    <script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/>"></script>
    <script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/>"></script>

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden; /* 전체 페이지 스크롤 방지 */
        }

        .headerArea {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 7.5vh;
            background-color: #ffffff;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 1rem;
            box-sizing: border-box;
        }

        .headerArea a {
            text-decoration: none;
            color: black;
            font-size: 18px;
        }

        .headerArea span {
            font-weight: bold;
            font-size: 18px;
        }

        .inputArea {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #ffffff;
            padding: 0.5rem;
            box-sizing: border-box;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.5rem;
        }

        .targetInput {
            width: calc(8ch + 10px);  /* 8글자 + padding */
            padding: 5px;
            box-sizing: border-box;
            border: none;
            border-radius: 0.5em;
            outline: none;
            background-color: #f5f5f9;
        }

        .inputArea textarea {
            width: 85%;
            max-height: 100px; /* 최대 높이 (4줄) */
            min-height: 36px;  /* 1줄 높이 */
            height: 36px;      /* 기본 높이 */
            resize: none;
            background-color: #f5f5f9;
            border: none;          /* 테두리 없음 */
            border-radius: 0.5em;   /* 곡선 유지 */
            outline: none;         /* 포커스 시에도 테두리 없음 */
            overflow-y: hidden;    /* 기본적으로 스크롤바 숨김 */
            padding: 0.5rem;       /* 패딩 추가 */
        }

        .inputArea button {
            width: 15%;
        }

        .chatArea {
            position: absolute;
            top: 7.5vh;
            bottom: 7.5vh;
            left: 0;
            width: 100%;
            overflow-y: auto; /* 세로 스크롤 활성화 */
            background-color: #f5f5f9;
            padding: 1rem;
        }

        .chatArea .notice {
            background-color: lightgray;
            font-size: 12px;
            text-align: center;
        }

        .bubbleArea {
            width: 100%;
            display: flex;
            flex-direction: row;
            margin-bottom: 8px; /* 여백 추가 */
        }

        .bubbleArea.myMsg {
            flex-direction: row-reverse; /* 내 메시지일 때 방향 반전 */
        }

        .bubbleMsg {
            background-color: rgba(83, 53, 108, 0.3);
            border-radius: 15px;
            padding: 15px;
            width: auto;
            max-width: 85%;
            font-size: 14px;
            margin-top: 3px;
        }

        .bubbleArea.myMsg .bubbleMsg {
            background-color: rgba(0, 123, 255, 0.3); /* 내 메시지 - 파란색 */
        }

        .bubbleDate {
            width: 15%;
            font-size: 12px;
            align-self: flex-end;
            padding-left: 4px;
        }

        .bubbleArea.myMsg .bubbleDate {
            padding-left: 0;
            padding-right: 4px; /* 오른쪽에 여백 추가 */
            text-align: right;  /* 오른쪽 정렬 */
        }
    </style>
</head>
<body>
<div class="headerArea">
    <div>
        <a href="#" onclick="window.close()">
            <i class="bi bi-x-lg"></i>
        </a>
        <img class="mx-2" height="30px" src="<c:url value="/imgs/Altspace_lightmode_Horizontal.png"/>" alt="Logo">
    </div>
    <div id="status" style="font-size: 14px;">
        접속대기중
    </div>
</div>
<div class="chatArea">
    <div class="notice px-2 py-2 mb-2">
        <i class="bi bi-megaphone"></i>
        <span class="pl-3">현금 유도, 제3자 거래 사기에 주의하세요.</span>
    </div>

    <%--수신자 프로파일 영역--%>
    <div class="senderProfile" data-id="efd0de09">
        <span style="font-weight: bold; font-size: 14px;" class="ms-1">efd0de09</span>
        <span style="font-size: 12px;" class="text-muted">재리스플래닛 호텔 강남</span>
    </div>
    <div class="bubbleArea">
        <div class="bubbleMsg">
            수신 받은 메시지 샘플입니다.
        </div>
        <div class="bubbleDate">오전 9:25</div>
    </div>
    <div class="bubbleArea myMsg">
        <div class="bubbleMsg">
            내가 보낸 메시지 샘플입니다.
        </div>
        <div class="bubbleDate">오전 9:24</div>
    </div>
    <hr>
</div>
<div class="inputArea">
    <input id="target" type="text" maxlength="8" class="targetInput" value="" placeholder="받는 분" required>
    <textarea class="px-3 ms-2" id="totext" placeholder="메시지를 입력해주세요."></textarea>
    <button id="sendto" class="btn">전송</button>
</div>
<div id="adm_id" style="display: none;">${sessionScope.user.userId}</div>

<script>
    let websocket = {
        id:'',
        stompClient:null,
        init:function(){
            this.id = $('#adm_id').text();
            this.connect(); // 채팅방 접속시 바로 connect

            // 보내기
            $('#sendto').click(()=>{
                // '받는 분' 필드가 비어있거나 유효한 아이디가 아니면(8글자) send 중단
                let targetVal = $('#target').val().trim();
                if (targetVal === '' || targetVal == null) {
                    alert('메시지를 받는 분이 선택되지 않았습니다');
                    return;
                }
                if (targetVal.length !== 8) {
                    alert('받는 분의 아이디가 유효하지 않습니다. 다시 확인해주세요!');
                    return;
                }

                // 메시지 컨텐츠
                const content = $('#totext').val();
                if (!content.trim()) {
                    alert('메시지가 입력되지 않았습니다.');
                    return;
                }

                // 현재 시간을 UTC+9로 변환
                const now = new Date();
                const kstOffset = 9 * 60 * 60 * 1000; // 9시간을 밀리초로 변환
                const kstDate = new Date(now.getTime() + kstOffset);
                const sentAt = kstDate.toISOString().replace("Z", "+09:00");  // KST로 전송

                const msg = JSON.stringify({
                    'senderId' : this.id,
                    'receiverId' : $('#target').val(),
                    'accName' : "호스트",
                    'content' : content,
                    'sentAt' : sentAt
                });
                this.stompClient.send('/pub/receiveto', {}, msg);

                // 화면에 내 메시지 추가
                const bubbleHTML = websocket.makeMyBubble(msg);
                $(".chatArea").append(bubbleHTML);
                $(".chatArea").scrollTop($(".chatArea")[0].scrollHeight);  // 최신 메시지로 스크롤

                $('#totext').val('');  // 입력창 초기화
            });

            // 입력창에서 엔터키 -> 보내기
            $('#totext').on('keydown', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault(); // 기본 엔터키 동작 방지
                    $('#sendto').click();
                }
            });

            // 수신메시지의 아이디 부분을 클릭하면 -> 입력창에 채우기
            $(document).on('click', '.senderProfile', function() {
                const senderId = $(this).data('id');
                $('#target').val(senderId);
            });
        },
        connect:function(){
            let sid = this.id;
            let socket = new SockJS('${serverUrl}/chat');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function(frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                // 수신 (sub)
                this.subscribe('/sub/to/'+sid, function(msg) {
                    const bubbleHTML = websocket.makeBubble(msg.body);
                    $(".chatArea").append(bubbleHTML);
                    $(".chatArea").scrollTop($(".chatArea")[0].scrollHeight);  // 최신 메시지로 스크롤
                });
            });
        },
        disconnect:function(){
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            websocket.setConnected(false);
            console.log("Disconnected");
        },
        setConnected:function(connected){
            if (connected) {
                $("#status").text("수신대기중").css('color', 'green');
            } else {
                $("#status").text("연결끊김").css('color', 'red');
            }
        },
        makeMyBubble:function(msg){
            // 내가 보낸 메시지
            let parsedMsg = JSON.parse(msg);

            // 줄바꿈을 <br>로 변환
            const formattedContent = parsedMsg.content.replace(/\n/g, '<br>');

            let bubble = "";
            bubble += `<div class="bubbleArea myMsg">`
            bubble += `  <div class="bubbleMsg">`;
            bubble +=  formattedContent;
            bubble += `  </div>`;
            bubble += `  <div class="bubbleDate">`;
            bubble += this.formatTime(parsedMsg.sentAt);
            bubble += `  </div>
                        </div>`;
            return bubble;
        },
        makeBubble:function(msg) {
            // 수신 받은 메시지
            let parsedMsg = JSON.parse(msg);

            // 줄바꿈을 <br>로 변환
            const formattedContent = parsedMsg.content.replace(/\n/g, '<br>');

            // sender Profile
            let sender = "";
            sender += `<div class="senderProfile" data-id="`;
            sender += parsedMsg.senderId;
            sender += `"> <span style="font-weight: bold; font-size: 14px;" class="ms-1">`;
            sender += parsedMsg.senderId;
            sender += `  </span>`;
            sender += `  <span style="font-size: 12px;" class="text-muted">`;
            sender += parsedMsg.accName;
            sender += `  </span>
                       </div>`;

            // content (bubble)
            let bubble = "";
            bubble += `<div class="bubbleArea">
                         <div class="bubbleMsg">`;
            bubble += formattedContent;
            bubble += `  </div>`;
            bubble += `  <div class="bubbleDate">`;
            bubble += this.formatTime(parsedMsg.sentAt);
            bubble += `  </div>
                        </div>`;
            return sender + bubble;
        },
        formatTime: function (isoString) {
            const date = new Date(isoString);
            const options = {
                hour: 'numeric',
                minute: 'numeric',
                hour12: true,
                timeZone: 'Asia/Seoul'  // KST로 맞춤
            };
            return new Intl.DateTimeFormat('ko-KR', options).format(date);
        }
    };
    $(function () {
        websocket.init();
        // 닫히거나 새로고침 되기 직전에 호출됨
        window.onbeforeunload = function () {
            if (websocket.stompClient) {
                websocket.stompClient.disconnect();
            }
            websocket.setConnected(false);
        };
    });
</script>

</body>
</html>