package com.mc.common.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ResponseMessage {
    // 작업 성공
    SUCCESS("성공적으로 처리되었습니다.", HttpStatus.OK),

    // 작업 실패
    ERROR("서버에 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR),
    FAIL("요청을 처리할 수 없습니다.", HttpStatus.UNPROCESSABLE_ENTITY),
    CONFLICT("요청이 충돌로 인해 실패했습니다.", HttpStatus.CONFLICT),
    BAD_REQUEST("요청 형식이 올바르지 않습니다.", HttpStatus.BAD_REQUEST),
    NOTFOUND("요청한 리소스를 찾을 수 없습니다.", HttpStatus.NOT_FOUND),

    // 권한 관련
    UNAUTHORIZED("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED),
    FORBIDDEN("허가되지 않은 요청입니다.", HttpStatus.FORBIDDEN);

    private final String message;
    private final HttpStatus status;

    ResponseMessage(String message, HttpStatus status) {
        this.message = message;
        this.status = status;
    }
}
