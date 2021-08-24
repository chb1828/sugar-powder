package org.sugarpowder.spas.infrastructure;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.sugarpowder.spas.domain.shared.dto.JSONResult;

@ControllerAdvice
public class ControllerAdviceHandler {

    @ExceptionHandler(value = Exception.class)
    public ResponseEntity<JSONResult> handleIllegalArgumentException(Exception e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(JSONResult.fail(e.getMessage()));
    }

}
