<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
<head>
  <title>채팅방</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <%-- jQuery CDN --%>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <%-- Bootstrap --%>
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

    .inputArea textarea {
      width: 85%;
      max-height: 100px; /* 최대 높이 (4줄) */
      min-height: 36px;  /* 1줄 높이 */
      height: 36px;      /* 기본 높이 */
      resize: none;
      background-color: #f5f5f9;
      border: none;          /* 테두리 없음 */
      border-radius: 15px;   /* 곡선 유지 */
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
  </style>
</head>
<body>
<div class="headerArea">
  <div>
    <a href="#" onclick="window.close()">
      <i class="bi bi-x-lg"></i>
    </a>
    <span class="ml-2">${acc.name}</span>
  </div>
  <div id="status">
    Status
  </div>
</div>
<div class="chatArea">
  <div id="to"></div>
</div>
<div id="adm_id" style="display: none;">${sessionScope.user.userId}</div>
<div id="target" style="display: none;">${acc.hostId}</div>
<div class="inputArea">
  <textarea id="totext" placeholder="메시지를 입력해주세요."></textarea>
  <button id="sendto" class="btn">전송</button>
</div>

<script>
  let websocket = {
    id:'',
    stompClient:null,
    init:function(){
      this.id = $('#adm_id').text();
      this.connect(); // 채팅방 접속시 바로 connect
      $('#sendto').click(()=>{
        var msg = JSON.stringify({
          'sendid' : this.id,
          'receiveid' : $('#target').text(),
          'content1' : $('#totext').val()
        });
        this.stompClient.send('/pub/receiveto', {}, msg);
      });
    },
    connect:function(){
      let sid = this.id;
      let socket = new SockJS('${serverUrl}/chat');
      this.stompClient = Stomp.over(socket);

      this.stompClient.connect({}, function(frame) {
        websocket.setConnected(true);
        console.log('Connected: ' + frame);
        this.subscribe('/sub/to/'+sid, function(msg) {
          console.log(JSON.parse(msg.body));
          $(".chatArea").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1
                  + "</h4>");
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
        $("#status").text("Connected");
      } else {
        $("#status").text("Disconnected");
      }
    }
  };
  $(function(){
    websocket.init();
    // 닫히거나 새로고침 되기 직전에 호출됨
    window.onbeforeunload = function(){
     websocket.disconnect();
    };
  });
</script>

</body>
</html>