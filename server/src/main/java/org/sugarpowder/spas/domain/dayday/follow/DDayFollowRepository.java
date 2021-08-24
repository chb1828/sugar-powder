package org.sugarpowder.spas.domain.dayday.follow;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DDayFollowRepository extends JpaRepository<DDayFollowEntity, Long> {
    void deleteAllByDdayId(Long ddayId);
    List<DDayFollowEntity> findAllByUserToken(String userToken);
    Boolean existsByDdayIdAndUserToken(Long ddayId, String userToken);
    void deleteByUserTokenAndAndDdayId(String userToken, Long ddayId);
    void deleteByUserToken(String userToken);
    Long countByDdayId(Long id);
}
