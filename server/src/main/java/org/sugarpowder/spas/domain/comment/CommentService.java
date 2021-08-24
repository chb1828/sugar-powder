package org.sugarpowder.spas.domain.comment;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.sugarpowder.spas.domain.comment.report.CommentReportEntity;
import org.sugarpowder.spas.domain.comment.report.CommentReportRepository;
import org.sugarpowder.spas.domain.dayday.DDayEntity;
import org.sugarpowder.spas.domain.dayday.DDayService;
import org.sugarpowder.spas.domain.user.UserService;

import java.util.stream.Collectors;

@Service
public class CommentService {

    private final CommentRepository commentRepository;
    private final CommentReportRepository commentReportRepository;
    private final DDayService dayService;
    private final UserService userService;

    public CommentService(CommentRepository commentRepository, CommentReportRepository commentReportRepository, DDayService dayService, UserService userService) {
        this.commentRepository = commentRepository;
        this.commentReportRepository = commentReportRepository;
        this.dayService = dayService;
        this.userService = userService;
    }

    public CommentEntity getCommentById(Long id) {
        return commentRepository.findById(id).orElseThrow(() -> { throw new IllegalArgumentException("no comment exists");});
    }

    public CommentList getCommentsByDDayId(Long id, PageRequest pageable, String token) {
        Page<CommentEntity> commentEntities = commentRepository.findByDdayId(id, pageable);
        DDayEntity dayEntity = dayService.getDdayById(id);

        return new CommentList(commentEntities.stream()
                .map(it -> {
                    String nickname = userService.getUser(it.getUserToken()).getNickname();
                    return Comment.of(it, nickname, dayEntity, token);
                }).collect(Collectors.toList())
        , pageable
        ,commentEntities.getTotalElements());
    }

    public void saveComment(Comment.Create createCommment) {
        userService.getUser(createCommment.getUserToken());
        DDayEntity dayEntity = dayService.getDdayById(createCommment.getDdayId());
        CommentEntity commentEntity = CommentEntity.of(createCommment);
        commentRepository.save(commentEntity);
    }

    @Transactional
    public void updateComment(Comment.Update updateComment) {
        CommentEntity commentEntity = commentRepository.findById(updateComment.getId()).orElseThrow(() -> {
            throw new IllegalArgumentException("not exists comment");
        });

        commentEntity.update(updateComment);
    }

    public void deleteComment(Long id) {
        commentRepository.deleteById(id);
    }

    public void reportComment(String userToken, Long commentId) {
        CommentReportEntity reportEntity = new CommentReportEntity();
        reportEntity.setUserToken(userToken);
        reportEntity.setCommentId(commentId);
        commentReportRepository.save(reportEntity);
    }

    public int countCommentReport(Long commentId) {
        return commentReportRepository.countAllByCommentId(commentId);
    }
}
