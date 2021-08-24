package org.sugarpowder.spas.domain.comment.report;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentReportRepository extends JpaRepository<CommentReportEntity, Long> {

    int countAllByCommentId(Long commentId);
}
