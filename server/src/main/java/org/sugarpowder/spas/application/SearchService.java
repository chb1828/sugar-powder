package org.sugarpowder.spas.application;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.sugarpowder.spas.domain.dayday.*;
import org.sugarpowder.spas.domain.dayday.follow.DDayFollowRepository;
import org.sugarpowder.spas.domain.search.SearchRepository;
import org.sugarpowder.spas.domain.user.UserService;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SearchService {

    private final DDayService dayService;
    private final SearchRepository searchRepository;
    private final UserService userService;
    private final DDayFollowRepository dDayFollowRepository;

    public SearchService(DDayService dayService, SearchRepository searchRepository, UserService userService, DDayFollowRepository dDayFollowRepository) {
        this.dayService = dayService;
        this.searchRepository = searchRepository;
        this.userService = userService;
        this.dDayFollowRepository = dDayFollowRepository;
    }

    public List<DDaySearch> searchDdayByQuery(String token, String query, int page, int size) {
        Long currentTimeMillis = LocalDateTime.now().atZone(ZoneId.of("Asia/Seoul")).toEpochSecond();

        List<DDaySearch> searchList =
                searchRepository.findBy(currentTimeMillis, "*" + query + "*", PageRequest.of(page, size))
                .stream()
                .filter(it -> dayService.getDdayById(it.getId()).getDayType().equals(DDayType.PUBLIC))
                .map(it -> DDaySearch.of(it, token, dayService.countFollower(it.getId())))
                .collect(Collectors.toList());

        return searchList;
    }

    public List<DDay> searchDdayByMonth(String token, int month, int page, int size) {
        return dayService.getDdayByMonth(month, page, size)
                .stream()
                .map(it -> DDay.of(it, token, null, userService.getUser(it.getToken()).getNickname()))
                .filter(it -> it.getDDayType().equals(DDayType.PUBLIC))
                .collect(Collectors.toList());
    }

    public List<DDay> getTodaysPopularDday(String token) {
        return dayService.getTodayDDay()
                .stream()
                .map(it -> DDay.of(it, token, dDayFollowRepository.countByDdayId(it.getId()), userService.getUser(it.getToken()).getNickname()))
                .sorted(Comparator.comparing(DDay::getFollowerCount))
                .limit(3)
                .collect(Collectors.toList());
    }

    public List<DDay> getPopularDday(String token) {
        return dayService.getPopularDDay(token);
    }

    public List<String> getPopularTag() {
        return dayService.getPolularTag();
    }
}
