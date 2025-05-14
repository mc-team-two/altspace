package com.mc.app.msg;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Msg {
    private String senderId;
    private String receiverId;
    private String accName;
    private String content;
    private String sentAt;
}