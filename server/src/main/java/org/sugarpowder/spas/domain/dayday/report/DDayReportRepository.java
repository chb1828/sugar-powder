package org.sugarpowder.spas.domain.dayday.report;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DDayReportRepository extends JpaRepository<DDayReportEntity, Long> {
    int countByDdayId(Long ddayId);
}
