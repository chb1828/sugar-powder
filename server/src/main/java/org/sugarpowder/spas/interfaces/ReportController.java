package org.sugarpowder.spas.interfaces;

import io.swagger.annotations.ApiImplicitParam;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.sugarpowder.spas.domain.report.ReportService;
import org.sugarpowder.spas.domain.shared.dto.JSONResult;

@RestController
@RequestMapping("/api/report")
public class ReportController {

    private final ReportService reportService;

    public ReportController(ReportService reportService) {
        this.reportService = reportService;
    }

    @PostMapping("/dday/{dayId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> reportDday(@RequestHeader("Authorization") String userToken, @PathVariable Long dayId) {
        reportService.reportDday(userToken, dayId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }

    @PostMapping("/comment/{commentId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> reportComment(@RequestHeader("Authorization") String userToken, @PathVariable Long commentId) {
        reportService.reportComment(userToken, commentId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }
}
