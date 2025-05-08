<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    #to {
        width: 400px;
        height: 200px;
        overflow: auto;
        border: 2px solid green;
    }
</style>

<script>
    let websocket = {
        id:'',
        stompClient:null,
        init:function(){
            this.id = $('#adm_id').text();
            this.connect();
            $('#connect').click(()=>{
                this.connect();
            });
            $('#disconnect').click(()=>{
                this.disconnect();
            });
            $('#sendto').click(()=>{
                const content = $('#totext').val();
                if (!content.trim()) return; // 빈 메시지 전송 방지v

                // publish
                const msg = JSON.stringify({
                    'sendid' : this.id,
                    'receiveid' : $('#target').val(),
                    'content1' : content,
                    'sentAt' : new Date().toISOString() // ISO 형식으로 전송
                });
                console.log(msg);
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
                // subscribe
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

<div class="col-sm-12 mx-auto">
    <p class="text-muted mb-4 fs-6">
        호스트 센터 &nbsp;&nbsp;>&nbsp;&nbsp; <strong>고객 메시지</strong>
    </p>
    <div class="card">
        <div class="card-body">
        <div class="col-sm-5">
            <h1 id="adm_id">${sessionScope.user.userId}</h1>
            <H1 id="status">Status</H1>
            <button id="connect">Connect</button>
            <button id="disconnect">Disconnect</button>

            <input type="text" id="target" value="aaebc224">
            <input type="text" id="totext"><button id="sendto">전송</button>
            <div id="to"></div>

        </div>
        </div>
    </div>
</div>