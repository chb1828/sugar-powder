package org.sugarpowder.spas.domain.dayday;


import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.sugarpowder.spas.domain.search.SearchVO;
import org.sugarpowder.spas.domain.shared.dto.ApiResult;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.TimeZone;

@Data
@ApiModel
public class DDaySearch extends ApiResult {
    private Long id;
    private String title;
    private String emoji;
    private LocalDateTime date;
    private String color;
    private boolean isOwner;
    private Long followerCount;

    public static DDaySearch of(DDayEntity dDayEntity, String token, Long followerCount) {
        DDaySearch dDaySearch = new DDaySearch();
        dDaySearch.setId(dDayEntity.getId());
        dDaySearch.setTitle(dDayEntity.getTitle());
        dDaySearch.setEmoji(dDayEntity.getEmoji());
        dDaySearch.setDate(dDayEntity.getDdayDate());
        dDaySearch.setColor(dDayEntity.getColor());
        dDaySearch.setOwner(token.equals(dDayEntity.getToken()));
        dDaySearch.setFollowerCount(followerCount);
        return dDaySearch;
    }

    public static DDaySearch of(SearchVO dDayEntity, String token, Long followerCount) {
        DDaySearch dDaySearch = new DDaySearch();
        dDaySearch.setId(dDayEntity.getId());
        dDaySearch.setTitle(dDayEntity.getTitle());
        dDaySearch.setEmoji(dDayEntity.getEmoji());
        dDaySearch.setDate(LocalDateTime.ofInstant(Instant.ofEpochMilli(dDayEntity.getDate() * 1000), TimeZone.getTimeZone("Asia/Seoul").toZoneId()));
        dDaySearch.setColor(dDayEntity.getColor());
        dDaySearch.setOwner(token.equals(dDayEntity.getToken()));
        dDaySearch.setFollowerCount(followerCount);
        return dDaySearch;
    }




}
