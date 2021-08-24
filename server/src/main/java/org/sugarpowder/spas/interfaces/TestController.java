package org.sugarpowder.spas.interfaces;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.sugarpowder.spas.domain.shared.dto.JSONResult;

@RestController
@RequestMapping("/test")
public class TestController {

    @GetMapping
    public ResponseEntity<JSONResult> test() {
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null,"슈가 파우더의 3번째 테스트 성공"));
    }
}
