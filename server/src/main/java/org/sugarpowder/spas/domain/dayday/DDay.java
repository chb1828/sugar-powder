package org.sugarpowder.spas.domain.dayday;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.sugarpowder.spas.domain.shared.dto.ApiResult;
import org.sugarpowder.spas.domain.tag.TagEntity;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.stream.Collectors;

@Data
@ApiModel
public class DDay extends ApiResult implements Comparable<DDay> {

    private Long id;
    private String title;
    private String emoji;
    private LocalDateTime createdDate;
    private LocalDateTime date;
    private String place;
    private String color;
    private DDayType dDayType;
    private String description;
    private String ownerNickname;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long followerCount;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private boolean isNoti;
    private boolean isOwner;
    private Set<String> tags;

    public static DDay of(DDayEntity dDayEntity, String token, Long followerCount, String ownerNickname) {
        DDay dday = new DDay();
        dday.setId(dDayEntity.getId());
        dday.setTitle(dDayEntity.getTitle());
        dday.setEmoji(dDayEntity.getEmoji());
        dday.setCreatedDate(dDayEntity.getCreatedDate());
        dday.setDate(dDayEntity.getDdayDate());
        dday.setPlace(dDayEntity.getPlace());
        dday.setColor(dDayEntity.getColor());
        dday.setDDayType(dDayEntity.getDayType());
        dday.setDescription(dDayEntity.getDDayDescription());
        dday.setOwnerNickname(ownerNickname);
        dday.setOwner(token.equals(dDayEntity.getToken()));
        dday.setFollowerCount(followerCount);
        dday.setTags(dDayEntity.getTagEntities().stream().map(TagEntity::getName).collect(Collectors.toSet()));
        dday.isNoti = false;
        return dday;
    }

    public static DDay of(DDayEntity dDayEntity, String token, Long followerCount, String ownerNickname, boolean isNoti) {
        DDay dday = new DDay();
        dday.setId(dDayEntity.getId());
        dday.setTitle(dDayEntity.getTitle());
        dday.setEmoji(dDayEntity.getEmoji());
        dday.setCreatedDate(dDayEntity.getCreatedDate());
        dday.setDate(dDayEntity.getDdayDate());
        dday.setPlace(dDayEntity.getPlace());
        dday.setColor(dDayEntity.getColor());
        dday.setDDayType(dDayEntity.getDayType());
        dday.setDescription(dDayEntity.getDDayDescription());
        dday.setOwnerNickname(ownerNickname);
        dday.setOwner(token.equals(dDayEntity.getToken()));
        dday.setFollowerCount(followerCount);
        dday.setTags(dDayEntity.getTagEntities().stream().map(TagEntity::getName).collect(Collectors.toSet()));
        dday.isNoti = isNoti;
        return dday;
    }

    @Data
    @ApiModel(value = "DDay.Create")
    public static class Create {
        @NotNull
        private String title;

        @NotNull
        private String token;

        @NotNull
        private String emoji;

        @NotNull
        private LocalDateTime date;

        private String place;

        @NotNull
        private String color;

        @NotNull
        private DDayType dDayType;

        private String description;

        private Set<String> tags;
    }

    @Data
    @ApiModel(value = "DDay.Update")
    public static class Update {
        @NotNull
        private Long id;

        @NotNull
        private String title;

        @NotNull
        private String emoji;

        @NotNull
        private LocalDateTime date;

        private String place;

        @NotNull
        private String color;

        @NotNull
        private DDayType dDayType;

        private String description;

        private Set<String> tags;
    }

    @Override
    public int compareTo(DDay o) {
        int comp = o.getFollowerCount().compareTo(this.getFollowerCount());

        if (comp > 0) return 1;
        else if (comp < 0) return -1;
        else {
            return this.getDate().compareTo(o.getDate());
        }
    }
}
