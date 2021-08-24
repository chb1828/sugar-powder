package org.sugarpowder.spas.domain.noti;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.sugarpowder.spas.domain.dayday.DDayEntity;
import org.sugarpowder.spas.domain.dayday.DDayRepository;
import org.sugarpowder.spas.domain.dayday.follow.DDayFollowRepository;
import org.sugarpowder.spas.domain.user.User;
import org.sugarpowder.spas.domain.user.UserEntity;
import org.sugarpowder.spas.domain.user.UserRepository;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class NotificationService {

    private final NotificationRepository notificationRepository;
    private final DDayFollowRepository dDayFollowRepository;
    private final UserRepository userRepository;
    private final DDayRepository dayRepository;

    private final List<Integer> pushDays = Arrays.asList(7, 1, 0);
    private final List<String> comment = Arrays.asList(
            "일주일 밖에 안남았어요",
            "내일이에요. 기대되지 않나요?",
            "드디어 오늘이네요. 설레는 하루 보내세요."
    );

    public NotificationService(NotificationRepository notificationRepository, DDayFollowRepository dDayFollowRepository, UserRepository userRepository, DDayRepository dayRepository) {
        this.notificationRepository = notificationRepository;
        this.dDayFollowRepository = dDayFollowRepository;
        this.userRepository = userRepository;
        this.dayRepository = dayRepository;
    }

    @Transactional
    public void saveNotification(User user, DDayEntity dDayEntity) {
        // 일주일, 하루전, 당일
        for (Integer day : pushDays) {
            NotificationEntity notificationEntity = new NotificationEntity();
            notificationEntity.setUserToken(user.getToken());
            notificationEntity.setDeviceToken(user.getDeviceToken());
            notificationEntity.setDdayId(dDayEntity.getId());
            notificationEntity.setPushDatetime(dDayEntity.getDdayDate().minusDays(day));
            notificationRepository.save(notificationEntity);
        }
    }

    public boolean isNotiOn(String userToken, Long ddayId) {
        return notificationRepository.existsByDdayIdAndUserToken(ddayId, userToken);
    }

    public void deleteNotificationByDDayId(Long ddayId) {
        notificationRepository.deleteByDdayId(ddayId);
    }

    @Transactional
    public void deleteNotificationByDDayIdAndUserToken(Long ddayId, String userToken) {
        notificationRepository.deleteByDdayIdAndUserToken(ddayId, userToken);
    }

    public void deleteNotificationByUserToken(String userToken) {
        notificationRepository.deleteByUserToken(userToken);
    }

    public void sendNotification() {
        sendNotification(getTodayNotification());
    }

    public List<NotificationEntity> getTodayNotification() {
        LocalDate today = LocalDate.now();
        List<NotificationEntity> notifications = notificationRepository
                .findAllByPushDatetimeBetween(LocalDateTime.of(today, LocalTime.of(0, 0)),
                        LocalDateTime.of(today, LocalTime.of(23, 59)));
        return notifications;
    }

    public void sendNotification(List<NotificationEntity> notifications) {

        Map<String, List<NotificationEntity>> notis = notifications
                .stream()
                .collect(Collectors.groupingBy(NotificationEntity::getUserToken));


        LocalDateTime now = LocalDateTime.now();
        notis.entrySet()
                .stream()
                .forEach(it -> {
                    String token = it.getKey();
                    UserEntity userEntity = userRepository.findByToken(token).get();

                    if (!userEntity.isNotiYn()) return;
                    List<NotificationEntity> notificationEntities = it.getValue();

                    List<NotificationEntity> entities = notificationEntities
                            .stream()
                            .filter(day -> dDayFollowRepository.existsByDdayIdAndUserToken(day.getDdayId(), token))
                            .distinct()
                            .collect(Collectors.toList());

                    for (NotificationEntity entity : entities) {
                        DDayEntity dayEntity = dayRepository.findById(entity.getDdayId()).get();
                        StringBuilder sb = new StringBuilder();
                        if (dayEntity.getDdayDate().minusDays(7).getDayOfMonth() == now.getDayOfMonth()) {
                            sb.append("참여중인 디데이").append(dayEntity.getTitle()).append("이 일주일밖에 안남았어요.");
                        } else if (dayEntity.getDdayDate().minusDays(1).getDayOfMonth() == now.getDayOfMonth()) {
                            sb.append("참여중인 디데이").append(dayEntity.getTitle()).append("이 내일이에요. 기대되지 않나요?");
                        } else {
                            sb.append("드디어 오늘 기다리던").append(dayEntity.getTitle()).append("날 입니다. 설레는 하루 보내세요");
                        }

                        send(userEntity.getDeviceToken(), sb.toString(), entity.getDdayId());
                        log.info("token : " + token + "message : " + sb.toString());
                    }

                });

    }

    public void send(String token, String body, Long id) {
        Message message = Message.builder()
                .setToken(token)
                .setNotification(new Notification("데이데이", body))
                .putData("ddayId", id.toString())
                .putData("click_action", "FLUTTER_NOTIFICATION_CLICK")
                .build();
        try {
            String res = FirebaseMessaging.getInstance().send(message);
            System.out.println(res);
        } catch (Exception e) {
            log.error("send notification failed");
        }
    }
}
