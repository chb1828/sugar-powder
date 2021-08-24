package org.sugarpowder.spas.domain.noti;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "notification")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotificationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "dday_id")
    private Long ddayId;
    private String userToken;
    private String deviceToken;
    @Column(name = "push_datetime")
    private LocalDateTime pushDatetime;

}
