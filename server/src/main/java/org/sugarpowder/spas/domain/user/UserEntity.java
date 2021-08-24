package org.sugarpowder.spas.domain.user;

import lombok.Getter;
import lombok.Setter;
import org.sugarpowder.spas.domain.shared.DateAudit;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user")
@Setter
@Getter
public class UserEntity extends DateAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nickname;

    private String token;

    private String deviceToken;

    private LocalDateTime lastVisited;

    private boolean notiYn;

    public static UserEntity of(User.Create user) {
        UserEntity userEntity = new UserEntity();
        userEntity.setToken(user.getToken());
        userEntity.setNickname(user.getNickname());
        userEntity.setDeviceToken(user.getDeviceToken());
        userEntity.setLastVisited(LocalDateTime.now());
        userEntity.setCreatedDate(LocalDateTime.now());
        userEntity.setNotiYn(user.isNotiYn());
        return userEntity;
    }
}
