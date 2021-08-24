package org.sugarpowder.spas.domain.dayday.follow;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "dday_follow")
@Data
public class DDayFollowEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userToken;
    private Long ddayId;
}
