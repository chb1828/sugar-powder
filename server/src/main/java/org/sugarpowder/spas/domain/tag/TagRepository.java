package org.sugarpowder.spas.domain.tag;

import org.springframework.data.jpa.repository.JpaRepository;
import org.sugarpowder.spas.domain.dayday.DDayEntity;

public interface TagRepository extends JpaRepository<TagEntity,Long> {
    void deleteBydday(DDayEntity dDayEntity);
}
