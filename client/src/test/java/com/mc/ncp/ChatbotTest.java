package com.mc.ncp;

import com.mc.util.ChatBotUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class ChatbotTest {

	@Value("${ncp.chatbot.url}")
	String url;
	@Value("${ncp.chatbot.key}")
	String key;

	@Test
	void contextLoads() throws Exception {
		String ko = "파파고와 친해";
		String result = ChatBotUtil.getMsg(url,key,ko);
		log.info("----------------" + result);
	}

}