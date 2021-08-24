package org.sugarpowder.spas.domain.comment;

import lombok.Data;
import org.sugarpowder.spas.domain.dayday.DDayEntity;
import org.sugarpowder.spas.domain.shared.DateAudit;

import javax.persistence.*;

@Entity
@Table(name = "comment")
@Data
public class CommentEntity extends DateAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String comment;

    private String userToken;

    private Long ddayId;

    public static CommentEntity of(Comment.Create createComment) {
        CommentEntity commentEntity = new CommentEntity();
        commentEntity.setComment(createComment.getComment());
        commentEntity.setUserToken(createComment.getUserToken());
        commentEntity.setDdayId(createComment.getDdayId());
        return commentEntity;
    }

    public void update(Comment.Update updateComment) {
        this.setId(updateComment.getId());
        this.setComment(updateComment.getComment());
        this.setUserToken(updateComment.getUserToken());
    }
}
