$(function() {
    const chatbotUI = {
        chatIcon: $('#chat-icon'),
        chatWindow: $('#chat-window'),
        chatInput: $('#chat-input'),
        chatMessages: $('#chat-messages'),
        chatSendBtn: $('#chat-send-btn'),
        chatCloseBtn: $('#chat-close-btn'),

        init: function() {
            this.chatIcon.click(() => this.chatWindow.toggle());
            this.chatCloseBtn.click(() => this.chatWindow.hide());
            this.chatSendBtn.click(() => chatbotClient.sendMessage());
            this.chatInput.keypress((event) => {
                if (event.which === 13) chatbotClient.sendMessage();
            });
        },

        displayMessage: function(message, sender) {
            const messageDiv = $('<div class="' + sender + '-message"></div>').text(message);
            this.chatMessages.append(messageDiv);
            this.scrollToBottom();
        },

        scrollToBottom: function() {
            this.chatMessages.scrollTop(this.chatMessages.prop('scrollHeight'));
        }
    };

    const chatbotClient = {
        id: $('#login_id').text(),
        stompClient: null,

        init: function() {
            chatbotUI.init();
            this.connect();
        },

        connect: function() {
            const socket = new SockJS('/chatbot');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, (frame) => {
                this.setConnected(true);
                console.log('Connected: ' + frame);
                this.stompClient.subscribe('/sendto/' + this.id, (msg) => {
                    chatbotUI.displayMessage(JSON.parse(msg.body).content1, 'bot');
                });
            }, (error) => {
                console.error('Could not connect to WebSocket server:', error);
            });
        },

        disconnect: function() {
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            this.setConnected(false);
            console.log("Disconnected");
        },

        setConnected: function(connected) {
            $("#status").text(connected ? "Connected" : "Disconnected");
        },

        sendMessage: function() {
            const message = chatbotUI.chatInput.val().trim();
            if (message) {
                chatbotUI.displayMessage(message, 'user');
                const msgToSend = JSON.stringify({
                    'sendid': this.id,
                    'content1': message
                });
                this.stompClient.send('/sendchatbot', {}, msgToSend);
                chatbotUI.chatInput.val('');
            }
        },

        displayBotMessage: function(message) {
            chatbotUI.displayMessage(message, 'bot');
        },

        displayUserMessage: function(message) {
            chatbotUI.displayMessage(message, 'user');
        }
    };

    chatbotClient.init();
});