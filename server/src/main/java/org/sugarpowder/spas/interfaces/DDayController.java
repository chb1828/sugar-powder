package org.sugarpowder.spas.interfaces;

import io.swagger.annotations.ApiImplicitParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.sugarpowder.spas.domain.dayday.*;
import org.sugarpowder.spas.domain.noti.NotificationService;
import org.sugarpowder.spas.domain.shared.dto.JSONResult;
import org.sugarpowder.spas.domain.user.UserService;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/dday")
public class DDayController {

    private final DDayService dDayService;
    private final NotificationService notificationService;
    private final UserService userService;

    public DDayController(DDayService dDayService, NotificationService notificationService, UserService userService) {
        this.dDayService = dDayService;
        this.notificationService = notificationService;
        this.userService = userService;
    }

    @GetMapping
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<DDayList>> getFollowDdays(@RequestHeader("Authorization") String userToken,
                                                               @RequestParam(defaultValue = "0") int page,
                                                               @RequestParam(defaultValue = "10") int size,
                                                               @RequestParam(defaultValue = "CREATE") DaySort daySort,
                                                               @RequestParam(defaultValue = "true") boolean isIncludeEnd) {
        log.info("user dday : {} ", userToken);
        DDayList dayList = dDayService.getUserFollowedDDays(userToken, PageRequest.of(page, size), daySort, isIncludeEnd);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(dayList, ""));
    }

    @GetMapping("/{dayId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<DDay>> getDDayById(@RequestHeader("Authorization") String userToken, @PathVariable Long dayId) {
        DDayEntity dDayEntity = dDayService.getDdayById(dayId);
        boolean isNoti = notificationService.isNotiOn(userToken, dayId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(DDay.of(dDayEntity, userToken, dDayService.countFollower(dayId), userService.getUser(dDayEntity.getToken()).getNickname(), isNoti), ""));
    }

    @PostMapping("/{dayId}/follow")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> followDday(@PathVariable Long dayId, @RequestHeader("Authorization") String userToken) {
        dDayService.followDday(userToken, dDayService.getDdayById(dayId), dayId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }

    @GetMapping("/{dayId}/follow")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public Boolean isFollowedDday(@PathVariable Long dayId, @RequestHeader("Authorization") String userToken) {
        return dDayService.isFollowed(userToken, dayId);
    }

    @PostMapping("/{dayId}/unfollow")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> unFollowDday(@PathVariable Long dayId, @RequestHeader("Authorization") String userToken) {
        dDayService.unFollowDday(userToken, dayId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }

    @PostMapping
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<DDay>> saveDDay(@RequestHeader("Authorization") String userToken, @RequestBody DDay.Create dday) {
        DDayEntity dDayEntity = dDayService.saveDday(dday);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(DDay.of(dDayEntity, userToken, null, userService.getUser(dDayEntity.getToken()).getNickname(), true), ""));
    }

    @PutMapping("/{dayId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<DDay>> updateDDay(@RequestHeader("Authorization") String userToken, @PathVariable Long dayId, @RequestBody DDay.Update dday) {
        DDayEntity dDayEntity = dDayService.updateDday(dayId, userToken, dday);
        boolean isNoti = notificationService.isNotiOn(userToken, dayId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(DDay.of(dDayEntity, userToken, null, userService.getUser(dDayEntity.getToken()).getNickname(), isNoti), ""));
    }

    @DeleteMapping("/{dayId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<DDay>> deleteDDay(@PathVariable Long dayId) {
        dDayService.deleteDday(dDayService.getDdayById(dayId));
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }

    @PostMapping("/{dayId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public void notiDday(@RequestHeader("Authorization") String userToken, @RequestParam(defaultValue = "true") boolean notiYn, Long ddayId) {
        if (notiYn) {
            notificationService.saveNotification(userService.getUser(userToken), dDayService.getDdayById(ddayId));
        } else {
            notificationService.deleteNotificationByDDayIdAndUserToken(ddayId, userToken);
        }
    }
}
