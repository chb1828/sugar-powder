package org.sugarpowder.spas.domain.dayday;

import emoji4j.EmojiUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.sugarpowder.spas.domain.comment.CommentRepository;
import org.sugarpowder.spas.domain.dayday.follow.DDayFollowEntity;
import org.sugarpowder.spas.domain.dayday.follow.DDayFollowRepository;
import org.sugarpowder.spas.domain.dayday.report.DDayReportEntity;
import org.sugarpowder.spas.domain.dayday.report.DDayReportRepository;
import org.sugarpowder.spas.domain.noti.NotificationRepository;
import org.sugarpowder.spas.domain.noti.NotificationService;
import org.sugarpowder.spas.domain.search.SearchRepository;
import org.sugarpowder.spas.domain.search.SearchVO;
import org.sugarpowder.spas.domain.tag.TagEntity;
import org.sugarpowder.spas.domain.tag.TagRepository;
import org.sugarpowder.spas.domain.user.User;
import org.sugarpowder.spas.domain.user.UserRepository;
import org.sugarpowder.spas.domain.user.UserService;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class DDayService {

    private final DDayRepository dayRepository;
    private final DDayReportRepository dayReportRepository;
    private final TagRepository tagRepository;
    private final DDayFollowRepository dayFollowRepository;
    private final CommentRepository commentRepository;
    private final SearchRepository searchRepository;
    private final NotificationService notificationService;
    private final UserService userService;
    private final List<String> faceEmoji = Arrays.asList(
            "smile", "smiley", "grinning", "blush", "relaxed", "wink", "heart_eyes",
            "kissing_heart", "kissing_closed_eyes", "kissing", "kissing_smiling_eyes",
            "stuck_out_tongue_winking_eye", "stuck_out_tongue_closed_eyes", "stuck_out_tongue",
            "flushed", "grin", "pensive", "relieved", "unamused", "disappointed",
            "persevere", "cry", "joy", "sob", "sleepy", "disappointed_relieved", "cold_sweat",
            "sweat_smile", "sweat", "weary", "tired_face", "fearful", "scream",
            "angry", "rage", "triumph", "confounded", "laughing", "yum", "mask", "sunglasses",
            "sleeping", "dizzy_face", "astonished", "worried", "frowning", "anguished",
            "open_mouth", "grimacing", "neutral_face", "confused", "hushed", "no_mouth", "innocent"
    );

    final int faceEmojiLength = faceEmoji.size();
    final Random random = new Random();

    public DDayService(DDayRepository dayRepository, DDayReportRepository dayReportRepository, TagRepository tagRepository, DDayFollowRepository dayFollowRepository, CommentRepository commentRepository, SearchRepository searchRepository, NotificationRepository notificationRepository, UserRepository userRepository, NotificationService notificationService, UserService userService) {
        this.dayRepository = dayRepository;
        this.dayReportRepository = dayReportRepository;
        this.tagRepository = tagRepository;
        this.dayFollowRepository = dayFollowRepository;
        this.commentRepository = commentRepository;
        this.searchRepository = searchRepository;
        this.notificationService = notificationService;
        this.userService = userService;
    }

    public DDayEntity getDdayById(Long id) {
        return dayRepository.findById(id).orElseThrow(() -> {
            throw new IllegalArgumentException("not exists dday");
        });
    }

    public Long countFollower(Long id) {
        return dayFollowRepository.countByDdayId(id);
    }

    public DDayEntity saveDday(DDay.Create dday) {
        userService.getUser(dday.getToken());

        if (dday.getEmoji().isEmpty()) {
            dday.setEmoji(EmojiUtils.getEmoji(faceEmoji.get(random.nextInt(faceEmojiLength))).getEmoji());
        }

        DDayEntity dDayEntity = DDayEntity.of(dday);
        DDayEntity result = dayRepository.save(dDayEntity);
        searchRepository.save(SearchVO.of(dDayEntity));
        followDday(result.getToken(), result, result.getId());
        return result;
    }

    public List<DDayEntity> findByToken(String token) {
        return dayRepository.findByToken(token);
    }

    @Transactional
    public DDayEntity updateDday(Long id, String token, DDay.Update dday) {
        DDayEntity target = getDdayById(id);

        if (!target.getToken().equals(token)) throw new IllegalArgumentException("not authorized dday");

        target.getTagEntities().forEach(tagRepository::delete);

        SearchVO searchVO = searchRepository.findById(id).orElseThrow(() -> {
            throw new IllegalArgumentException("not exists dday");
        });

        updateDdayType(id, token, target, dday.getDDayType());
        target.update(dday);
        searchVO.update(target);
        return target;
    }

    @Transactional
    public DDayEntity updateDdayType(Long id, String token, DDayEntity target, DDayType type) {
        target.setDayType(type);
        switch (type) {
            case PUBLIC:
                break;
            case PRIVATE:
                dayFollowRepository.deleteAllByDdayId(id);
                commentRepository.deleteByDdayId(id);
                dayFollowRepository.flush();
                notificationService.deleteNotificationByDDayId(id);
                followDday(token, target, id);
                break;
            default:
                throw new IllegalArgumentException("no allowed dday type");
        }

        return target;
    }

    @Transactional
    public void deleteDday(DDayEntity entity) {
        Long id = entity.getId();
        dayFollowRepository.deleteAllByDdayId(id);
        tagRepository.deleteBydday(entity);
        searchRepository.deleteById(id);
        notificationService.deleteNotificationByDDayId(id);
        dayRepository.deleteById(id);
    }

    @Transactional
    public void deleteFollowDdays(String userToken) {
        dayFollowRepository.deleteByUserToken(userToken);
        notificationService.deleteNotificationByUserToken(userToken);
    }

    public void followDday(String userToken, DDayEntity dDayEntity, Long ddayId) {
        getDdayById(ddayId);

        DDayFollowEntity followEntity = new DDayFollowEntity();
        followEntity.setUserToken(userToken);
        followEntity.setDdayId(ddayId);

        dayFollowRepository.save(followEntity);

        User user = userService.getUser(userToken);

        if (user.getNotiYn()) {
            notificationService.saveNotification(user, dDayEntity);
        }
    }

    public boolean isFollowed(String userToken, Long ddayId) {
        return dayFollowRepository.existsByDdayIdAndUserToken(ddayId, userToken);
    }

    @Transactional
    public void unFollowDday(String userToken, Long ddayId) {
        DDayEntity dDayEntity = getDdayById(ddayId);
        if (dDayEntity.getToken().equals(userToken)) {
            throw new IllegalArgumentException("dday creator cannot unfollow");
        }

        dayFollowRepository.deleteByUserTokenAndAndDdayId(userToken, ddayId);
        notificationService.deleteNotificationByDDayIdAndUserToken(ddayId, userToken);
    }

    public DDayList getUserFollowedDDays(String userToken, PageRequest page, DaySort daySort, boolean isIncludeEnd) {
        userService.getUser(userToken);
        List<DDayFollowEntity> followEntities = dayFollowRepository.findAllByUserToken(userToken);
        LocalDateTime now = LocalDateTime.now();

        List<DDay> ddays = followEntities
                .stream()
                .map(it ->
                        dayRepository.findById(it.getDdayId())
                )
                .filter(Optional::isPresent)
                .map(Optional::get)
                .filter(it -> {
                    if (!isIncludeEnd) return it.getDdayDate().plusDays(1).isAfter(now);
                    else return true;
                })
                .map(it ->
                        DDay.of(it, userToken, dayFollowRepository.countByDdayId(it.getId()), userService.getUser(it.getToken()).getNickname())
                )
                .sorted((a, b) -> {
                    int comp = 0;
                    switch (daySort) {
                        case FOLLOW_COUNT:
                            comp = b.getFollowerCount().compareTo(a.getFollowerCount());
                            break;
                        case NEAREST:
                            comp = a.getDate().compareTo(b.getDate());
                            break;
                        default:
                            comp = a.getCreatedDate().compareTo(b.getCreatedDate());
                            break;

                    }

                    return comp;
                })
                .skip(page.getPageNumber() * page.getPageSize())
                .limit(page.getPageSize())
                .collect(Collectors.toList());

        return new DDayList(ddays, page);
    }

    public void reportDDay(String userToken, Long ddayId) {
        DDayReportEntity reportEntity = new DDayReportEntity();
        reportEntity.setUserToken(userToken);
        reportEntity.setDdayId(ddayId);
        dayReportRepository.save(reportEntity);


    }

    public int countDdayReport(Long ddayId) {
        return dayReportRepository.countByDdayId(ddayId);
    }

    public List<DDayEntity> getDdayByMonth(int month, int page, int size) {
        LocalDateTime nowDatetime = LocalDateTime.now();

        int year = nowDatetime.getYear();

        if (nowDatetime.getMonth().getValue() > month) {
            year++;
        }

        LocalDate startDate = LocalDate.of(year, month, 1);
        LocalDate endDate = LocalDate.of(year, month, startDate.lengthOfMonth());

        LocalDateTime startTime = LocalDateTime.of(startDate, LocalTime.of(0, 0, 0));
        LocalDateTime endTime = LocalDateTime.of(endDate, LocalTime.of(23, 59, 59));

        return dayRepository.findByDayTypeAndDdayDateBetween(DDayType.PUBLIC, startTime, endTime, PageRequest.of(page, size))
                .stream()
                .sorted(Comparator.comparing(DDayEntity::getDdayDate))
                .collect(Collectors.toList());
    }

    public List<DDayEntity> getTodayDDay() {
        LocalDate nowDatetime = LocalDate.now();

        LocalDateTime startTime = LocalDateTime.of(nowDatetime, LocalTime.of(0, 0, 0));
        LocalDateTime endTime = LocalDateTime.of(nowDatetime.plusDays(7), LocalTime.of(23, 59, 59));

        return dayRepository.findByDayTypeAndDdayDateBetween(DDayType.PUBLIC, startTime, endTime);
    }

    public List<DDay> getPopularDDay(String token) {
        LocalDate nowDatetime = LocalDate.now();
        LocalDate oneYearLater = LocalDate.of(nowDatetime.getYear() + 1, nowDatetime.getMonth(), nowDatetime.getDayOfMonth());

        LocalDateTime startTime = LocalDateTime.of(nowDatetime, LocalTime.of(0, 0, 0));
        LocalDateTime endTime = LocalDateTime.of(oneYearLater, LocalTime.of(23, 59, 59));
        List<DDay> days = dayRepository.findByDayTypeAndDdayDateBetween(DDayType.PUBLIC, startTime, endTime)
                .stream()
                .map(it -> DDay.of(it, token, dayFollowRepository.countByDdayId(it.getId()), userService.getUser(it.getToken()).getNickname()))
                .sorted()
                .limit(20)
                .collect(Collectors.toList());

        List<DDay> result = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            result.add(days.remove(random.nextInt(days.size())));
        }

        return result.stream().sorted().collect(Collectors.toList());
    }

    public List<String> getPolularTag() {

        LocalDateTime now = LocalDateTime.now();

        Map<String, Long> tagCount = tagRepository.findAll()
                .stream()
                .filter(it -> it.getDday().getDdayDate().isAfter(now) && it.getDday().getDayType().equals(DDayType.PUBLIC))
                .collect(Collectors.groupingBy(TagEntity::getName, Collectors.counting()));

        return tagCount.entrySet()
                .stream()
                .sorted((a, b) -> (int) (b.getValue() - a.getValue()))
                .map(it -> it.getKey())
                .collect(Collectors.toList());
    }
}
