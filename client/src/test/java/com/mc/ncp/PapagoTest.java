package com.mc.ncp;

import com.mc.util.PapagoUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class PapagoTest {

	@Value("${ncp.papago.id}")
	String id;
	@Value("${ncp.papago.key}")
	String key;

	@Test
	void contextLoads() {
		String ko = "오늘 날씨 어때";
		String result = PapagoUtil.getMsg(id,key,ko, "en");
		log.info(result);
	}

}