package org.sugarpowder.spas.interfaces;

import io.swagger.annotations.ApiImplicitParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.sugarpowder.spas.domain.dayday.DDayEntity;
import org.sugarpowder.spas.domain.dayday.DDayService;
import org.sugarpowder.spas.domain.shared.dto.JSONResult;
import org.sugarpowder.spas.domain.user.User;
import org.sugarpowder.spas.domain.user.UserService;

import javax.transaction.Transactional;
import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/user")
public class UserController {

    final UserService userService;
    private final DDayService dayService;

    public UserController(UserService userService, DDayService dayService) {
        this.userService = userService;
        this.dayService = dayService;
    }

    @GetMapping
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<User>> getUser(@RequestParam String token) {
        log.info("get user request: {}", token);
        User user = userService.getUser(token);
        log.info("get user : {}", user.getToken());
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(user, "user 조회 성공"));
    }

    @PostMapping
    public ResponseEntity<JSONResult<User>> registerUser(@RequestBody @Valid User.Create user) {
        log.info("register request: {} ", user);
        User userResult = userService.registerUser(user);
        log.info("register user : {}", user.getToken());

        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(userResult, "user 등록 성공"));
    }

    @PutMapping
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> updateUser(@RequestBody @Valid User.Update user) {
        userService.updateUser(user);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, "user 수정 성공"));
    }

    @DeleteMapping
    @Transactional
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> deleteUser(@RequestBody @Valid User.Delete user) {
        log.info("delete user start: {}", user.getToken());
        User user1 = userService.getUser(user.getToken());

        log.info("delete target user : {}", user1);
        List<DDayEntity> entities = dayService.findByToken(user.getToken());
        for (DDayEntity dayEntity : entities) {
            dayService.deleteDday(dayEntity);
        }

        dayService.deleteFollowDdays(user.getToken());
        userService.deleteUser(user);
        log.info("delete user end: {}", user.getToken());
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, "user 삭제 성공"));
    }

}
