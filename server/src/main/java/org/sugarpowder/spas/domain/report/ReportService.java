package org.sugarpowder.spas.domain.report;

import org.springframework.stereotype.Service;
import org.sugarpowder.spas.domain.comment.CommentService;
import org.sugarpowder.spas.domain.dayday.DDayService;
import org.sugarpowder.spas.domain.dayday.report.DDayReportRepository;

import javax.transaction.Transactional;

@Service
public class ReportService {
    private final DDayReportRepository dayReportRepository;
    private final DDayService dayService;
    private final CommentService commentService;

    public ReportService(DDayReportRepository dayReportRepository, DDayService dayService, CommentService commentService) {
        this.dayReportRepository = dayReportRepository;
        this.dayService = dayService;
        this.commentService = commentService;
    }

    @Transactional
    public void reportDday(String userToken, Long ddayId) {
        dayService.getDdayById(ddayId);
        dayService.reportDDay(userToken, ddayId);

        int count = dayService.countDdayReport(ddayId);

        if (count >= 3) {
            dayService.deleteDday(dayService.getDdayById(ddayId));
        }
    }

    @Transactional
    public void reportComment(String userToken, Long commentId) {
        commentService.getCommentById(commentId);
        commentService.reportComment(userToken, commentId);
        int count = commentService.countCommentReport(commentId);

        if (count >= 3) {
            commentService.deleteComment(commentId);
        }
    }
}
