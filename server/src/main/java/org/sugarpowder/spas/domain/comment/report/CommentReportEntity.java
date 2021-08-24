package org.sugarpowder.spas.domain.comment.report;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "comment_report")
@Data
public class CommentReportEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userToken;
    private Long commentId;
}
