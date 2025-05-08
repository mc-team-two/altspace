package com.mc.app.msg;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Msg {
    private String sendid;
    private String receiveid;
    private String content1;
    private String sentAt;
}