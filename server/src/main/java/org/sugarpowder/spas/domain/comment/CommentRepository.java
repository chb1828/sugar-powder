package org.sugarpowder.spas.domain.comment;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {

    Page<CommentEntity> findByDdayId(Long ddayId, Pageable pageable);
    void deleteByDdayId(Long ddayId);
}
