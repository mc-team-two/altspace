package com.mc.common.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum AuthMessage {
    // 회원가입 과정
    SIGNUP_SUCCESS("회원가입이 완료되었습니다", HttpStatus.OK),
    SIGNUP_BAD_REQUEST("비정상적인 요청입니다.", HttpStatus.BAD_REQUEST),
    SIGNUP_FAIL("회원가입이 완료되지 않았습니다.", HttpStatus.INTERNAL_SERVER_ERROR),

    // 로그인 (너무 세부적으로 에러 알려주지 X)
    LOGIN_SUCCESS("로그인 성공", HttpStatus.OK),
    LOGIN_BAD_REQUEST("이메일 또는 비밀번호가 틀렸습니다.", HttpStatus.BAD_REQUEST),
    LOGIN_NOT_FOUND("이메일 또는 비밀번호가 틀렸습니다.", HttpStatus.NOT_FOUND),
    LOGIN_FAIL_SOCIAL("소셜 로그인으로 가입한 회원입니다.", HttpStatus.UNPROCESSABLE_ENTITY),

    // 회원 정보 수정
    USER_MODIFY_SUCCESS("회원 정보가 수정되었습니다.", HttpStatus.OK),
    
    // 회원 탈퇴
    USER_DELETE_SUCCESS("회원 탈퇴가 완료되었습니다.", HttpStatus.OK),
    USER_DELETE_FAIL("회원 탈퇴가 완료되지 않았습니다.", HttpStatus.INTERNAL_SERVER_ERROR),

    // 계정 찾기
    FIND_ACCOUNT_SUCCESS("임시 비밀번호가 가입한 메일 주소로 전송되었습니다.", HttpStatus.OK),

    // 이메일 관련
    EMAIL_NOTFOUND("해당 이메일로 가입한 회원이 없습니다.", HttpStatus.NOT_FOUND),
    EMAIL_CONFLICT("이미 사용중인 이메일입니다.", HttpStatus.CONFLICT),
    EMAIL_AVAILABLE("사용 가능한 이메일 주소입니다.", HttpStatus.OK),

    // 비밀번호 변경
    PWD_CHANGE_SUCCESS("비밀번호가 변경되었습니다.", HttpStatus.OK),
    PWD_CHANGE_BAD_REQUEST("기존 비밀번호가 틀렸습니다.", HttpStatus.BAD_REQUEST);

    private final String message;
    private final HttpStatus status;

    AuthMessage(String message, HttpStatus status) {
        this.message = message;
        this.status = status;
    }
}
