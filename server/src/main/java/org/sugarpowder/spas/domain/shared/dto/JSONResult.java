package org.sugarpowder.spas.domain.shared.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.sugarpowder.spas.domain.dayday.DDay;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class JSONResult<T> {

    private String result; //Success ,Fail
    private String message; // 실패시 message
    private T data; // 성공시 돌려줄 데이터

    public static JSONResult success(ApiResult data) {
        return new JSONResult("success", null, data);
    }

    public static JSONResult success(ApiResult data, String message) {
        return new JSONResult("success", message, data);
    }

    public static JSONResult fail(String message) {
        return new JSONResult("fail", message, null);
    }
}
