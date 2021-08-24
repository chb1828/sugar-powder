package org.sugarpowder.spas.domain.search;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.elasticsearch.annotations.Document;
import org.sugarpowder.spas.domain.dayday.DDayEntity;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Set;
import java.util.stream.Collectors;

@Data
@Document(indexName = "dday")
@NoArgsConstructor
@AllArgsConstructor
public class SearchVO {
    private Long id;
    private String token;
    private String emoji;
    private String title;
    private String description;
    private String color;
    private Long date;
    private Set<String> tags;

    @Override
    public String toString() {
        return "SearchVO{" +
                "id=" + id +
                ", token='" + token + '\'' +
                ", emoji='" + emoji + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", color=" + color +
                ", date=" + date +
                ", tags=" + tags +
                '}';
    }

    public static SearchVO of(DDayEntity dayEntity) {
        SearchVO searchVO = new SearchVO();
        searchVO.setId(dayEntity.getId());
        searchVO.setToken(dayEntity.getToken());
        searchVO.setEmoji(dayEntity.getEmoji());
        searchVO.setTitle(dayEntity.getTitle());
        searchVO.setColor(dayEntity.getColor());
        searchVO.setDescription(dayEntity.getDDayDescription());
        ZonedDateTime zdt = dayEntity.getDdayDate().atZone(ZoneId.of("Asia/Seoul"));

        searchVO.setDate(zdt.toEpochSecond());
        searchVO.setTags(dayEntity.getTagEntities().stream().map(it -> it.getName()).collect(Collectors.toSet()));
        return searchVO;
    }

    public void update(DDayEntity dayEntity) {
        this.setId(dayEntity.getId());
        this.setToken(dayEntity.getToken());
        this.setEmoji(dayEntity.getEmoji());
        this.setTitle(dayEntity.getTitle());
        this.setColor(dayEntity.getColor());
        this.setDescription(dayEntity.getDDayDescription());
        ZonedDateTime zdt = dayEntity.getDdayDate().atZone(ZoneId.of("Asia/Seoul"));

        this.setDate(zdt.toEpochSecond());
        this.setTags(dayEntity.getTagEntities().stream().map(it -> it.getName()).collect(Collectors.toSet()));
    }
}
