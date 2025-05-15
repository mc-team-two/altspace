$(function () {
    const geminiUI = {
        chatIcon: $('#gemini-chat-icon'),
        chatWindow: $('#gemini-chat-window'),
        chatInput: $('#gemini-chat-input'),
        chatMessages: $('#gemini-chat-messages'),
        chatSendBtn: $('#gemini-chat-send-btn'),
        chatCloseBtn: $('#gemini-chat-close-btn'),

        init: function () {
            // ✅ 일반 챗봇 패널 상태를 감지하여 Gemini 아이콘 위치 조정
            this.observeChatbotPanel();

            this.chatIcon.on('click', () => {
                const isVisible = this.chatWindow.hasClass('active');
                this.chatWindow.toggleClass('active', !isVisible);
            });

            this.chatCloseBtn.on('click', () => {
                this.chatWindow.removeClass('active');
            });

            this.chatSendBtn.on('click', () => geminiClient.sendMessage());

            this.chatInput.on('keypress', (e) => {
                if (e.which === 13) geminiClient.sendMessage();
            });
        },

        // ✅ 일반 챗봇 패널 상태를 관찰하여 Gemini 아이콘 위치 조정
        observeChatbotPanel: function () {
            const chatbotWindow = $('#chat-window');

            // MutationObserver로 클래스 변화 감지
            const observer = new MutationObserver((mutations) => {
                mutations.forEach((mutation) => {
                    if (mutation.attributeName === 'class') {
                        const isActive = chatbotWindow.hasClass('active');
                        this.chatIcon.toggleClass('raised', isActive);
                    }
                });
            });

            observer.observe(chatbotWindow[0], {
                attributes: true,
                attributeFilter: ['class']
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

    const geminiClient = {
        id: (() => {
            let id = localStorage.getItem('gemini_chat_id');
            if (!id) {
                id = 'guest_' + crypto.randomUUID();
                localStorage.setItem('gemini_chat_id', id);
            }
            console.log('Gemini Chat ID:', id);
            return id;
        })(),
        stompClient: null,

        init: function () {
            geminiUI.init();
            this.connect();
        },

        connect: function () {
            // ✅ 엔드포인트 통일 (chatbot.js와 동일하게)
            const socket = new SockJS('/chatbot', null, {
                withCredentials: true
            });
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, (frame) => {
                this.setConnected(true);
                console.log('Connected to Gemini:', frame);
                this.stompClient.subscribe('/sub/gemini', (msg) => {
                    try {
                        const data = JSON.parse(msg.body);
                        geminiUI.displayMessage(data.content || '[응답 없음]', 'bot');
                    } catch (e) {
                        console.error('Gemini 응답 파싱 실패', e);
                        geminiUI.displayMessage('[챗봇 오류 발생]', 'bot');
                    }
                });
            }, (error) => {
                console.error('Gemini WebSocket 연결 실패:', error);
            });
        },

        sendMessage: function () {
            const message = geminiUI.chatInput.val().trim();
            if (message) {
                geminiUI.displayMessage(message, 'user');
                const msgToSend = JSON.stringify({
                    sender: this.id,
                    content: message
                });
                this.stompClient.send('/app/geminichat', {}, msgToSend);
                geminiUI.chatInput.val('');
            }
        },

        setConnected: function (connected) {
            $('#status').text(connected ? 'Connected' : 'Disconnected');
        }
    };

    geminiClient.init();
});