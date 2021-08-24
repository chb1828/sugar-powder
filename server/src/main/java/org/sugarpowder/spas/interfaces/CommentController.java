package org.sugarpowder.spas.interfaces;

import io.swagger.annotations.ApiImplicitParam;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.sugarpowder.spas.domain.comment.Comment;
import org.sugarpowder.spas.domain.comment.CommentList;
import org.sugarpowder.spas.domain.comment.CommentService;
import org.sugarpowder.spas.domain.shared.dto.JSONResult;

@RestController
@RequestMapping("/api/comments")
public class CommentController {

    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @GetMapping("/{ddayId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult<CommentList>> getCommentsByDday(@RequestHeader("Authorization") String userToken,
                                                                     @PathVariable Long ddayId, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
        CommentList commentEntities = commentService.getCommentsByDDayId(ddayId, PageRequest.of(page, size), userToken);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(commentEntities, ""));
    }

    @PostMapping
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> saveComment(@RequestBody Comment.Create createComment) {
        commentService.saveComment(createComment);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }

    @PutMapping("/{commentId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> updateComment(@RequestBody Comment.Update updateComment) {
        commentService.updateComment(updateComment);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }

    @DeleteMapping("/{commentId}")
    @ApiImplicitParam(paramType = "header", name = "Authorization", required = true, allowEmptyValue = false, example = "token")
    public ResponseEntity<JSONResult> deleteComment(@PathVariable Long commentId) {
        commentService.deleteComment(commentId);
        return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(null, ""));
    }
}
