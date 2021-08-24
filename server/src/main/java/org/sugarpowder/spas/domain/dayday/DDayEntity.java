package org.sugarpowder.spas.domain.dayday;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.elasticsearch.annotations.Document;
import org.sugarpowder.spas.domain.shared.DateAudit;
import org.sugarpowder.spas.domain.tag.TagEntity;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "dday")
@Setter
@Getter
@AllArgsConstructor
@JsonIdentityInfo(generator = ObjectIdGenerators.UUIDGenerator.class)
@Document(indexName = "dday")
public class DDayEntity extends DateAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String token;

    private String title;   //제목

    private String emoji;   //이모지

    @Column(name = "d_day_datetime")
    private LocalDateTime ddayDate;         // 날짜

    private String place;  // 장소

    private String color;  // 색상

    @Enumerated(EnumType.STRING)
    @Column(name = "d_day_type")
    private DDayType dayType;  //접근 권한

    @OneToMany(mappedBy = "dday", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @Builder.Default
    private Set<TagEntity> tagEntities;  //카테고리 태그

    private String dDayDescription; // 설명

    public DDayEntity() {

    }

    public DDayEntity(Long id, String token, String title, String emoji, LocalDateTime ddayDate, String color) {
        this.id = id;
        this.token = token;
        this.title = title;
        this.emoji = emoji;
        this.ddayDate = ddayDate;
        this.color = color;
    }

    public static DDayEntity of(DDay.Create dday) {
        DDayEntity dDayEntity = new DDayEntity();
        dDayEntity.setToken(dday.getToken());
        dDayEntity.setTitle(dday.getTitle());
        dDayEntity.setEmoji(dday.getEmoji());
        dDayEntity.setDdayDate(dday.getDate());
        dDayEntity.setPlace(dday.getPlace());
        dDayEntity.setColor(dday.getColor());
        dDayEntity.setDayType(dday.getDDayType());
        dDayEntity.setDDayDescription(dday.getDescription());

        Set<TagEntity> tags = new HashSet<>();
        dday.getTags().forEach((it) -> {
            TagEntity tagEntity = new TagEntity();
            tagEntity.setDday(dDayEntity);
            tagEntity.setName(it);
            tags.add(tagEntity);
        });

        dDayEntity.setTagEntities(tags);
        return dDayEntity;
    }

    public void update(DDay.Update dday) {
        this.setTitle(dday.getTitle());
        this.setEmoji(dday.getEmoji());
        this.setDdayDate(dday.getDate());
        this.setPlace(dday.getPlace());
        this.setDDayDescription(dday.getDescription());
        Set<TagEntity> tags = new HashSet<>();
        dday.getTags().forEach((it) -> {
            TagEntity tagEntity = new TagEntity();
            tagEntity.setDday(this);
            tagEntity.setName(it);
            tags.add(tagEntity);
        });

        this.setTagEntities(tags);
    }
}
