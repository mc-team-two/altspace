let socket = new SockJS("/viewing");
let stompClient = Stomp.over(socket);

stompClient.connect({}, function (frame) {
    console.log("✅ WebSocket 연결됨:", frame);

    // 입장/퇴장 이벤트 받기
    stompClient.subscribe("/sub/viewing", function (message) {
        const msg = JSON.parse(message.body);
        console.log("📢 입장/퇴장 이벤트:", msg);

        // 예: 알림 표시
        showNotification(msg);
    });

    // 예: 페이지 들어오면 바로 입장 알림 보내기
    const enterMsg = {
        userId: "user123",
        accommId: "accom456",
        content1: "입장!" // 필요에 따라 내용 구성
    };
    stompClient.send("/pub/enteraccom", {}, JSON.stringify(enterMsg));

    // 페이지에서 나갈 때
    window.addEventListener("beforeunload", () => {
        const leaveMsg = {
            userId: "user123",
            accommId: "accom456",
            content1: "퇴장!"
        };
        stompClient.send("/pub/leaveaccom", {}, JSON.stringify(leaveMsg));

        // 웹소켓 연결 해제
        if (stompClient && stompClient.connected) {
            stompClient.disconnect(() => {
                console.log("🚪 웹소켓 연결 종료!");
            });
        }
    });
}); // <-- 여기에 중괄호가 빠졌을 가능성!

function showNotification(msg) {
    if (msg.userId === "system") {
        const viewingInfo = document.getElementById("viewing-info");
        if (viewingInfo) {
            viewingInfo.textContent = msg.content1;
        }
    } else {
        console.log(`💡 사용자 ${msg.userId}가 ${msg.content1}`);
    }
}