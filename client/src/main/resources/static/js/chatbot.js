$(function () {
    const chatbotUI = {
        chatIcon: $('#chat-icon'),
        chatWindow: $('#chat-window'),
        chatInput: $('#chat-input'),
        chatMessages: $('#chat-messages'),
        chatSendBtn: $('#chat-send-btn'),
        chatCloseBtn: $('#chat-close-btn'),

        init: function () {
            this.chatIcon.on('click', () => {
                if (chatbotUI.chatWindow.css('display') === 'none') {
                    chatbotUI.chatWindow.css('display', 'flex');
                } else {
                    chatbotUI.chatWindow.css('display', 'none');
                }
            });

            this.chatCloseBtn.on('click', () => {
                this.chatWindow.hide();
            });

            this.chatSendBtn.on('click', () => chatbotClient.sendMessage());

            this.chatInput.on('keypress', (e) => {
                if (e.which === 13) chatbotClient.sendMessage();
            });
        },

        displayMessage: function (message, sender) {
            const container = $('<div class="message-container ' + sender + '"></div>');
            const messageDiv = $('<div class="' + sender + '-message"></div>').text(message);
            container.append(messageDiv);
            this.chatMessages.append(container);
            this.scrollToBottom();
        },

        scrollToBottom: function () {
            this.chatMessages.scrollTop(this.chatMessages.prop('scrollHeight'));
        }
    };

    const chatbotClient = {
        id: (() => {
            let id = localStorage.getItem('chatbot_id');
            if (!id) {
                id = 'guest_' + crypto.randomUUID();
                localStorage.setItem('chatbot_id', id);
            }
            console.log('📦 프론트 구독 ID:', id);
            return id;
        })(),
        stompClient: null,

        init: function () {
            chatbotUI.init();
            this.connect();
        },

        connect: function () {
            const socket = new SockJS('http://127.0.0.1:8080/chatbot', null, {
                withCredentials: true
            });
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, (frame) => {
                this.setConnected(true);
                console.log('Connected: ' + frame);
                this.stompClient.subscribe('/sendto/' + this.id, (msg) => {
                    try {
                        const data = JSON.parse(msg.body);
                        chatbotUI.displayMessage(data.content1 || '[응답 없음]', 'bot');
                    } catch (e) {
                        console.error('메시지 파싱 실패', e);
                        chatbotUI.displayMessage('[챗봇 응답 오류]', 'bot');
                    }
                });
            }, (error) => {
                console.error('Could not connect to WebSocket server:', error);
            });
        },

        disconnect: function () {
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            this.setConnected(false);
            console.log('Disconnected');
        },

        setConnected: function (connected) {
            $('#status').text(connected ? 'Connected' : 'Disconnected');
        },

        sendMessage: function () {
            const message = chatbotUI.chatInput.val().trim();
            if (message) {
                chatbotUI.displayMessage(message, 'user');
                const msgToSend = JSON.stringify({
                    sendid: this.id,
                    content1: message
                });
                this.stompClient.send('/app/sendchatbot', {}, msgToSend);
                chatbotUI.chatInput.val('');
            }
        },

        displayBotMessage: function (message) {
            chatbotUI.displayMessage(message, 'bot');
        },

        displayUserMessage: function (message) {
            chatbotUI.displayMessage(message, 'user');
        }
    };

    chatbotClient.init();
});
