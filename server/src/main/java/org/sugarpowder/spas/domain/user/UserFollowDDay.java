package org.sugarpowder.spas.domain.user;

import org.sugarpowder.spas.domain.shared.DateAudit;

import javax.persistence.*;

@Entity
public class UserFollowDDay extends DateAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long userId;       //Querydsl 로 조인?

    private Long ddayId;
}
