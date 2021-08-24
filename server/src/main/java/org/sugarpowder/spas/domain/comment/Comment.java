package org.sugarpowder.spas.domain.comment;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.sugarpowder.spas.domain.dayday.DDayEntity;

import java.time.LocalDateTime;

@Data
public class Comment {

    private Long id;
    private String comment;
    private String nickname;
    private boolean isOwner;
    private boolean isCreator;
    private LocalDateTime createTime;

    public static Comment of(CommentEntity commentEntity, String nickname, DDayEntity dayEntity, String userToken) {
        Comment comment = new Comment();
        comment.setId(commentEntity.getId());
        comment.setComment(commentEntity.getComment());
        comment.setOwner(commentEntity.getUserToken().equals(userToken));
        comment.setCreator(commentEntity.getUserToken().equals(dayEntity.getToken()));
        comment.setNickname(nickname);
        comment.setCreateTime(commentEntity.getCreatedDate());
        return comment;
    }

    @Data
    @ApiModel("comment.Create")
    public static class Create {
        private Long ddayId;
        private String comment;
        private String userToken;
    }

    @Data
    @ApiModel("comment.Update")
    public static class Update {
        private Long ddayId;
        private Long id;
        private String comment;
        private String userToken;
    }

}
