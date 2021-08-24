package org.sugarpowder.spas.domain.dayday.report;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "dday_report")
public class DDayReportEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userToken;
    private Long ddayId;
}
