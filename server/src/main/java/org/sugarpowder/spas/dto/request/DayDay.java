package org.sugarpowder.spas.dto.request;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class DayDay {
    private int daydayId;
    private String emoji;
    private String title;
    private String description;
    private LocalDateTime createdAt;
}
