package org.sugarpowder.spas.domain.noti;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class SchedulingConfig {

    private final NotificationService notificationService;

    public SchedulingConfig(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @Scheduled(cron = "0 0 9 * * *")
    public void notificationJob() {
        notificationService.sendNotification();
    }
}
