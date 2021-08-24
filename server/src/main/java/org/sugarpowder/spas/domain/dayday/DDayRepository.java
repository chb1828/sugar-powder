package org.sugarpowder.spas.domain.dayday;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface DDayRepository extends JpaRepository<DDayEntity,Long> {
    List<DDayEntity> findByDayTypeAndDdayDateBetween(DDayType dDayType, LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);
    List<DDayEntity> findByDayTypeAndDdayDateBetween(DDayType dDayType, LocalDateTime startDate, LocalDateTime endDate);
    List<DDayEntity> findByToken(String userToken);
}
