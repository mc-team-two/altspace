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

  <%-- WebSocket Libraries --%>
  <script src="<c:url value="/webjars/sockjs-client/sockjs.min.js"/>"></script>
  <script src="<c:url value="/webjars/stomp-websocket/stomp.min.js"/>"></script>

  <style>
    #all {
      width: 400px;
      height: 200px;
      overflow: auto;
      border: 2px solid red;
    }

    #me {
      width: 400px;
      height: 200px;
      overflow: auto;
      border: 2px solid blue;
    }

    #to {
      width: 400px;
      height: 200px;
      overflow: auto;
      border: 2px solid green;
    }
  </style>
</head>
<body>
<div class="col-sm-12 mx-auto">
  <div class="card">
    <div class="card-body">
      <div class="col-sm-5">
        <h1 id="adm_id">${sessionScope.user.userId}</h1>
        <H1 id="status">Status</H1>
        <button id="connect">Connect</button>
        <button id="disconnect">Disconnect</button>

        <h3>All</h3>
        <input type="text" id="alltext"><button id="sendall">Send</button>
        <div id="all"></div>

        <h3>Me</h3>
        <input type="text" id="metext"><button id="sendme">Send</button>
        <div id="me"></div>

        <h3>To</h3>
        <input type="text" id="target">
        <input type="text" id="totext"><button id="sendto">Send</button>
        <div id="to"></div>

      </div>
    </div>
  </div>
</div>

<script>
  let websocket = {
    id:'',
    stompClient:null,
    init:function(){
      this.id = $('#adm_id').text();
      $('#connect').click(()=>{
        this.connect();
      });
      $('#disconnect').click(()=>{
        this.disconnect();
      });
      $('#sendall').click(()=>{
        let msg = JSON.stringify({
          'sendid' : this.id,
          'content1' : $("#alltext").val()
        });
        this.stompClient.send("/pub/receiveall", {}, msg);
      });
      $('#sendme').click(()=>{
        let msg = JSON.stringify({
          'sendid' : this.id,
          'content1' : $("#metext").val()
        });
        this.stompClient.send("/pub/receiveme", {}, msg);
      });
      $('#sendto').click(()=>{
        var msg = JSON.stringify({
          'sendid' : this.id,
          'receiveid' : $('#target').val(),
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
        this.subscribe('/sub', function(msg) {
          $("#all").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1
                  + "</h4>");
        });
        this.subscribe('/sub/'+sid, function(msg) {
          $("#me").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1+ "</h4>");
        });
        this.subscribe('/sub/to/'+sid, function(msg) {
          $("#to").prepend(
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
  });
</script>

</body>
</html>