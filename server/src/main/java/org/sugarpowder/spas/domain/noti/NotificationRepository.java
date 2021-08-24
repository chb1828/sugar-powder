package org.sugarpowder.spas.domain.noti;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<NotificationEntity, Long> {

    List<NotificationEntity> findAllByPushDatetimeBetween(LocalDateTime start, LocalDateTime end);
    boolean existsByDdayIdAndUserToken(Long ddayId, String userToken);
    void deleteByDdayId(Long ddayId);
    void deleteByUserToken(String userToken);
    void deleteByDdayIdAndUserToken(Long ddayId, String userToken);
}
